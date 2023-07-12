import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:kolazz_book/Controller/home_controller.dart';
import 'package:kolazz_book/Models/get_client_jobs_model.dart';
import 'package:kolazz_book/Models/get_freelancer_jobs_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Utils/colors.dart';
import '../Add_Quotation/MoreQuatations.dart';
import '../Add_Quotation/edite_client_job.dart';
import '../freelancing_job/add_freelance_job.dart';
import '../freelancing_job/edit_freelance_job.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  bool isClickable = true;
  bool isSelected = false;
  int currentindex = 0;
  GlobalKey keyList = GlobalKey();

  takeScreenShot() async {
    // iconVisible = true ;
    var status = await Permission.photos.request();
    //Permission.manageExternalStorage.request();

    //PermissionStatus storagePermission = await Permission.storage.request();
    if (status.isGranted /*storagePermission == PermissionStatus.denied*/) {
      final directory = (await getApplicationDocumentsDirectory()).path;

      RenderRepaintBoundary bound =
          keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      /*if(bound.debugNeedsPaint){
        Timer(const Duration(seconds: 2),()=>_shareQrCode());
        return null;
      }*/
      ui.Image image = await bound.toImage(pixelRatio: 10);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      print('${byteData?.buffer.lengthInBytes}___________');
      // this will save image screenshot in gallery
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        String fileName = DateTime.now().microsecondsSinceEpoch.toString();
        final imagePath = await File('$directory/$fileName.png').create();
        await imagePath.writeAsBytes(pngBytes);
        Share.shareFiles([imagePath.path], text: '');
        // final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}.png');
        //print(resultsave);
      }
      /*_screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          try {
            String fileName = DateTime
                .now()
                .microsecondsSinceEpoch
                .toString();

            final imagePath = await File('$directory/$fileName.png').create();
            if (imagePath != null) {
              await imagePath.writeAsBytes(image);
              Share.shareFiles([imagePath.path],text: text);
            }
          } catch (error) {}
        }
      }).catchError((onError) {
        print('Error --->> $onError');
      });*/
    } else if (await status
        .isDenied /*storagePermission == PermissionStatus.denied*/) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This Permission is recommended')));
    } else if (await status
        .isPermanentlyDenied /*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {});
    }
  }

  List<FreelancerJobs> freelancerJobs = [];
  List<JobData> getJobs = [];
  List jobs = [];
  String pdfUrl = '';
  String htmlContent = '';
  String? userId;

  getClientJobs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    var uri = Uri.parse(getClientJobsApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = userId!;
    // request.fields[RequestKeys.type] = 'client';
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      getJobs = GetClientJobsModel.fromJson(userData).data!;
      jobs = userData['data'];
    });
  }

  downloadPdfs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(downloadPdfApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = id!;
    request.fields[RequestKeys.type] = isSelected  ? 'jobs' : 'freelance';
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

  // downloadPdfs() async {
  //   print("creating pdf");
  //   final status = await Permission.storage.request();
  //
  //   if (status == PermissionStatus.granted) {
  //     // if (mounted) {
  //     //   // setState(() {
  //     //   //   _isProgress = true;
  //     //   // });
  //     // }
  //     var targetPath;
  //
  //     if (Platform.isIOS) {
  //       var target = await getApplicationDocumentsDirectory();
  //       targetPath = target.path.toString();
  //     } else {
  //       print("android");
  //       var downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
  //       targetPath = downloadsDirectory!.path.toString();
  //     }
  //     print("this is target path $targetPath");
  //
  //     var targetFileName = "Kolazbook_$userId";
  //     var generatedPdfFile, filePath;
  //     try {
  //       generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
  //           htmlContent, targetPath, targetFileName);
  //       filePath = generatedPdfFile.path;
  //     } on Exception {
  //       //  filePath = targetPath + "/" + targetFileName + ".html";
  //       generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
  //           htmlContent, targetPath, targetFileName);
  //       filePath = generatedPdfFile.path;
  //     }
  //     //
  //     // if (mounted) {
  //     //
  //     // }
  //     Fluttertoast.showToast(msg: 'msg');
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(
  //         "Invoice Path $targetFileName",
  //         textAlign: TextAlign.center,
  //         style: TextStyle(color: Colors.black),
  //       ),
  //       action: SnackBarAction(
  //           label: "View",
  //           textColor: AppColors.backgruond,
  //           onPressed: () async {
  //             final result = await OpenFilex.open(filePath);
  //           }),
  //       backgroundColor: AppColors.whit,
  //       elevation: 1.0,
  //     ));
  //   } else {
  //     await Permission.storage.request();
  //   }
  // }



  getFreelancingJobs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    var uri = Uri.parse(getFreelancingJobsApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);

    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = userId!;
    request.fields[RequestKeys.type] = 'freelancer';
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      freelancerJobs = GetFreelancerJobsModel.fromJson(userData).data!;
    });
  }

  Widget _client() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getJobs != null
            ? getJobs.isNotEmpty
                ? currentindex == 0
                    ? Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: getJobs[0].allJobs!.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var data = getJobs[0].allJobs![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditClientJob(
                                            type: true,
                                            allJobs: getJobs[0].allJobs![index],
                                            // allJobs: getJobs[0].allJobs![index],
                                            data: jobs[0]['all_jobs'][index])));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: 340,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.black12,
                                    elevation: 1,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.clientName.toString(),
                                                style: const TextStyle(
                                                    color: AppColors.textclr,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 14,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.lightwhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    data.qid.toString(),
                                                    style: const TextStyle(
                                                      color: AppColors.whit,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.city.toString(),
                                                style: const TextStyle(
                                                    color: AppColors.textclr,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              const Text(
                                                "",
                                                style: TextStyle(
                                                    color: AppColors.whit),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.eventName.toString(),
                                                style: TextStyle(
                                                    color: AppColors.textclr,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                data.photographersDetails![0]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        AppColors.AppbtnColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: getJobs[0].upcomingJobs!.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            var data = getJobs[0].upcomingJobs![index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditClientJob(
                                              type: false,
                                              upcomingJobs: getJobs[0]
                                                  .upcomingJobs![index],
                                              data: jobs[0]['upcoming_jobs']
                                                  [index],
                                            )));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Container(
                                  width: 340,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    color: Colors.black12,
                                    elevation: 1,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.clientName.toString(),
                                                style: const TextStyle(
                                                    color: AppColors.textclr,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 14,
                                                      vertical: 10),
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.lightwhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Text(
                                                    data.qid.toString(),
                                                    style: const TextStyle(
                                                      color: AppColors.whit,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0, left: 10, right: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.city.toString(),
                                                style: const TextStyle(
                                                    color: AppColors.textclr,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              const Text(
                                                "",
                                                style: TextStyle(
                                                    color: AppColors.whit),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.eventName.toString(),
                                                style: TextStyle(
                                                    color: AppColors.textclr,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                data.photographersDetails![0]
                                                    .date
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        AppColors.AppbtnColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                : Container(
                    height: MediaQuery.of(context).size.width,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                        child: Text(
                      "No Data to show",
                      style: TextStyle(color: AppColors.whit),
                    )))
            : Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                    child: Text(
                  "No Data to show",
                  style: TextStyle(color: AppColors.whit),
                )))
        // GetBuilder(
        //     init: AddQuatationController(),
        //     builder: (controller){
        //   return   getJobs != null || getJobs.isNotEmpty ?
        //   ListView.builder(
        //     shrinkWrap: true,
        //     scrollDirection: Axis.vertical,
        //     itemCount: getJobs[0].allJobs!.length ,
        //     physics: NeverScrollableScrollPhysics(),
        //     itemBuilder: (BuildContext context, int index) {
        //       return Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
        //         child: InkWell(
        //           onTap: (){
        //             Navigator.push(context, MaterialPageRoute(builder: (context)=>EditQuotation()));
        //           },
        //           child: Card(
        //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        //             color: Colors.black12,
        //             elevation: 2,
        //             child: Column(
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text("Job ID",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
        //                       Container(
        //                           padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
        //                           decoration: BoxDecoration(
        //                               color: AppColors.lightwhite,
        //
        //                               borderRadius: BorderRadius.circular(10)
        //                           ),
        //                           child: Text("${controller.getQuotation[index].qid}",style: TextStyle(color: AppColors.whit,),)),
        //                     ],
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text("Client Name",style: TextStyle(color: AppColors.pdfbtn,fontWeight: FontWeight.bold,fontSize: 16),),
        //                       Text("${controller.getQuotation[index].clientName}",style: TextStyle(color: AppColors.whit),),
        //                     ],
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text("Event",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
        //                       Text("${controller.getQuotation[index].eventName}",style: TextStyle(color: AppColors.whit),),
        //                     ],
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text("Venue",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
        //                       Text("${controller.getQuotation[index].city}",style: TextStyle(color: AppColors.whit),),
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),),
        //         ),
        //       );
        //     },
        //
        //   )
        //   // clientJobCard(context)
        //       : Center(child: const Text(" No Data To Show"));
        // })
      ],
    );
  }

  // Widget clientJobCard(BuildContext context){
  //   return GetBuilder(
  //     init: AddQuatationController(),
  //     builder: (controller) {
  //       return  ListView.builder(
  //         shrinkWrap: true,
  //         scrollDirection: Axis.vertical,
  //         itemCount: getJobs[0].allJobs!.length ,
  //         physics: NeverScrollableScrollPhysics(),
  //         itemBuilder: (BuildContext context, int index) {
  //           return Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
  //             child: InkWell(
  //               onTap: (){
  //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>EditQuotation()));
  //               },
  //               child: Card(
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //                 color: Colors.black12,
  //                 elevation: 2,
  //                 child: Column(
  //                   children: [
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text("Job ID",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
  //                           Container(
  //                               padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
  //                               decoration: BoxDecoration(
  //                                   color: AppColors.lightwhite,
  //
  //                                   borderRadius: BorderRadius.circular(10)
  //                               ),
  //                               child: Text("${controller.getQuotation[index].qid}",style: TextStyle(color: AppColors.whit,),)),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text("Client Name",style: TextStyle(color: AppColors.pdfbtn,fontWeight: FontWeight.bold,fontSize: 16),),
  //                           Text("${controller.getQuotation[index].clientName}",style: TextStyle(color: AppColors.whit),),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text("Event",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
  //                           Text("${controller.getQuotation[index].eventName}",style: TextStyle(color: AppColors.whit),),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text("Venue",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
  //                           Text("${controller.getQuotation[index].city}",style: TextStyle(color: AppColors.whit),),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),),
  //             ),
  //           );
  //         },
  //
  //       );
  //     },);
  //
  // }

  Widget _freelancing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        freelancerJobs == null || freelancerJobs.isEmpty
            ? Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    "No Data to show",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            : currentindex == 0
                ? Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: freelancerJobs[0].allJobs!.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var data = freelancerJobs[0].allJobs![index];
                        return InkWell(
                          onTap: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditFreelanceJob(
                                        type: true,
                                        allJobs: freelancerJobs[0]
                                            .allJobs![index])));
                            if (result != null) {
                              await getFreelancingJobs();
                              setState(() {});
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: 340,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.black12,
                                elevation: 1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.photographerName.toString(),
                                            style: const TextStyle(
                                                color: AppColors.textclr,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightwhite,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                data.uid.toString(),
                                                style: const TextStyle(
                                                  color: AppColors.whit,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.cityName.toString(),
                                            style: const TextStyle(
                                                color: AppColors.textclr,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const Text(
                                            "",
                                            style: TextStyle(
                                                color: AppColors.whit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.eventName.toString(),
                                            style: TextStyle(
                                                color: AppColors.textclr,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data.jsonData![0].date.toString(),
                                            style: TextStyle(
                                                color: AppColors.AppbtnColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height / 1.8,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: freelancerJobs[0].upcomingJobs!.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var data = freelancerJobs[0].upcomingJobs![index];
                        return InkWell(
                          onTap: () async {
                            var result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditFreelanceJob(
                                        type: true,
                                        allJobs: freelancerJobs[0]
                                            .allJobs![index])));
                            if (result != null) {
                              await getFreelancingJobs();
                              setState(() {});
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Container(
                              width: 340,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: Colors.black12,
                                elevation: 1,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0, left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.photographerName.toString(),
                                            style: const TextStyle(
                                                color: AppColors.textclr,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  color: AppColors.lightwhite,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Text(
                                                data.uid.toString(),
                                                style: const TextStyle(
                                                  color: AppColors.whit,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, left: 10, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.cityName.toString(),
                                            style: const TextStyle(
                                                color: AppColors.textclr,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          const Text(
                                            "",
                                            style: TextStyle(
                                                color: AppColors.whit),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15.0,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.eventName.toString(),
                                            style: TextStyle(
                                                color: AppColors.textclr,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data.jsonData![0].date.toString(),
                                            style: TextStyle(
                                                color: AppColors.AppbtnColor),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
      ],
    );
  }

  DateTime? selectedDate;
  DateTime? selectendDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClientJobs();
    getFreelancingJobs();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            bottomSheet: isSelected
                ? Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (controller.profiledata!.isPlanActive == true) {
                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MoreQuatations()));
                              if (result != null) {
                                getClientJobs();
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "You don't have any active plan!");
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 190,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 1,
                                    color: AppColors.greyColor,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(40),
                                color: const Color(0xff40ACFF)),
                            child: const Center(
                              child: Text("Make Quotations",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.whit)),
                            ),
                          ),
                        ),
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
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(left: 30, right: 30, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (controller.profiledata!.isPlanActive == true) {
                              var result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddFreelanceJob()));
                              if (result != null) {
                                getFreelancingJobs();
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "You don't have any active plan!");
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 190,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(1, 2),
                                    blurRadius: 1,
                                    color: AppColors.greyColor,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(40),
                                color: Color(0xff40ACFF)),
                            child: Center(
                              child: Text("Add New Job",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.whit)),
                            ),
                          ),
                        ),
                        InkWell(
                            onTap: () {
                              downloadPdfs();
                              // takeScreenShot();
                            },
                            child: Image.asset(
                              "assets/images/pdf.png",
                              scale: 1.6,
                            )),
                      ],
                    ),
                  ),
            backgroundColor: AppColors.backgruond,
            appBar: isSelected
                ? AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Color(0xff303030),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: Text("Clients Jobs",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.AppbtnColor,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ],
                  )
                : AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: Color(0xff303030),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Center(
                            child: Text("Freelancing Jobs",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.AppbtnColor,
                                    fontWeight: FontWeight.bold))),
                      ),
                    ],
                  ),
            body: RepaintBoundary(
              key: keyList,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.containerclr,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSelected = true;
                                });
                                getClientJobs();
                              },
                              child: Container(
                                  height: 40,
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      'Client',
                                      style: TextStyle(
                                        color: isSelected
                                            ? Color(0xffffffff)
                                            : Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.AppbtnColor
                                        : AppColors.containerclr,
                                    // border: Border.all(color: AppColors.AppbtnColor),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => NextPage(),
                                  // ));
                                  isSelected = false;
                                });
                                getFreelancingJobs();
                              },
                              child: Container(
                                  height: 40,
                                  width: 130,
                                  child: Center(
                                    child: Text(
                                      'Freelancing',
                                      style: TextStyle(
                                        color: isSelected
                                            ? AppColors.whit
                                            : Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.containerclr
                                          : AppColors.AppbtnColor,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
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
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: currentindex == 0
                                    ? AppColors.AppbtnColor
                                    : Color(0xff8B8B8B)),
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
                  SizedBox(
                    height: 5,
                  ),
                  isSelected ? _client() : _freelancing(),
                ],
              ),
            ),
          );
        });
  }
}
