import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kolazz_book/Controller/edit_profile_controller.dart';
import 'package:kolazz_book/Models/get_portfolio_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:kolazz_book/Views/edit_profile/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/colors.dart';
import 'second_screen.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {

  List items = ['Madhya pradesh', 'Uttar Pradesh', 'Bihar', 'Rajasthan', 'Tamil Nadu',];
  List items1 = ['Indore', 'Ujjain', 'Gwalior', 'Nashik', 'Bhopal',];
  List items2 = ['Bhawarkua', 'Malwa Mill', 'Railway Statition', 'VijayNagar', 'L.I.G',];


  String? selectedcityList;
  var categoryValue;
  var categoryValue1;
  var categoryValue2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPortfolios();
  }

  List<Portfolio> getPortfolioData = [];

  getPortfolios() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri =
    Uri.parse(getPortfolioApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = id!;
    // request.fields[RequestKeys.type] = 'client';
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      getPortfolioData = GetPortfolioModel.fromJson(userData).data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // automaticallyImplyLeading: false,
      //   backgroundColor: Color(0xff303030),
      //   actions: [
      //     GetBuilder(
      //         init: EditProfileController(),
      //         builder: (controller) {
      //           return Row(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               GestureDetector(
      //                 onTap: (){
      //                   Get.to(EditProfileScreen());
      //                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfilePage()));
      //                 },
      //                 child:  Container(
      //                   height: 40,
      //                   width: 40,
      //                   decoration: BoxDecoration(
      //                       color: AppColors.primary,
      //                       borderRadius: BorderRadius.circular(40)),
      //                   child:   ClipRRect(
      //                       borderRadius: BorderRadius.circular(40),
      //                       child: controller.profilePic == null || controller.profilePic == '' ?
      //                       ClipRRect(
      //                           borderRadius: BorderRadius.circular(40),
      //                           child: controller.imageFile != null
      //                               ? Image.file(controller.imageFile!, fit: BoxFit.cover, height: 40,width: 40,)
      //                               : Image.asset("assets/images/loginlogo.png",fit: BoxFit.fill,height: 40,width: 40,)
      //                       )
      //                           : ClipRRect(
      //                           borderRadius: BorderRadius.circular(40),
      //                           child:
      //                           // rcImage != null ?
      //                           Image.network(controller.profilePic.toString(), fit: BoxFit.cover, height: 40,width: 40,)
      //                       )
      //                   ),
      //                 ),
      //               ),
      //               Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   controller.profiledata != null || controller.profiledata == "" ? Text("${controller.profiledata!.fname} ${controller.profiledata!.lname} ",style: TextStyle(color: AppColors.AppbtnColor,fontSize: 15),): CircularProgressIndicator(),
      //                   TextButton(onPressed: (){}, child: Text("My Portfolio", style: TextStyle(color: AppColors.whit, decoration: TextDecoration.underline),))
      //                 ],
      //               )
      //             ],
      //           );}
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 70,
                color: Color(0xff303030),
                child: GetBuilder(
                    init: EditProfileController(),
                    builder: (controller) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: const Icon(Icons.arrow_back_ios, color: AppColors.whit,)),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.to(EditProfileScreen());
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfilePage()));
                                  },
                                  child:  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(40)),
                                    child:   ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: controller.profilePic == null || controller.profilePic == '' ?
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(40),
                                            child: controller.imageFile != null
                                                ? Image.file(controller.imageFile!, fit: BoxFit.cover, height: 40,width: 40,)
                                                : Image.asset("assets/images/loginlogo.png",fit: BoxFit.fill,height: 40,width: 40,)
                                        )
                                            : ClipRRect(
                                            borderRadius: BorderRadius.circular(40),
                                            child:
                                            // rcImage != null ?
                                            Image.network(controller.profilePic.toString(), fit: BoxFit.cover, height: 40,width: 40,)
                                        )
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    controller.profiledata != null || controller.profiledata == "" ? Text("${controller.profiledata!.fname} ${controller.profiledata!.lname} ",style: TextStyle(color: AppColors.AppbtnColor,fontSize: 15),): CircularProgressIndicator(),
                                     InkWell(
                                       onTap: (){
                                         Navigator.push(context, MaterialPageRoute(builder: (context)=> AddPortfolioScreen()));
                                       },
                                         child: Text("My Portfolio", style: TextStyle(color: AppColors.whit, decoration: TextDecoration.underline),))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );}
                ),
              ),
              Container(
                width: double.infinity,
                height: 133,
                color: Color(0xff686767),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 33, top: 3),
                          child: Text(
                            "Filter By Category",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 44, top: 3),
                          child: Text(
                            "Filter By State",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 39, top: 3),
                          child: Text(
                            "Filter By City",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 17,
                        ),
                        Container(
                          width: 120,
                          height: 35,
                          child: DropdownButtonHideUnderline(
                          child:DropdownButton(
                          value: categoryValue,
                          underline: Container(),
                          isExpanded:true,
                          icon: Icon(Icons.keyboard_arrow_down),

                          hint: Text(
                              "Category"
                          ),
                          items: items.map((val){
                            return DropdownMenuItem(
                              value :val,
                              child: Container(
                                  child: Text(val.toString())
                              ),);
                          }).toList(),
                          onChanged: (newValue){
                            setState((){
                              categoryValue = newValue;
                              print ("selected category $categoryValue");
                            });
                          },
                        ),
              ),
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          child: DropdownButtonHideUnderline(
                          child:DropdownButton(
                          value: categoryValue1,
                          underline: Container(),
                          isExpanded:true,
                          icon: Icon(Icons.keyboard_arrow_down),

                          hint: Text(
                              "State"
                          ),
                          items: items1.map((val){
                            return DropdownMenuItem(
                              value :val,
                              child: Container(
                                  child: Text(val.toString())
                              ),);
                          }).toList(),
                          onChanged: (newValue){
                            setState((){
                              categoryValue1 = newValue;
                              print ("selected category $categoryValue");
                            });
                          },
                        ),
              ),
                        ),
                        Container(
                          width: 100,
                          height: 35,
                           child: DropdownButtonHideUnderline(
                          child:DropdownButton(
                          value: categoryValue2,
                          underline: Container(),
                          isExpanded:true,
                          icon: Icon(Icons.keyboard_arrow_down),

                          hint: Text(
                              "City"
                          ),
                          items: items2.map((val){
                            return DropdownMenuItem(
                              value :val,
                              child: Container(
                                  child: Text(val.toString())
                              ),);
                          }).toList(),
                          onChanged: (newValue){
                            setState((){
                              categoryValue2 = newValue;
                              print ("selected category $categoryValue2");
                            });
                          },
                        ),
      ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),


              Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.grey,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 120,
                        width: 360,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 90, left: 25),
                      child: Container(
                        decoration: BoxDecoration(
                            //shape: BoxShape.circle,
                            //border: Border.all(
                            //color: Colors.blue, // Set the outline border color
                            //width: 1, // Set the outline border width
                            //),
                            ),
                        child: Row(
                          children: [
                            Column(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 28,
                                ),
                                Text(
                                  "Ramesh Patel",
                                  style: TextStyle(
                                      color: Color(0xff42ACFE),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  "City,State,Country",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                                Text(
                                  "Company Name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 159,top: 30),
                              child: Text("Category",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 5,
                color: Colors.black,
              ),

              Container(
                height: 200,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      color: Colors.grey,
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 120,
                        width: 360,
                        color: Colors.lightBlue,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 90, left: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          //shape: BoxShape.circle,
                          //border: Border.all(
                          //color: Colors.blue, // Set the outline border color
                          //width: 1, // Set the outline border width
                          //),
                        ),
                        child: Row(
                          children: [
                            Column(mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 28,
                                ),
                                Text(
                                  "Ramesh Patel",
                                  style: TextStyle(
                                      color: Color(0xff42ACFE),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Text(
                                  "City,State,Country",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                                Text(
                                  "Company Name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 159,top: 30),
                              child: Text("Category",style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              ),
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height:109,
                width:MediaQuery.of(context).size.width,
                color: Colors.black54,
              ),
            ],
          ),

        ),
      ),
    );
  }
}
