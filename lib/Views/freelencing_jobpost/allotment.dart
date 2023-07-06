

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kolazz_book/Models/alloted_jobs_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';
import 'package:http/http.dart' as http;

class AllotmentScreen extends StatefulWidget {
  final String? pid;
  const AllotmentScreen({Key? key, this.pid}) : super(key: key);

  @override
  State<AllotmentScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<AllotmentScreen> {

  bool isClickable = true;
  bool isSelected = false;

  int currentindex = 0;

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
                Text("Type Of", style: TextStyle(color: AppColors.textclr)),
                Text("Event", style: TextStyle(color: AppColors.textclr)),
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
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("02/May/2023", style: TextStyle(color: AppColors.textclr,fontSize: 10),),
                SizedBox(width: 20,),
                Text("Candid Photography", style: TextStyle(color: AppColors.textclr,fontSize: 10)),
                SizedBox(width: 10,),

                Text("Wedding", style: TextStyle(color: AppColors.textclr,fontSize: 12)),
                SizedBox(width: 20,),

                Text("Mumbai", style: TextStyle(color: AppColors.textclr,fontSize: 10)),
                SizedBox(width: 35,),
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

  String? userId;

  List<AllotedJobs> getJobs = [];
  getClientJobs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    var uri = Uri.parse(allotedJobsApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = userId!;
    request.fields[RequestKeys.photographerId] = widget.pid!;
    request.fields[RequestKeys.type] = currentindex == 0 ? 'all' :  'upcoming';

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      getJobs = AllotedJobsModel.fromJson(userData).data!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClientJobs();
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
            child: const Icon(Icons.arrow_back_ios, color: AppColors.AppbtnColor)),
        backgroundColor: Color(0xff303030),
        actions: const [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("Photographers Jobs Allotment",
                style: TextStyle(fontSize: 16, color:AppColors.AppbtnColor, fontWeight: FontWeight.bold)
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
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentindex = 0;
                        });
                        getClientJobs();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentindex == 0
                                ? AppColors.AppbtnColor
                                : const Color(0xff8B8B8B)),
                        child: const Center(
                            child: Text("All Jobs",
                                style: TextStyle(
                                    color: Color(0xffFFFFFF),
                                    fontSize: 16))),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentindex = 1;
                        });
                        getClientJobs();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentindex == 1
                                ? AppColors.AppbtnColor
                                : Color(0xff8B8B8B)),
                        child: const Center(
                            child: Text(
                              "Upcoming Jobs",
                              style: TextStyle(
                                  color: Color(0xffFFFFFF), fontSize: 16),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15,),
              Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: ListView.builder(
                    itemCount: getJobs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 2),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          // height: 45,
                          width: MediaQuery.of(context).size.width / 1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightwhite),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width : MediaQuery.of(context).size.width/3 - 20,
                                child: Text(
                                  "${getJobs[index].date}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textclr, fontSize: 15),
                                ),
                              ),
                              Container(
                                width : MediaQuery.of(context).size.width/3 - 20,
                                child: Text(
                                  "${getJobs[index].city}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textclr, fontSize: 15),
                                ),
                              ),
                              Container(
                                width : MediaQuery.of(context).size.width/3  ,
                                child: Text(
                                  "${getJobs[index].cName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textclr, fontSize: 15),
                                ),
                              ),
                            ],
                          )
                        ),
                      );
                    },
                  ))

            ],
          ),
        ),
      ),
    );
  }
}
