import 'package:flutter/material.dart';

import 'portfolio_screen.dart';

class Third_Screen extends StatefulWidget {
  const Third_Screen({Key? key}) : super(key: key);

  @override
  State<Third_Screen> createState() => _Third_ScreenState();
}

class _Third_ScreenState extends State<Third_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff575656),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              height: 70,
              color: Color(0xff303030),
              child: Padding(
                padding: const EdgeInsets.only(left: 170),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PortfolioScreen()));
                        },
                        child: CircleAvatar()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Gayatri Chouhan",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(
                          "My Portfolio",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 190,
              width: double.infinity,
              child: Stack(children: [
                Container(
                  color: Colors.grey,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    height: 120,
                    width: 360,
                    color: Colors.lightBlue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90, left: 25),
                  child: Container(
                    decoration: BoxDecoration(
                        //shape: BoxShape.circle,
                        //border: Border.all(
                        //color: Colors.blue, // Set the outline border color
                        //width: 1, // Set the outline border width
                        //),
                        ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 28,
                            ),
                            Text(
                              "Ramesh Patel",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                            Text(
                              "City,State,Country",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 80, top: 30),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Category",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                  Text(
                                    "Company Name",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Container(
                                height: 29,
                                width: 29,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3)),
                                child: Image.asset("Images/phone1.png",
                                    fit: BoxFit.cover),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "About (User Name)",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Equipment's/ Camera kit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                "Country Visited",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Center(
              child: Text(
                "Ramesh Patel Official Link",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 30,
                      height: 30,
                      child: Image.asset("Images/Insta.png")),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    child: Icon(Icons.facebook, size: 35),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                        width: 30,
                        height: 30,
                        child: Image.asset("Images/Youtube.png")),
                  ),
                ]),
          ]),
        ),
      ),
    );
  }
}
