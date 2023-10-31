import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'awareness.dart';

class news extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return news_State();
  }
}


class news_State extends State<news> {
  List news=[],imageurl=[];
  void getData() async
  {
  CollectionReference News=  await FirebaseFirestore.instance
        .collection('News');
    News.get().then((value) {
        value.docs.forEach((element) {
          setState(() {
            news.add(element.data());
            imageurl.add(element.get('image'));
            print(imageurl);
          });
        });
    });
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
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.01, top: height * 0.01),
                    child: Text(
                      "News",
                      style: TextStyle(
                          color: Color(0xf0115228),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    )),
                Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.01, top: height * 0.02),
                    child: Text(
                      "Trending",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
                for (int i = 0; i <news.length; i++)
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height * 0.01),
                          child: imageurl[i]==""
                              ?  Image.asset(
                            "image/second news.png",
                            height: height * 0.25,
                            width: width,
                            fit: BoxFit.cover,
                          ):
                          Image.network(
                            imageurl[i],
                            height: height * 0.25,
                            width: width,
                            fit: BoxFit.cover,
                          )
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.01, top: height * 0.01),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(builder: (_) {
                                    return Scaffold(
                                      body: SafeArea(
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, top: 60),
                                            child: Text(
                                              "${news[i]['news']}",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                                },
                                child: Text(
                                  "${news[i]['title']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ))),
                      ],
                    ),
                  )

              ],
            ),

        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xf0115228),
        items: [
          BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.newspaper),
              ),
              label: "News"),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.near_me_outlined),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
                    return awareness();
                  }));
                },
              ),
              label: "Awareness"),


        ],
      ),
    );
  }
}


