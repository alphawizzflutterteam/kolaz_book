

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../Utils/colors.dart';
import '../Add_Quotation/MoreQuatations.dart';
import '../freelancing_job/add_newJob.dart';
import '../freelancing_job/edit_job.dart';

class freelencingPost extends StatefulWidget {
  const freelencingPost({Key? key}) : super(key: key);

  @override
  State<freelencingPost> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<freelencingPost> {

  bool isClickable = true;
  bool isSelected = false;


  Widget _allJobs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 22),
            // height: 90,
            width: MediaQuery.of(context).size.width/1.1,

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.teamcard2),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Date", style: TextStyle(fontSize: 14, color: Color(0xffFFFFFF))),
                  const SizedBox(width: 5,),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff8B8B8B),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Select Start Date", style: TextStyle(fontSize: 12, color: Color(0xffFFFFFF)),),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.calendar_month, color: Colors.black, size: 20,),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5,),
                  const Text("To",style: TextStyle(fontSize: 14, color: Color(0xffFFFFFF))),
                  const SizedBox(width: 5,),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff8B8B8B),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
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
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.teamcard2,
                borderRadius: BorderRadius.circular(10)),
            // height: 140,
            width: MediaQuery.of(context).size.width/1.1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("28/April/2023",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fuctions",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("Wedding",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time  ",style: TextStyle(color: AppColors.temtextclr),),
                      Text("10 : 12 AM",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Venue",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("Mumbai",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _upcoming() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.only(left: 10.0,right: 10),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 22),
            // height: 90,
            width: MediaQuery.of(context).size.width/1.1,

            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.teamcard2),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Date", style: TextStyle(fontSize: 14, color: Color(0xffFFFFFF))),
                  const SizedBox(width: 5,),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff8B8B8B),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Select Start Date", style: TextStyle(fontSize: 12, color: Color(0xffFFFFFF)),),
                        SizedBox(width: 10,),
                        Icon(
                          Icons.calendar_month, color: Colors.black, size: 20,),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5,),
                  const Text("To",style: TextStyle(fontSize: 14, color: Color(0xffFFFFFF))),
                  const SizedBox(width: 5,),
                  Container(
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff8B8B8B),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text("Select End Date", style: TextStyle(fontSize: 12, color: Color(0xffFFFFFF)),),
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
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.teamcard2,
                borderRadius: BorderRadius.circular(10)),
            // height: 140,
            width: MediaQuery.of(context).size.width/1.1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("28/April/2023",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fuctions",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("Wedding",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time  ",style: TextStyle(color: AppColors.temtextclr),),
                      Text("10 : 12 AM",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Venue",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("Mumbai",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.teamcard2,
                borderRadius: BorderRadius.circular(10)),
            // height: 140,
            width: MediaQuery.of(context).size.width/1.1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("28/April/2023",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Fuctions",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("Wedding",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Time  ",style: TextStyle(color: AppColors.temtextclr),),
                      Text("10 : 12 AM",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Venue",style: TextStyle(color: AppColors.AppbtnColor),),
                      Text("Mumbai",style: TextStyle(color: AppColors.whit),),
                    ],
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),


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
            child: Center(child: Text("Freelancing Jobs",
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
              SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Freelencing Jobs  - ",style: TextStyle(color: AppColors.AppbtnColor,fontSize: 15),),
                  Text("Ramesh Khan",style: TextStyle(color: AppColors.textclr,fontSize: 15),),
                ],
              ),
              SizedBox(height: 15,),
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
                      child: const Center(child: Text("All Jobs", style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16))),
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
                      child: const Center(child: Text("Upcoming Jobs", style: TextStyle(color: Color(0xffFFFFFF), fontSize: 16),)),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15,),
              isSelected ? _allJobs() : _upcoming(),

            ],
          ),
        ),
      ),
    );
  }
}
