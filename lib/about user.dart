import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'Account user.dart';
import 'home_page.dart';

class aboutMe extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return aboutMe_state();
  }
}

class aboutMe_state extends State<aboutMe> {
  late String Email="";
  late String password="";
  late String username="";
  late String phone="";
  late String address="";
  late String id;
  void getData() async{
    final userid = await FirebaseAuth.instance.currentUser!.uid;

    await FirebaseFirestore.instance
        .collection('user')
        .where('id' ,isEqualTo: userid)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          id = element.get('id');
          username = element.get('username');
          phone=element.get('phone');
          password = element.get('password');
          address=element.get('address');
          Email=element.get('email');
        });
      });
    });
  }

  void update() async{
  CollectionReference userinfo= FirebaseFirestore.instance.collection("user");
   setState(() {
     print("=================");
     print('$id');
     userinfo.doc(id).set({
       "username":username,
       "email":Email,
       "id":id,
       "phone":phone,
       "address":address,
       "password":password
     });
   });
}
void delete () async {
  CollectionReference userinfo=await FirebaseFirestore.instance.collection("user");
  userinfo.doc(id).delete();
}
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About Me",
            style: TextStyle(
                color: Color(0xf0115228),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return account();
              }));
            },
            icon: Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Container(
                color: Colors.white,
                height: height,
                width: width,
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: height * 0.05),
                        child: Text("Personal Details",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, height * 0.04, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              username = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline_outlined,
                                color: Color(0xf0115228),
                              ),
                              labelText: "$username",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              Email = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Color(0xf0115228),
                              ),
                              labelText: "$Email",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              phone = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.phone,
                                color: Color(0xf0115228),
                              ),
                              labelText: "$phone",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.phone,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              address = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.home,
                                color: Color(0xf0115228),
                              ),
                              labelText: "$address",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: height * 0.02, bottom: height * 0.02),
                        child: Text("Change Password",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                color: Color(0xf0115228),
                              ),
                              labelText: "$password",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              password = val;
                            });
                          },
                          cursorColor: Color(0xff115228),
                          style: TextStyle(
                            color: Color(0xf0115228),
                          ),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                color: Color(0xf0115228),
                              ),
                              labelText: "$password",
                              labelStyle: TextStyle(color: Color(0xf0115228)),
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  borderSide: const BorderSide(
                                      width: 0, style: BorderStyle.none))),
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: 50,
                            margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0)),
                            child: ElevatedButton(
                                child: Text(
                                  "Send",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      if (states
                                          .contains(MaterialState.pressed))
                                        return Colors.black26;
                                      else
                                        return Color(0xf0115228);
                                    }),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)))),
                                onPressed: () {
                                  if (address != null ||
                                      username != null ||
                                      password != null ||
                                      phone != null ||
                                      Email != null)
                                    {
                                      delete();
                                      update();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(builder: (_) {
                                            return home_Page();
                                          }));
                                    }
                                }),
                          )),
                    ])))));
  }


}
