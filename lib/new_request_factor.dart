import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recycle_recover/material_recived_factore.dart';

class new_Req extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new_Req_State();
  }
}

class new_Req_State extends State<new_Req> {
  late String  wood="",glass="",clothe="",namefactor="",plastic="";
  List order=[],nameuser=[],address=[],userid=[];
  void getData()async {
    final factorid = await FirebaseAuth.instance.currentUser!.uid;
    print("$factorid");
    await FirebaseFirestore.instance
        .collection('factores').where('id',isEqualTo: factorid).get().then((value) {
      value.docs.forEach((element) {
        namefactor=element.get('username');
        print("$namefactor");
      });
    });
    CollectionReference userinfo= await FirebaseFirestore.instance.collection("user");
    CollectionReference materailinfo= FirebaseFirestore.instance.collection("recycleable");
    await materailinfo.where('namefactor', isEqualTo: namefactor).get().then((value) {
      value.docs.forEach((element) {
      setState(() {
        print("++++++++++++++++++++++++++++++++++");
          if(element.get('apply')==true)
             {
               userid .add(element.get('iduser'));
               order.add(element.data());
             }
         print("${order}");
       print("${userid}");
      });
      });
    });
    for(int i=0;i<userid.length;i++)
  await userinfo.where('id', isEqualTo: userid[i]).get().then((value) {
        value.docs.forEach((element) {
          setState(() {
            print("+++++++++++++++++++");
            order[i]['username']=element.get('username');
            order[i]['address']=element.get('address');
          });

        });
    });

  }

void deletData(int index) async
 {
   print(userid[index]);

   CollectionReference materailinfo= FirebaseFirestore.instance.collection("recycleable");
   await materailinfo.where('amount', isEqualTo: order[index]['amount']).get().then((value) {
     value.docs.forEach((element) {
         print("+++++++++++++++++++");
         print("${element.id}");
        materailinfo.doc("${element.id}").delete();

     });
   });
 }

 void addpoint (int index) async
 {
   CollectionReference point=FirebaseFirestore.instance.collection('point');
   CollectionReference orders=FirebaseFirestore.instance.collection("Order");
   await point.where('id',isEqualTo: userid[index]).get().then((value) => value.docs.forEach((element) {
     print(element.id);
     point.doc(element.id).update({
      "apply": true
     });
   }));
   await orders.where('iduser',isEqualTo: userid[index]).get().then((value) => value.docs.forEach((element) {
     print(element.id);
     orders.doc(element.id).update({
       "applyfactor": true
     });
   }));
 }
  void initState() {
    getData();
    super.initState();
  }
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "New Request",
          style: TextStyle(
              color: Color(0xf0115228),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 1),
          child:IconButton(onPressed: () { Navigator.of(context).pop(); },icon :Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),)
        ),
      ),
      body: ListView.builder(itemCount: order.length, itemBuilder:(context,index){
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: Text(
                  "Material Type : \n ${order[index]['material']}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: width * 0.39),
                child: Text("Username : ${order[index]['username']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Padding(
                padding:  EdgeInsets.only(left: 10,right: width * 0.39 ,top: 10 ),
                child: Text("Location : ${order[index]['address']}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Padding(
                padding:  EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    Container(
                        color: Colors.white,
                        width: width / 3,
                        height: height/9,
                        child: ElevatedButton(
                            onPressed: ()  {
                              if(nameuser!="")
                              {
                                addpoint(index);
                                deletData(index);
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                                  return recived();
                                }));
                              }
                            },
                            child:Image.asset("image/t.jpg"),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.transparent;
                                else
                                  return Colors.white;
                              }),
                            ))),
                    SizedBox(
                      width: 40,
                    ),
                    Container(
                      color: Colors.white,
                      width: width / 3,
                      height: height/9,
                      child: ElevatedButton(
                          onPressed: ()  {
                            deletData(index);
                          },
                          child:Image.asset("image/false.jpg"),
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.transparent;
                              else
                                return Colors.white;
                            }),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } )
    );
  }
}
