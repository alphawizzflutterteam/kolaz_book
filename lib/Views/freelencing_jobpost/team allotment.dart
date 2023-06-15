

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../Utils/colors.dart';
import '../Add_Quotation/MoreQuatations.dart';
import '../freelancing_job/add_newJob.dart';
import '../freelancing_job/edit_job.dart';

class TeamAllotment extends StatefulWidget {
  const TeamAllotment({Key? key}) : super(key: key);

  @override
  State<TeamAllotment> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<TeamAllotment> {

  bool isClickable = true;
  bool isSelected = false;


  Widget _allDates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightwhite),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order Date", style: TextStyle(color: AppColors.textclr),),
                Text("Event", style: TextStyle(color: AppColors.textclr)),
                Text("Photographer", style: TextStyle(color: AppColors.textclr)),

                Text("Venue", style: TextStyle(color: AppColors.textclr)),
                Text("Job Id", style: TextStyle(color: AppColors.textclr)),

              ],
            ),
          ),
        ),
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.lightwhite),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("02/May/2023", style: TextStyle(color: AppColors.textclr,fontSize: 10),),
                Text("Wedding", style: TextStyle(color: AppColors.textclr,fontSize: 10)),

                Text("Ramesh Khan", style: TextStyle(color: AppColors.textclr,fontSize: 12)),

                Text("Mumbai", style: TextStyle(color: AppColors.textclr,fontSize: 10)),
                Text("FJ 001", style: TextStyle(color: AppColors.textclr,fontSize: 10)),

              ],
            ),
          ),
        ),


      ],
    );
  }

  Widget _upcomingDates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [



      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Center(child: Text(" Team Allotment ",
                style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
            )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Client  - ",style: TextStyle(color: AppColors.textclr,fontSize: 20,fontWeight: FontWeight.bold),),
                  Text("Kinjal Patel",style: TextStyle(color: AppColors.textclr,fontSize: 20,fontWeight: FontWeight.bold),),
                ],
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelected = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),

                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff8B8B8B)
                      ),
                      child: const Center(child: Text("All Dates", style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16))),
                    ),
                  ),
                  SizedBox(width: 15,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => NextPage(),
                        // ));
                        isSelected = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),

                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.AppbtnColor
                      ),
                      child: const Center(child: Text("Upcoming Dates", style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),)),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15,),
              isSelected ? _allDates() : _upcomingDates(),

            ],
          ),
        ),
      ),
    );
  }
}
