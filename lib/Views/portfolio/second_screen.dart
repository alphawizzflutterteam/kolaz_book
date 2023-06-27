import 'package:flutter/material.dart';
import 'package:kolazz_book/Views/portfolio/portfolio_screen.dart';


import 'third_screen.dart';

class AddPortfolioScreen extends StatefulWidget {
  const AddPortfolioScreen({Key? key}) : super(key: key);

  @override
  State<AddPortfolioScreen> createState() => _AddPortfolioScreenState();
}

class _AddPortfolioScreenState extends State<AddPortfolioScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff575656),
      body: SingleChildScrollView(
        child: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
        width: double.infinity,
        height: 70,
        color: Color(0xff303030),
        child: Padding(
        padding: const EdgeInsets.only(left: 170),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PortfolioScreen()));
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

          Padding(
            padding: const EdgeInsets.only(left: 150,top: 10),
            child: Text("My Portfolio",style: TextStyle(color: Colors.white),),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
              ),
              Text("Freelancer",style: TextStyle(color: Colors.white),),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Text("Category",style: TextStyle(color: Colors.white),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25,top: 4),
            child: Container(
              width: 310,
              height: 38,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white60,
                  // Set the background color of the TextField
                  filled: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 27,top: 4),
            child: Text("About(User Name)",style: TextStyle(color: Colors.white),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              width: 310,
              height: 70,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white60,
                  // Set the background color of the TextField
                  filled: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Text("Equipments/Camera Kit Details",style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.only(left: 25,),
            child: Container(
              width: 310,
              height: 65,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white60,
                  // Set the background color of the TextField
                  filled: true,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Text("How Many Country You Visited?",style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.only(left: 25,),
            child: Container(
              width: 310,
              height: 38,
              child: TextField(
                decoration: InputDecoration(labelText: "Enter Country Names",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white60,
                  // Set the background color of the TextField
                  filled: true,
                ),
              ),
            ),
          ),
          SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.only(left: 27),
            child: Text("Upload Cover Photo",style: TextStyle(color: Colors.white),),
          ),
          SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.only(left: 25,),
            child: Container(
              width: 310,
              height: 66,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.white60,
                  // Set the background color of the TextField
                  filled: true,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                Text("Who can search you with your free dates",style: TextStyle(color: Colors.white),),

              ],
            ),
          ),
            SizedBox(height: 30,),
          Center(
            child: InkWell(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Third_Screen()));
            },
              child: Container(
                  width: 250,
                  height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text("Update",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600
                  ,letterSpacing:1,color: Colors.white),),
                ),
              ),
            ),
          ),

        ],
    ),
        ),
      ),
    );
  }
}
