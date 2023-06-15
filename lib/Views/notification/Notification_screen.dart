import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../Utils/colors.dart';

class Notification_screen extends StatefulWidget {
  const Notification_screen({Key? key}) : super(key: key);

  @override
  State<Notification_screen> createState() => _Notification_screenState();
}

class _Notification_screenState extends State<Notification_screen> {
  bool _isToggled = false;
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      
      child: Scaffold(backgroundColor: AppColors.backgruond,
        appBar: AppBar(
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
          backgroundColor: Color(0xff303030),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,right: 10),
                  child: const Text("Notification", style: TextStyle(fontSize: 18, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
                  ),
                ),
                Expanded(
                  child:Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: FlutterSwitch(
                      height: 20.0,
                      width: 40.0,
                      padding: 4.0,
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      activeColor: AppColors.AppbtnColor,
                      value: _isToggled,
                      onToggle: (value) {
                        setState(() {
                          _isToggled = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,15,20,10),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Align(alignment: Alignment.topRight,
                  child: SizedBox(height: 30,
                    child: TextButton(onPressed: (){},
                        child: Text("Clear all",style: TextStyle(decoration: TextDecoration.underline,),)),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xff6D6A6A),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Hey (User Name),(Client F+LName,City Name) have outstanding amount 25000 Rs.(Reminder Every 5 dtyas)",
                      style: TextStyle(color: Color(0xffEEB80A)),)),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xff6D6A6A),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Hey (User Name),(Client F+LName,City Name) have outstanding amount 25000 Rs.(Reminder Every 5 dtyas)",
                      style: TextStyle(color: AppColors.whit),)),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xff6D6A6A),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Hey (User Name),(Client F+LName,City Name) have outstanding amount 25000 Rs.(Reminder Every 5 dtyas)",
                      style: TextStyle(color: Color(0xffEEB80A)),)),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xff6D6A6A),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Hey (User Name),(Client F+LName,City Name) have outstanding amount 25000 Rs.(Reminder Every 5 dtyas)",
                      style: TextStyle(color: Color(0xffEEB80A)),)),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xff6D6A6A),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Hey (User Name),(Client F+LName,City Name) have outstanding amount 25000 Rs.(Reminder Every 5 dtyas)",
                      style: TextStyle(color: AppColors.whit),)),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xff6D6A6A),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Hey (User Name),(Client F+LName,City Name) have outstanding amount 25000 Rs.(Reminder Every 5 dtyas)",
                      style: TextStyle(color: Color(0xffEEB80A)),)),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      color: Color(0xff6D6A6A),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text("Hey (User Name),(Client F+LName,City Name) have outstanding amount 25000 Rs.(Reminder Every 5 dtyas)",
                      style: TextStyle(color: AppColors.whit),)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),),
    );
  }
}
