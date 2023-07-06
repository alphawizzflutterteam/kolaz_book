import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kolazz_book/Controller/edit_profile_controller.dart';
import 'package:kolazz_book/Models/get_portfolio_model.dart';
import 'package:kolazz_book/Utils/colors.dart';
import 'package:kolazz_book/Views/edit_profile/edit_profile.dart';
import 'package:kolazz_book/Views/portfolio/add_portfolio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MyPortfolioScreen extends StatefulWidget {
  final Portfolio data;
  final bool? isUser ;
  const MyPortfolioScreen({Key? key, required this.data, this.isUser}) : super(key: key);

  @override
  State<MyPortfolioScreen> createState() => _MyPortfolioScreenState();
}

class _MyPortfolioScreenState extends State<MyPortfolioScreen> {

  //
  // List<Portfolio> getPortfolioData = [];
  //
  // getPortfolios() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? id = preferences.getString('id');
  //   var uri = Uri.parse(getPortfolioApi.toString());
  //   // '${Apipath.getCitiesUrl}');
  //   var request = http.MultipartRequest("POST", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //
  //   request.headers.addAll(headers);
  //   request.fields[RequestKeys.userId] = id!;
  //   // request.fields[RequestKeys.type] = 'client';
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //
  //   setState(() {
  //     getPortfolioData = GetPortfolioModel.fromJson(userData).data!;
  //   });
  //   print("this is portfolio data ${getPortfolioData.length}");
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getPortfolios();
  }



  Future<void> _launchUrl(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch $uri');
    }
  }
  _launchCaller(mobileNumber) async {
    var url = "tel:${mobileNumber.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff575656),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              color: const Color(0xff303030),
              child: GetBuilder(
                  init: EditProfileController(),
                  builder: (controller) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.AppbtnColor,
                            )),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.to(EditProfileScreen());
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfilePage()));
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius:
                                      BorderRadius.circular(40)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: controller.profilePic == null ||
                                          controller.profilePic == ''
                                          ? ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(40),
                                          child: controller.imageFile !=
                                              null
                                              ? Image.file(
                                            controller.imageFile!,
                                            fit: BoxFit.cover,
                                            height: 40,
                                            width: 40,
                                          )
                                              : Image.asset(
                                            "assets/images/loginlogo.png",
                                            fit: BoxFit.fill,
                                            height: 40,
                                            width: 40,
                                          ))
                                          : ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(40),
                                          child:
                                          // rcImage != null ?
                                          Image.network(
                                            controller.profilePic
                                                .toString(),
                                            fit: BoxFit.cover,
                                            height: 40,
                                            width: 40,
                                          ))),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  controller.profiledata != null ||
                                      controller.profiledata == ""
                                      ? Text(
                                    "${controller.profiledata!.fname} ${controller.profiledata!.lname} ",
                                    style: TextStyle(
                                        color: AppColors.AppbtnColor,
                                        fontSize: 15),
                                  )
                                      : CircularProgressIndicator(),
                                  // InkWell(
                                  //     onTap: () {
                                  //       Navigator.push(
                                  //           context,
                                  //           MaterialPageRoute(
                                  //               builder: (context) =>
                                  //                   AddPortfolioScreen()));
                                  //     },
                                  //     child: const Text(
                                  //       "My Portfolio",
                                  //       style: TextStyle(
                                  //           color: AppColors.whit,
                                  //           decoration:
                                  //           TextDecoration.underline),
                                  //     ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            Container(
              // height: 200,
              width: MediaQuery.of(context).size.width,
              color: AppColors.teamcard2,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 120,
                        decoration: BoxDecoration(
                            color: AppColors.whit,
                            image: DecorationImage(
                                image: NetworkImage(
                                    widget.data.coverImage.toString()
                                )
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 15,  bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${widget.data.fname.toString()} ${widget.data.lname.toString()}',
                                  style: const TextStyle(
                                      color: Color(0xff42ACFE),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                                  child: Text(
                                    '${widget.data.city.toString()} ${widget.data.state.toString()} ${widget.data.country.toString()}',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13),
                                  ),
                                ),
                                Text(
                                  widget.data.companyName.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.data.categoryId.toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 10,),
                                  InkWell(
                                    onTap: (){
                                      _launchCaller( widget.data.mobile.toString(),);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.back
                                      ),
                                      child: const Icon(Icons.call, color: AppColors.AppbtnColor, size:  20,),
                                    )
                                    // Image.asset(
                                    //   "assets/calling.png",
                                    //   scale: 1.1,
                                    // ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration:  BoxDecoration(
                          border: Border.all(color: AppColors.AppbtnColor),
                          shape: BoxShape.circle,
                          image: DecorationImage(image: NetworkImage( widget.data.profilePic.toString()))
                      ),
                    ),
                  )

                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "About (User Name)",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(left: 18.0, top: 4),
             child: Container(
               height: 90,
               child: Text(widget.data.about.toString(), maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(
                 color: AppColors.whit
               ),),
             ),
           ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Equipment's/ Camera kit",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 4),
              child: Container(
                height: 90,
                child: Text(widget.data.equipments.toString(), maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(
                    color: AppColors.whit
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                "Country Visited",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 4),
              child: Container(
                height: 90,
                child: Text(widget.data.countryVisited.toString(), maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(
                    color: AppColors.whit
                ),),
              ),
            ),
            Center(
              child: Text(
                "${widget.data.fname} ${widget.data.lname} Official Link",
                style: const TextStyle(
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
                  InkWell(
                    onTap: (){
                      _launchUrl(widget.data.instagram.toString());
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        child: Image.asset("assets/icons/insta.png")),
                  ),
                 const  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      _launchUrl(widget.data.facebook.toString());
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        child: Image.asset("assets/icons/fb.png")),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: (){
                      _launchUrl(widget.data.youtube.toString());
                    },
                    child: Container(
                        width: 60,
                        height: 60,
                        child: Image.asset("assets/icons/youtube.png")),
                  ),
                ]),
          ]),
        ),
      ),
    );
  }
}
