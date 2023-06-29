import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:kolazz_book/Models/get_upcoming_jobs_model.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/colors.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpcomingTeamJobs();
  }

  List<Teams> getUpcomingJobs = [];
  TextEditingController mapLinkController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  getUpcomingTeamJobs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=fd488e599591e4d13d6ae441c1876300c07b77d5'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(getUpcomingJobsTeamApi.toString()));
    // request.fields.addAll({
    //   'user_id': userId.toString(),
    //   'type': 'client'
    // });
    request.headers.addAll(headers);
    request.fields.addAll({"user_id": userId.toString(), "type": "client"});
    print('_____Surendra_____${request.fields}______$getUpcomingJobsTeamApi');
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      print('_____result_____${result}_________');
      var finalResult = GetUpcomingJobsModel.fromJson(json.decode(result));
      setState(() {
        getUpcomingJobs = finalResult.data!;
      });
      // for(var i=0;i<getPlans!.data!.length;i++){
      //
      // }
    } else {
      print(response.reasonPhrase);
    }
  }

  GlobalKey keyList = GlobalKey();


  takeScreenShot() async {
    // iconVisible = true ;
    var status =  await Permission.photos.request();
    //Permission.manageExternalStorage.request();

    //PermissionStatus storagePermission = await Permission.storage.request();
    if ( status.isGranted/*storagePermission == PermissionStatus.denied*/) {
      final directory = (await getApplicationDocumentsDirectory()).path;

      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      /*if(bound.debugNeedsPaint){
        Timer(const Duration(seconds: 2),()=>_shareQrCode());
        return null;
      }*/
      ui.Image image = await bound.toImage(pixelRatio: 10);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      print('${byteData?.buffer.lengthInBytes}___________');
      // this will save image screenshot in gallery
      if(byteData != null ){
        Uint8List pngBytes = byteData.buffer.asUint8List();
        String fileName = DateTime
            .now()
            .microsecondsSinceEpoch
            .toString();
        final imagePath = await File('$directory/$fileName.png').create();
        await imagePath.writeAsBytes(pngBytes);
        Share.shareFiles([imagePath.path],text: 'Google Map Link : ${mapLinkController.text.toString()} \n Notes : ${descriptionController.text.toString()}');
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
    } else if (await status.isDenied/*storagePermission == PermissionStatus.denied*/) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This Permission is recommended')));
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        automaticallyImplyLeading: false,
        // leading: TextButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     child: Icon(Icons.arrow_back_ios,size : 35,color: AppColors.AppbtnColor,)
        // ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Teams ",
                style: TextStyle(
                    color: AppColors.AppbtnColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: const [
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, top: 20),
                    child: Text("All Team For Upcoming Client Job",
                        style: TextStyle(
                            fontSize: 17,
                            color: AppColors.whit,
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.4,
                width: MediaQuery.of(context).size.width,
                child: getUpcomingJobs.isNotEmpty
                    ? ListView.builder(
                        itemCount: getUpcomingJobs.length,
                        itemBuilder: (context, index) {
                          var result = getUpcomingJobs[index];
                          return RepaintBoundary(
                            key: keyList,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.teamcard,
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 7),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15),
                                    height: 65,
                                    decoration: BoxDecoration(
                                        color: AppColors.teamcard2,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${result.clientName}",
                                          style: const TextStyle(
                                              color: AppColors.textclr,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${result.eventName}",
                                          style: const TextStyle(
                                              color: AppColors.textclr,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${result.cityName}",
                                          style: const TextStyle(
                                              color: AppColors.textclr,
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, left: 10, right: 10),
                                    child: Row(
                                      children: [
                                        const Text(
                                          "Date: ",
                                          style: TextStyle(
                                              color: AppColors.whit,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        Text(
                                          "${result.date}",
                                          style: const TextStyle(
                                              color: AppColors.teamcard2,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.7,
                                              padding: EdgeInsets.all(3.0),
                                              child: const Text(
                                                "Photographer Name  ",
                                                style: TextStyle(
                                                    color: AppColors.whit,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.9,
                                                child: ListView.builder(
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: result
                                                        .photographers!.length,
                                                    itemBuilder: (context, j) {
                                                      if (result.photographers![0]
                                                              .name
                                                              .toString() !=
                                                          "") {
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.all(3.0),
                                                          child: Text(
                                                            result
                                                                .photographers![j]
                                                                .name
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .teamcard2,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        );
                                                      }
                                                      return const Padding(
                                                        padding:  EdgeInsets.only(left: 5.0, top: 5),
                                                        child:  Text(
                                                          "Not Allotted yet!",
                                                          style:  TextStyle(
                                                              color: AppColors
                                                                  .teamcard2,
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                      );
                                                    })),
                                          ],
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width /
                                                  2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: const Text(
                                                  "Type Of Photography",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: AppColors.whit,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14),
                                                ),
                                              ),
                                              Container(
                                                // height: 200,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                // width: 300,
                                                child: ListView.builder(
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    itemCount: result
                                                        .photographers!.length,
                                                    itemBuilder: (context, j) {
                                                      return Padding(
                                                        padding:
                                                            EdgeInsets.all(3.0),
                                                        child: Text(
                                                          result.photographers![j]
                                                              .type
                                                              .toString(),
                                                          style: const TextStyle(
                                                              color: AppColors
                                                                  .teamcard2,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                        color: AppColors.teamcard2,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0, right: 10, top: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Google Map Link ",
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.temtextclr,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "Notes ",
                                                    style: TextStyle(
                                                        color:
                                                            AppColors.temtextclr,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5,
                                                  right: 5,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    color: Colors.white,
                                                    height: 40,
                                                    width: 170,
                                                    child: TextFormField(
                                                       controller: mapLinkController,
                                                      style: const TextStyle(
                                                          fontSize: 12),
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration: InputDecoration(
                                                          hintStyle: TextStyle(
                                                              fontSize: 12),
                                                          hintText:
                                                              'Paste Google Map Link',
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 5,
                                                                  left: 5)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    color: Colors.white,
                                                    height: 40,
                                                    width: 170,
                                                    child: TextFormField(
                                                      controller:  descriptionController,
                                                      style: const TextStyle(
                                                          // color: AppColors.field,
                                                          fontSize:
                                                              12), // controller: nameController,
                                                      keyboardType:
                                                          TextInputType.name,
                                                      decoration: const InputDecoration(
                                                          hintStyle: TextStyle(
                                                              fontSize: 12),
                                                          hintText:
                                                              'Enter Short Instruction/ Time /etc. Map Link Link ',
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 5,
                                                                  left: 5)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: (){
                                            takeScreenShot();
                                          },
                                          child: Container(
                                            height: 35,
                                            width:
                                                MediaQuery.of(context).size.width /
                                                    1.7,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColors.pdfbtn),
                                            child: const Center(
                                              child: Text(
                                                "Copy & Share",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                      child: Text(
                          "No data to show!",
                          style: TextStyle(color: AppColors.whit),
                        ),
                    ),
              ),
            ),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                     color: AppColors.teamcard,
//                     borderRadius: BorderRadius.circular(10)),
//                 margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 7),
//                 width: double.infinity,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 15),
//                       height: 65,
//                       decoration: BoxDecoration(
//                           color: AppColors.teamcard2,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("Client Name: Krishna Patel",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
//                           Text("Event: Edding",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
//                           Text("Vanue: Mumbai",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
//
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         children: const [
//                           Text("Date: ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
//                           SizedBox(width: 7,),
//                           Text("29-04-2023",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 10,),
//
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children:  [
//                             Container(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Photographer Name  ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Krishna Patel ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Ajit Thakkar ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Ramesh Prajapati ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(3.0),
//                               child: Text("Mohit Khan ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
//                             ),
//
//                           ],),
//
// Container(
//       width: MediaQuery.of(context).size.width/2.3,
//
//       child:     Column(
//      crossAxisAlignment: CrossAxisAlignment.start,
//      children: [
//      Container(
//
//        padding: const EdgeInsets.all(3.0),
//
//        child: const Text("Type Of Photography",
//            overflow: TextOverflow.ellipsis,
//
//            style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
//      ),
//      Container(
//        padding: const EdgeInsets.all(3.0),
//
//        child: Text("Candid Photography",
//          overflow: TextOverflow.ellipsis,
//          style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
//      ),
//      const Padding(
//        padding: EdgeInsets.all(3.0),
//        child: Text("Drone",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
//      ),
//      const Padding(
//        padding: EdgeInsets.all(3.0),
//        child: Text("Led",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
//      ),
//      Padding(
//        padding: const EdgeInsets.all(3.0),
//        child: Container(
//            child: Text("Candid Chinematography",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
//      ),
//
//
//
//    ],),
//     ),
//                         ],
//                       ),
//                     ),
//
//                     const SizedBox(height: 10,),
//
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       decoration: BoxDecoration(
//                           color: AppColors.teamcard2,
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5.0,right: 10,top: 5),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("Google Map Link ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
//                                     SizedBox(height: 15,),
//
//                                     Text("Notes ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
//
//
//
//                                   ],
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 5,right: 5,top: 10, bottom: 10),
//
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//
//                                   children: [
//                                     Container(
//                                       color: Colors.white,
//                                       height: 40,
//                                       width: 170,
//
//                                       child: TextFormField(
//                                         // controller: nameController,
//                                         style: TextStyle(color: AppColors.field, fontSize: 12),
//                                         keyboardType: TextInputType.name,
//                                         decoration: InputDecoration(
//                                             hintStyle: TextStyle(fontSize: 12),
//                                             hintText: 'Paste Google Map Link',
//                                             border: InputBorder.none,
//                                             contentPadding: EdgeInsets.only(bottom: 5,left: 5)
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 10,),
//                                     Container(
//                                       color: Colors.white,
//                                       height: 40,
//                                       width: 170,
//                                       child: TextFormField(
//                                         style: TextStyle(color: AppColors.field, fontSize: 12),                                  // controller: nameController,
//                                         keyboardType: TextInputType.name,
//                                         decoration: InputDecoration(
//                                           hintStyle: TextStyle(fontSize: 12),
//                                             hintText: 'Enter Short Instruction/ Time /etc. Map Link Link ',
//                                             border: InputBorder.none,
//                                             contentPadding: EdgeInsets.only(bottom: 5,left: 5)
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                           Container(
//                             height: 35,
//                             width: MediaQuery.of(context).size.width/1.7,
//                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:AppColors.pdfbtn),
//                             child: Center(child: Text("PDF",
//                               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
//                             ),
//                             ),
//                           ),
//                           const SizedBox(height: 10,),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),

            // const SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: AppColors.teamcard,
            //         borderRadius: BorderRadius.circular(10)),
            //     margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 7),
            //     width: double.infinity,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 15),
            //           height: 65,
            //           decoration: BoxDecoration(
            //               color: AppColors.teamcard2,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: const [
            //               Text("Client Name: Krishna Patel",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //               Text("Event: Edding",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //               Text("Vanue: Mumbai",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
            //           child: Row(
            //             children: const [
            //               Text("Date: ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //               SizedBox(width: 7,),
            //               Text("29-04-2023",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //             ],
            //           ),
            //         ),
            //         const SizedBox(height: 10,),
            //
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8, ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children:  [
            //                   Container(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Photographer Name  ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Krishna Patel ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Ajit Thakkar ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Ramesh Prajapati ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Mohit Khan ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //
            //                 ],),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Container(
            //                     width: 150,
            //
            //                     padding: const EdgeInsets.all(3.0),
            //
            //                     child: const Text("Type Of Photography",
            //                       overflow: TextOverflow.ellipsis,
            //
            //                       style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //                   ),
            //                   Container(
            //                     padding: const EdgeInsets.all(3.0),
            //                     width: 150,
            //
            //                     child: Text("Candid Photography",
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Drone",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Led",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(3.0),
            //                     child: Container(
            //                         width: 180,
            //                         child: Text("Candid Chinematography",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
            //                   ),
            //
            //
            //
            //                 ],),
            //
            //             ],
            //           ),
            //         ),
            //
            //         const SizedBox(height: 10,),
            //
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           decoration: BoxDecoration(
            //               color: AppColors.teamcard2,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 5.0,right: 10,top: 5),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text("Google Map Link ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
            //                         SizedBox(height: 15,),
            //
            //                         Text("Notes ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
            //
            //
            //
            //                       ],
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 5,right: 5,top: 10, bottom: 10),
            //
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //
            //                       children: [
            //                         Container(
            //                           color: Colors.white,
            //                           height: 40,
            //                           width: 170,
            //
            //                           child: TextFormField(
            //                             // controller: nameController,
            //                             style: TextStyle(color: AppColors.field, fontSize: 12),
            //                             keyboardType: TextInputType.name,
            //                             decoration: InputDecoration(
            //                                 hintStyle: TextStyle(fontSize: 12),
            //                                 hintText: 'Paste Google Map Link',
            //                                 border: InputBorder.none,
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 5)
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(height: 10,),
            //                         Container(
            //                           color: Colors.white,
            //                           height: 40,
            //                           width: 170,
            //                           child: TextFormField(
            //                             style: TextStyle(color: AppColors.field, fontSize: 12),                                  // controller: nameController,
            //                             keyboardType: TextInputType.name,
            //                             decoration: InputDecoration(
            //                                 hintStyle: TextStyle(fontSize: 12),
            //                                 hintText: 'Enter Short Instruction/ Time /etc. Map Link Link ',
            //                                 border: InputBorder.none,
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 5)
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //
            //                 ],
            //               ),
            //               Container(
            //                 height: 35,
            //                 width: MediaQuery.of(context).size.width/1.7,
            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:AppColors.pdfbtn),
            //                 child: Center(child: Text("PDF",
            //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
            //                 ),
            //                 ),
            //               ),
            //               const SizedBox(height: 10,),
            //             ],
            //           ),
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 10,),

            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: Container(
            //     decoration: BoxDecoration(
            //         color: AppColors.teamcard,
            //         borderRadius: BorderRadius.circular(10)),
            //     margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 7),
            //     width: double.infinity,
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 15),
            //           height: 65,
            //           decoration: BoxDecoration(
            //               color: AppColors.teamcard2,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Row(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: const [
            //               Text("Client Name: Krishna Patel",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //               Text("Event: Edding",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //               Text("Vanue: Mumbai",style: TextStyle(color: AppColors.textclr,fontSize: 11,fontWeight: FontWeight.bold),),
            //
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
            //           child: Row(
            //             children: const [
            //               Text("Date: ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //               SizedBox(width: 7,),
            //               Text("29-04-2023",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //             ],
            //           ),
            //         ),
            //         const SizedBox(height: 10,),
            //
            //         Padding(
            //           padding: const EdgeInsets.symmetric(horizontal: 8, ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children:  [
            //                   Container(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Photographer Name  ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Krishna Patel ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Ajit Thakkar ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Ramesh Prajapati ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Mohit Khan ",style: TextStyle(color: AppColors.teamcard2,fontSize: 14,fontWeight: FontWeight.bold),),
            //                   ),
            //
            //                 ],),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Container(
            //                     width: 150,
            //
            //                     padding: const EdgeInsets.all(3.0),
            //
            //                     child: const Text("Type Of Photography",
            //                       overflow: TextOverflow.ellipsis,
            //
            //                       style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 14),),
            //                   ),
            //                   Container(
            //                     padding: const EdgeInsets.all(3.0),
            //                     width: 150,
            //
            //                     child: Text("Candid Photography",
            //                       overflow: TextOverflow.ellipsis,
            //                       style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Drone",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   const Padding(
            //                     padding: EdgeInsets.all(3.0),
            //                     child: Text("Led",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(3.0),
            //                     child: Container(
            //                         width: 180,
            //                         child: Text("Candid Chinematography",style: TextStyle(color: AppColors.teamcard2,fontSize: 14 ,fontWeight: FontWeight.bold),maxLines: 1,overflow: TextOverflow.ellipsis,)),
            //                   ),
            //
            //
            //
            //                 ],),
            //
            //             ],
            //           ),
            //         ),
            //
            //         const SizedBox(height: 10,),
            //
            //         Container(
            //           padding: EdgeInsets.symmetric(horizontal: 10),
            //           decoration: BoxDecoration(
            //               color: AppColors.teamcard2,
            //               borderRadius: BorderRadius.circular(10)),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //
            //             children: [
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: [
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 5.0,right: 10,top: 5),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text("Google Map Link ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
            //                         SizedBox(height: 15,),
            //
            //                         Text("Notes ",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
            //
            //
            //
            //                       ],
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 5,right: 5,top: 10, bottom: 10),
            //
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //
            //                       children: [
            //                         Container(
            //                           color: Colors.white,
            //                           height: 40,
            //                           width: 170,
            //
            //                           child: TextFormField(
            //                             // controller: nameController,
            //                             style: TextStyle(color: AppColors.field, fontSize: 12),
            //                             keyboardType: TextInputType.name,
            //                             decoration: InputDecoration(
            //                                 hintStyle: TextStyle(fontSize: 12),
            //                                 hintText: 'Paste Google Map Link',
            //                                 border: InputBorder.none,
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 5)
            //                             ),
            //                           ),
            //                         ),
            //                         SizedBox(height: 10,),
            //                         Container(
            //                           color: Colors.white,
            //                           height: 40,
            //                           width: 170,
            //                           child: TextFormField(
            //                             style: TextStyle(color: AppColors.field, fontSize: 12),                                  // controller: nameController,
            //                             keyboardType: TextInputType.name,
            //                             decoration: InputDecoration(
            //                                 hintStyle: TextStyle(fontSize: 12),
            //                                 hintText: 'Enter Short Instruction/ Time /etc. Map Link Link ',
            //                                 border: InputBorder.none,
            //                                 contentPadding: EdgeInsets.only(bottom: 5,left: 5)
            //                             ),
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //
            //                 ],
            //               ),
            //               Container(
            //                 height: 35,
            //                 width: MediaQuery.of(context).size.width/1.7,
            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color:AppColors.pdfbtn),
            //                 child: Center(child: Text("PDF",
            //                   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
            //                 ),
            //                 ),
            //               ),
            //               const SizedBox(height: 10,),
            //             ],
            //           ),
            //         ),
            //
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
