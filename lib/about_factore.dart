import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Account user.dart';
import 'account_factore.dart';


class aboutUs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return aboutus_state();
  }
}

class aboutus_state extends State<aboutUs> {
  late String Email="";
  late String password="";
  late String username="";
  late String phone="";
  late String address="";
  late String id,material="";
  late String workhour="",bio="";
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('factores')
        .where('id', isEqualTo: userid)
        .get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("=============");
          username = element.get('username');
          phone=element.get('phone');
          password = element.get('password');
          address=element.get('address');
          Email=element.get('email');
          material=element.get('material');
          workhour=element.get('workhours');
          bio=element.get('bio');
        });
      });
    });
  }

  void initState() {
    getData();
    super.initState();
  }
  void update() async {
    id= await FirebaseAuth.instance.currentUser!.uid;
    CollectionReference userinfo =
        FirebaseFirestore.instance.collection("factore");
    setState(() {
      print("=================");
      print('$id');
      userinfo.doc(id).set({
        "username": username,
        "email": Email,
        "id": id,
        "phone": phone,
        "address": address,
        "password": password,
        "material": material,
        "workhours":workhour,
        "bio": bio
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "About Us",
            style: TextStyle(
                color: Color(0xf0115228),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
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
                            padding: EdgeInsets.fromLTRB(10, height * 0.01, 10, 10),
                            child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  bio = val;
                                });
                              },
                              cursorColor: Color(0xff115228),
                              style: TextStyle(
                                color: Color(0xf0115228),
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.dashboard,
                                    color: Color(0xf0115228),
                                  ),
                                  labelText: "$bio",
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
                                  material = val;
                                });
                              },
                              cursorColor: Color(0xff115228),
                              style: TextStyle(
                                color: Color(0xf0115228),
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.pages,
                                    color: Color(0xf0115228),
                                  ),
                                  labelText: "$material",
                                  labelStyle: TextStyle(color: Color(0xf0115228)),
                                  filled: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none))),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[A-z]'))
                              ],
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: TextField(
                              onChanged: (val) {
                                setState(() {
                                  workhour = val;
                                });
                              },
                              cursorColor: Color(0xff115228),
                              style: TextStyle(
                                color: Color(0xf0115228),
                              ),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.hourglass_empty_sharp,
                                    color: Color(0xf0115228),
                                  ),
                                  labelText:"$workhour",
                                  labelStyle: TextStyle(color: Color(0xf0115228)),
                                  filled: true,
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none))),
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                              ],
                              keyboardType: TextInputType.number,
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
                                      Email != null) {
                                    update();
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) {
                                      return account_Factor();
                                    }));
                                  }
                                }),
                          )),
                    ])))));
  }
}
