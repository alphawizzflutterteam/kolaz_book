

import 'package:flutter/material.dart';

import '../../Utils/colors.dart';
import '../Amount_screen/add_amount.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<AccountScreen> {

  bool isClickable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddAmountScreen()));
              },
              child: Container(
                height: 40,
                width: 160,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color:AppColors.pdfbtn
                ),
                child: Center(
                  child: Text("Add Amount",
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.whit)),
                ),
              ),
            ),
            Image.asset("assets/images/pdf.png", scale: 2.1,),
          ],
        ),
      ),
      backgroundColor: AppColors.backgruond,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
        backgroundColor: Color(0xff303030),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("(Photographers Name)Account",
                style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
            )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 15),
                  Container(
                    width: 100,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),

                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.AppbtnColor
                    ),
                    child: Center(child: Text("All ", style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16))),
                  ),

                ],
              ),
            ),
            SizedBox(height: 15,),


            Padding(
              padding: const EdgeInsets.only(left: 10.0,right: 10),
              child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width/1.1,

                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff3B3B3B)),
                child: Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Date", style: TextStyle(fontSize: 14, color: Color(0xffFFFFFF))),
                      SizedBox(width: 5,),
                      Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff8B8B8B),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Select Start Date", style: TextStyle(fontSize: 12, color: Color(0xffFFFFFF)),),
                            SizedBox(width: 10,),
                            Icon(
                              Icons.calendar_month, color: Colors.black, size: 20,),
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Text("To",style: TextStyle(fontSize: 14, color: Color(0xffFFFFFF))),
                      SizedBox(width: 5,),
                      Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff8B8B8B),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Select Start Date", style: TextStyle(fontSize: 12, color: Color(0xffFFFFFF)),),
                            SizedBox(width: 10,),
                            Icon(
                              Icons.calendar_month, color: Colors.black, size: 20,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightwhite),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date", style: TextStyle(color: AppColors.textclr),),
                    Text("Discripation", style: TextStyle(color: AppColors.textclr)),
                    Text("Credit", style: TextStyle(color: AppColors.textclr)),
                    Text("Dedit", style: TextStyle(color: AppColors.textclr)),

                  ],
                ),
              ),
            ),
            SizedBox(height: 4,),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightwhite),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date", style: TextStyle(color: AppColors.textclr),),
                    Text("Discripation", style: TextStyle(color: AppColors.textclr)),
                    Text("Credit", style: TextStyle(color: AppColors.textclr)),
                    Text("Dedit", style: TextStyle(color: AppColors.textclr)),

                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/2.3,),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightwhite),
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Outstanding Amount", style: TextStyle(color: AppColors.textclr),),

                    Text("25000  Rs.", style: TextStyle(color: AppColors.textclr)),

                  ],
                ),
              ),
            ),



          ],
        ),
      ),
    );
  }
}
