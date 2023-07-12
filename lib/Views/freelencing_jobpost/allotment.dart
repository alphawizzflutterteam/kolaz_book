

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kolazz_book/Models/alloted_jobs_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
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



  String? userId;
  String? pdfUrl;

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
    print("thisbis is request ${request.fields}");

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

  downloadPdfs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(downloadAllottedJobPdfApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = id!;
    request.fields[RequestKeys.type] = 'jobs' ;
    request.fields[RequestKeys.filter] =
    currentindex == 0 ? 'all' : 'upcomings';
    var response = await request.send();
    print("this is pdf download requests ${request.fields}");
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      pdfUrl = userData['url'];
    });
    _showPdf(pdfUrl);
    print("this is our html content $pdfUrl");
    // downloadPdfs();
  }

  _showPdf(pdf) async {
    print("this is my url $pdf");
    var url = pdf.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: "Could not open this pdf!");
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgruond,
      bottomSheet :  Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () async {
                  downloadPdfs();
                },
                child: Image.asset(
                  "assets/images/pdf.png",
                  scale: 1.6,
                )),
          ],
        ),
      ),
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
