import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class add_recycling_content extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return add_recycling_content_state();
  }
}

class add_recycling_content_state extends State<add_recycling_content> {
  late String imageUrl, title="", news="",News_l="Enter News or Awareness",News_t="Enter Tittle News or Awareness";
  bool uploading = false;
  int i = 0;
  late var image = null;
  var  downloadurl="";
  bool N = false, A = false;
  final picker = ImagePicker();

  void addNews() async {
    final _Storage = FirebaseStorage.instance;
    downloadurl = await _Storage.ref()
        .child("News/$title").getDownloadURL();
    CollectionReference News = FirebaseFirestore.instance.collection("News");
    News.add({"title": title, "news": news , "image":downloadurl});

  }

  void addAwareness() async{
    final _Storage = FirebaseStorage.instance;
    downloadurl = await _Storage.ref()
        .child("Awareness/$title").getDownloadURL();
    CollectionReference awareness =
        FirebaseFirestore.instance.collection("Awareness");
    awareness.add({"title": title, "news": news , "image":downloadurl});

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Center(
                  child: image == null
                      ? Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250.0,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage("image/second news.png"),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: IconButton(
                                  icon: Icon(Icons.camera_alt),
                                  iconSize: 37,
                                  color: Colors.white,
                                  onPressed: () {
                                    setState(() {
                                      getImagefromGallery();
                                    });
                                  }),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 250,
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(image),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 200),
                              child: IconButton(
                                icon: Icon(Icons.camera_alt),
                                iconSize: 37,
                                onPressed: () {
                                  setState(() {
                                    getImagefromGallery();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                child: TextField(
                  onChanged: (val) {
                    setState(() {
                      title = val;
                    });
                  },
                  cursorColor: Color(0xff115228),
                  style: TextStyle(
                    color: Color(0xf0115228),
                  ),
                  decoration: InputDecoration(
                      labelStyle: TextStyle(color: Color(0xf0115228)),
                      labelText: News_t,
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: TextField(
                  maxLines: null,
                  onChanged: (val) {
                    setState(() {
                      news = val;
                    });
                  },
                  cursorColor: Color(0xff115228),
                  style: TextStyle(
                    color: Color(0xf0115228),
                  ),
                  decoration: InputDecoration(
                      labelText: News_l,
                      labelStyle: TextStyle(color: Color(0xf0115228)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0, style: BorderStyle.none))),
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20, left: 10),
                  child: Text("Choose News Or Awareness")),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                child: Row(
                  children: [
                    Text("News"),
                    Checkbox(
                        value: N,
                        onChanged: (val) {
                          setState(() {
                            N=val!;
                            if(A==true)
                           A = false;
                            else N=val;
                          });
                        }),
                    Text("Awareness"),
                    Checkbox(
                        value: A,
                        onChanged: (val) {
                          setState(() {
                            A=val!;
                            if (N == true) N = false;
                            else A=val;
                          });
                        })
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 55,
                    margin: EdgeInsets.fromLTRB(50, 20, 50, 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: ElevatedButton(
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.black26;
                            else
                              return Color(0xf0115228);
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(30)))),
                      onPressed: () async {
                        final _Storage = FirebaseStorage.instance;
                        setState(() {
                          uploading = true;
                        });
                        if(news!=""&&title!="") {
                          if (A == true) {
                            var snapshot = await _Storage.ref()
                                .child("Awareness/${title}")
                                .putFile(image)
                                .whenComplete(() {
                              setState(() {
                                uploading = false;
                              });

                            });
                            addAwareness();
                          }
                          if (N == true) {
                            await _Storage.ref()
                                .child("News/$title")
                                .putFile(image)
                                .whenComplete(() {
                              setState(() {
                                uploading = false;
                              });
                              print("uploading Successfully");
                            });
                            addNews();
                          }

                      //    print(news);
                       //   print(title);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Done"),
                                content: Text("uploading Successfully"),
                                actions: [
                                  ElevatedButton (
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              if(N==true || A==true)   {
                              return  AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Please Enter A News or Awareness and Select Image"),
                                  actions: [
                                    ElevatedButton (
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                              else  {
                                return  AlertDialog(
                                  title: Text("Error"),
                                  content: Text("Please Choose News or Awareness"),
                                  actions: [
                                    ElevatedButton (
                                      child: Text("OK"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        }
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  getImagefromGallery() async {
    final pickedfile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedfile != null) {
      setState(() {
        image = File(pickedfile.path);
      });
    } else
      print("No image Selected");
  }

}
