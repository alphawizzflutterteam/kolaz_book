import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Controller/Subscription_Controller.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Models/get_country_model.dart';
import 'package:kolazz_book/Models/get_profile_model.dart';
import 'package:kolazz_book/Models/get_states_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:kolazz_book/Views/Subscription/Subscription_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/edit_profile_controller.dart';
import '../../Utils/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();


  List<CityList> citiesList = [];
  List<StateList> statesList = [];
  List<Countries> countryList = [];
  var cityController;
  var countryController;
  var stateController;
  bool isCountry = true;
  bool isState = true;
  bool isCity = true;


  getCitiesList(String stateId) async {
    var uri = Uri.parse(getCitiesApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['state_id'] = stateId.toString();
    print("this is city request ${request.fields.toString()}");
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    citiesList = GetCitiesModel.fromJson(userData).data!;
    print("this is working ${citiesList.length}");

  }

  getStateList(String countryId) async {
    var uri = Uri.parse(getStatesApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['country_id'] = countryId.toString();
    print("this is state request ${request.fields.toString()}");
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    statesList = GetStatesModel.fromJson(userData).data!;

  }

  getCountryList() async {
    var uri = Uri.parse(getCountryApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    // request.fields['type_id'] = "1";
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    countryList = GetCountryModel.fromJson(userData).data!;
    print("this is country list ${countryList.length}");

  }




 @override
 void initState() {
    // TODO: implement initState
    super.initState();
    getCountryList();

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EditProfileController(),
      builder: (controller) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgruond,
          // appBar: AppBar(
          //   leading: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF ),),
          //   backgroundColor: Color(0xff303030),
          //   actions: const [
          //     Padding(
          //       padding: EdgeInsets.all(15),
          //       child: Center(child: Text("Profile Setting", style: TextStyle(fontSize: 15, color:Color(0xff1E90FF ), fontWeight: FontWeight.bold), )),
          //     ),
          //   ],
          // ),
          body:
          controller.profiledata != null || controller.profiledata == "" ?
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 130,
                    child: Stack(children: [
                      Container(
                        color: AppColors.secondary,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0,right: 10,left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.arrow_back_ios,size: 30, color: Color(0xff1E90FF ),)),
                              const Text("Profile Setting",style: TextStyle(color: AppColors.AppbtnColor,fontSize: 16),)
                            ],),
                        ),
                      ),
                      Positioned(
                        top: 40 ,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                          GestureDetector(
                            onTap: (){
                              controller.requestPermission(context,1);
                            },
                            child: Stack(
                              children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(50)),
                              child:   ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child:
                                 controller.profilePic != null || controller.profilePic != '' ?
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child:
                                      // rcImage != null ?
                                      Image.network(controller.profilePic.toString(), fit: BoxFit.cover, height: 90,width: 95,)
                                  )
                                      :
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: controller.imageFile != null
                                        ? Image.file(controller.imageFile!, fit: BoxFit.cover, height: 90,width: 95,)
                                        : Image.asset("assets/images/loginlogo.png",fit: BoxFit.fill,height: 90,width: 95,)
                                  )

                              ),
                                ),
                                Positioned(
                                    top: 65,
                                    left: 60,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(13)),
                                        height: 25,width: 25,
                                        child: Icon(Icons.edit)))

                              ],),
                          ),
                          // SizedBox(height: 10,),

                        ],),)
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child: Column(
                      children: [
                        Text("${controller.firstname} ${controller.lastname}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.AppbtnColor),),
                        SizedBox(height: 5,),
                        Text('ID : ${controller.profiledata!.username.toString()}', style: const TextStyle(fontSize: 15, color: Colors.white),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            controller.profiledata != null ?
                            controller.profiledata!.isPlanActive! == true?
                            Text(
                              controller.profiledata != null ?
                              "${controller.profiledata!.remainingDays} left"
                                  : "15 Days Free Trial ",style: const TextStyle(fontSize: 14, color: AppColors.whit),)
                                : Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: InkWell(
                                onTap: (){
                                  Get.to(SubscriptionScreen());
                                },
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                    decoration: BoxDecoration(
                                        color: AppColors.lightwhite,

                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: const Text("Subscribe Now",style: TextStyle(color: AppColors.whit,
                                        fontSize: 12),)),
                              ),
                            )
                                : const Text("Something went wrong!", style: TextStyle(
                                fontSize: 12
                            ),),

                          ],
                        ),
                        SizedBox(height: 10,),
                        Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff303030)),
                            height: 50,
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Center(child: Text("Your Details", style: TextStyle(fontSize: 18, color: AppColors.AppbtnColor)))
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("First Name", style: TextStyle(color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/2.4,
                                    child: Card(
                                      color:  Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.firstnameController,
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            hintText: '',
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                 const Padding(
                                    padding:  EdgeInsets.only(left: 8.0),
                                    child: Text("Last Name(Surname)", style: TextStyle(color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/2.3,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.lastnameController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter first name';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                            hintText: '',
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Row(
                            //   children: [
                            //     Padding(
                            //       padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            //       child: Container(
                            //         width: MediaQuery.of(context).size.width/2.2,
                            //         child: Card(
                            //           color:  Color(0xff6D6A6A),
                            //           shape: RoundedRectangleBorder(
                            //             borderRadius: BorderRadius.circular(10.0),
                            //           ),
                            //           elevation: 5,
                            //           child: TextFormField(
                            //             controller: controller.firstnameController,
                            //             keyboardType: TextInputType.name,
                            //             decoration: InputDecoration(
                            //                 hintText: '',
                            //                 border: InputBorder.none,
                            //                 contentPadding: EdgeInsets.only(left: 10)
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     // SizedBox(width: 0.5,),
                            //     Container(
                            //       width: MediaQuery.of(context).size.width/2.2,
                            //       child: Card(
                            //         color: Color(0xff6D6A6A),
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(10.0),
                            //         ),
                            //         elevation: 5,
                            //         child: TextFormField(
                            //           controller: controller.lastnameController,
                            //           keyboardType: TextInputType.name,
                            //           validator: (value) {
                            //             if (value!.isEmpty) {
                            //               return 'Please enter first name';
                            //             }
                            //             return null;
                            //           },
                            //           decoration: InputDecoration(
                            //               hintText: '',
                            //               border: InputBorder.none,
                            //               contentPadding: EdgeInsets.only(left: 10)
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(height: 9,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding:  EdgeInsets.only(left: 8.0),
                                    child: Text("Phone Number(Not Editable)", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC))),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.mobileController,
                                        keyboardType: TextInputType.number,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("Email Id", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.emailController,
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff303030)),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: const Center(
                                      child: Text("Company Details", style: TextStyle(fontSize: 18, color: AppColors.AppbtnColor)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.companynameController,
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            hintText: 'Company Name',
                                            hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.companyphoneController,
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        decoration: const InputDecoration(
                                          counterText: '',
                                            hintText: 'Company Phone Number',
                                            hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.companyaddressController,
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            hintText: 'Company Address',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  // SizedBox(height: 5,),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width/1.1,
                                  //   child: Card(
                                  //     color: Color(0xff6D6A6A),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10.0),
                                  //     ),
                                  //     elevation: 5,
                                  //     child:
                                  // DropdownButtonHideUnderline(
                                  //   child: DropdownButton(
                                  //     dropdownColor: AppColors.cardclr,
                                  //     // Initial Value
                                  //     value: controller.countryController,
                                  //     isExpanded: true,
                                  //     hint: const Text(
                                  //       "Country",
                                  //       style: TextStyle(
                                  //           color: AppColors.textclr),
                                  //     ),
                                  //     icon: const Icon(
                                  //       Icons.keyboard_arrow_down,
                                  //       color: AppColors.textclr,
                                  //     ),
                                  //     // Array list of items
                                  //     items: controller.countryList.map((items) {
                                  //       return DropdownMenuItem(
                                  //         value: items,
                                  //         child: Text(
                                  //           items.name.toString(),
                                  //           style: const TextStyle(
                                  //               color: AppColors.textclr),
                                  //         ),
                                  //       );
                                  //     }).toList(),
                                  //     // After selecting the desired option,it will
                                  //     // change button value to selected value
                                  //     onChanged: (newValue) {
                                  //       setState(() {
                                  //          controller.countryController = newValue;
                                  //          controller.countryId;
                                  //         controller.getStateList(controller.countryController);
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                  //   ),
                                  // ),
                                  // SizedBox(height: 5,),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width/1.1,
                                  //   child: Card(
                                  //     color: Color(0xff6D6A6A),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10.0),
                                  //     ),
                                  //     elevation: 5,
                                  //     child:
                                  //     DropdownButtonHideUnderline(
                                  //       child: DropdownButton(
                                  //         dropdownColor: AppColors.cardclr,
                                  //         // Initial Value
                                  //         value: controller.stateController,
                                  //         isExpanded: true,
                                  //         hint: const Text(
                                  //           "State",
                                  //           style: TextStyle(
                                  //               color: AppColors.textclr),
                                  //         ),
                                  //         icon: const Icon(
                                  //           Icons.keyboard_arrow_down,
                                  //           color: AppColors.textclr,
                                  //         ),
                                  //         // Array list of items
                                  //         items: controller.statesList.map((items) {
                                  //           return DropdownMenuItem(
                                  //             value: items.id.toString(),
                                  //             child: Text(
                                  //               items.name.toString(),
                                  //               style: const TextStyle(
                                  //                   color: AppColors.textclr),
                                  //             ),
                                  //           );
                                  //         }).toList(),
                                  //         // After selecting the desired option,it will
                                  //         // change button value to selected value
                                  //         onChanged: (newValue) {
                                  //           setState(() {
                                  //             controller.stateController = newValue;
                                  //             controller.getCitiesList(controller.stateController);
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(height: 5,),
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width/1.1,
                                  //   child: Card(
                                  //     color: Color(0xff6D6A6A),
                                  //     shape: RoundedRectangleBorder(
                                  //       borderRadius: BorderRadius.circular(10.0),
                                  //     ),
                                  //     elevation: 5,
                                  //     child:
                                  //     DropdownButtonHideUnderline(
                                  //       child: DropdownButton(
                                  //         dropdownColor: AppColors.cardclr,
                                  //         // Initial Value
                                  //         value: controller.cityController,
                                  //         isExpanded: true,
                                  //         hint: const Text(
                                  //           "City",
                                  //           style: TextStyle(
                                  //               color: AppColors.textclr),
                                  //         ),
                                  //         icon: const Icon(
                                  //           Icons.keyboard_arrow_down,
                                  //           color: AppColors.textclr,
                                  //         ),
                                  //         // Array list of items
                                  //         items: controller.citiesList.map((items) {
                                  //           return DropdownMenuItem(
                                  //             value: items.id.toString(),
                                  //             child: Text(
                                  //               items.name.toString(),
                                  //               style: const TextStyle(
                                  //                   color: AppColors.textclr),
                                  //             ),
                                  //           );
                                  //         }).toList(),
                                  //         // After selecting the desired option,it will
                                  //         // change button value to selected value
                                  //         onChanged: (newValue) {
                                  //           setState(() {
                                  //             controller.cityController = newValue;
                                  //             // controller.getStateList(controller.stateController);
                                  //           });
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  ///SEARCHABLE DROPDOWN COUNTRY

                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: Stack(
                                        children: [
                                          CustomSearchableDropDown(
                                            // dropdownHintText: "Country",
                                            suffixIcon: const Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: AppColors.whit,
                                            ),
                                            backgroundColor: Color(0xff6D6A6A),
                                            dropdownBackgroundColor:
                                            AppColors.containerclr2,
                                            dropdownItemStyle: const TextStyle(
                                                color: AppColors.whit),
                                            // dropdownHintText: TextStyle(
                                            //   color: AppColors.whit
                                            // ),
                                            items: controller.countryList,
                                            // initialValue:  controller.countryList,
                                            label: '',
                                            labelStyle: const TextStyle(
                                                color: AppColors.whit
                                            ),
                                            multiSelectTag: 'Country',
                                            decoration: BoxDecoration(
                                                color: AppColors.containerclr,
                                                borderRadius:
                                                BorderRadius.circular(15)
                                              // color: Colors.white
                                              // border: Border.all(
                                              //   color: CustomColors.lightgray.withOpacity(0.5),
                                              // )
                                            ),
                                            multiSelect: false,
                                            dropDownMenuItems: controller.countryList.map((item) {
                                              return "${item.name}";
                                            }).toList() ??
                                                [],
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState((){
                                                  controller.countryController = value.name;
                                                  controller.countryId = value.id;
                                                isCountry = false;
                                                });
                                                controller.getStateList(controller.countryId.toString());
                                              }
                                              print("this is my country code ${controller.countryController}");
                                            },
                                          ),
                                          // controller.isCountry ?
                                          Positioned(
                                            left: 10,
                                              top: 15,
                                              // child: controller.isCountry ?
                                            child:  Text(
                                                controller.countryController ?? "", style:  TextStyle(
                                                color: isCountry ? Colors.black : Colors.transparent,
                                                fontSize: 15
                                              ),)
                                          )
                                          // : Text(""))
                                          // : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ///SEARCHABLE DROPDOWN COUNTRY
                                 const  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: Stack(
                                        children: [
                                          CustomSearchableDropDown(
                                            // initialValue: [],
                                            // dropdownHintText: "State",
                                            suffixIcon: const Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: AppColors.whit,
                                            ),
                                            backgroundColor: Color(0xff6D6A6A),
                                            dropdownBackgroundColor:
                                            AppColors.containerclr2,
                                            dropdownItemStyle: const TextStyle(
                                                color: AppColors.whit),
                                            items: controller.statesList,
                                            label: '',
                                            labelStyle: const TextStyle(
                                                color: AppColors.whit
                                            ),
                                            multiSelectTag: 'State',
                                            decoration: BoxDecoration(
                                                color: AppColors.containerclr2,
                                                borderRadius:
                                                BorderRadius.circular(15)
                                              // color: Colors.white
                                              // border: Border.all(
                                              //   color: CustomColors.lightgray.withOpacity(0.5),
                                              // )
                                            ),
                                            multiSelect: false,
                                            dropDownMenuItems: controller.statesList.map((item) {
                                              return "${item.name}";
                                            }).toList() ??
                                                [],
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState((){
                                                  controller.stateController = value.name;
                                                  controller.stateId = value.id;
                                                  isState = false;
                                                });
                                                 controller.getCitiesList(controller.stateId.toString());
                                                print("this is state request ${controller.stateController.toString()}");
                                              }

                                            },
                                          ),
                                          // controller.isState?
                                          Positioned(
                                              left: 10,
                                              top: 15,
                                              child: Text(
                                                controller.stateController ?? "", style:  TextStyle(
                                                  fontSize: 15,
                                                  color: isState ? Colors.black : Colors.transparent
                                              ),))
                                              // : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: Stack(
                                        children: [
                                          CustomSearchableDropDown(
                                            // dropdownHintText: "City",
                                            suffixIcon: const Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              color: AppColors.whit,
                                            ),
                                            backgroundColor: Color(0xff6D6A6A),
                                            dropdownBackgroundColor:
                                            AppColors.containerclr2,
                                            dropdownItemStyle: const TextStyle(
                                                color: AppColors.whit),
                                            // dropdownHintText: TextStyle(
                                            //   color: AppColors.whit
                                            // ),
                                            items: controller.citiesList,
                                            label: '',
                                            labelStyle: const TextStyle(
                                                color: AppColors.whit
                                            ),
                                            multiSelectTag: 'City',
                                            decoration: BoxDecoration(
                                                color: AppColors.containerclr2,
                                                borderRadius:
                                                BorderRadius.circular(15)
                                              // color: Colors.white
                                              // border: Border.all(
                                              //   color: CustomColors.lightgray.withOpacity(0.5),
                                              // )
                                            ),
                                            multiSelect: false,
                                            dropDownMenuItems: controller.citiesList.map((item) {
                                              return "${item.name}";
                                            }).toList() ??
                                                [],
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState((){
                                                  controller.cityController = value.name;
                                                  isCity = false;
                                                });
                                                // getCitiesList(stateController.toString());
                                              }
                                              print("this is my country code ${cityController}");
                                            },
                                          ),
                                          // controller.isCity ? z
                                        Positioned(
                                              left: 10,
                                              top: 15,
                                              child: Text(
                                                controller.cityController ?? "", style:  TextStyle(
                                                  fontSize: 15,
                                                color: isCity ? Colors.black : Colors.transparent
                                              ),))
                                              // : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),


                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Company Website Link/ Email Id", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.companyEmailController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Enter Link / Email Id',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("FaceBook Page Link", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.facebookController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Paste here facebook page link',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Instagram Page Link", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.instagramController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Paste here instagram page link',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Youtube Channel Link", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.youtubeController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Paste here Youtube Channel link',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Terms & Condition For Quotation PDF", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    height: 70,
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextField(
                                        maxLines: 30,
                                        controller: controller.termsconditionControlletr,
                                        keyboardType: TextInputType.multiline,
                                        // keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            hintText: 'Paste here from Notepad/Text File',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10, top: 12)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      controller.requestPermission(context,2);
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.width/2.4,
                      width: MediaQuery.of(context).size.width/2.4,
                      child: Card(
                          color: const Color(0xff6D6A6A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: controller.companyLogo == null || controller.companyLogo == '' ?
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: controller.imageFile2 != null
                                  ? Image.file(controller.imageFile2!, fit: BoxFit.cover, height: 90,width: 95,)
                                  : const Center(child: Text("Upload Company Logo",style: TextStyle(fontSize: 18),))
                            // Image.asset("assets/images/loginlogo.png",fit: BoxFit.fill,height: 90,width: 95,)
                          )
                              : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child:
                              // rcImage != null ?
                              Image.network(controller.companyLogo.toString(), fit: BoxFit.cover, height: 90,width: 95,)
                          )

                        // controller.imageFile2 != null || controller.imageFile2 == "" ? Container(
                        //     decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                        //     child: Image.file(controller.imageFile2!,fit: BoxFit.fill,height: 80,)) : Center(child: const Text("Upload Company Logo",style: TextStyle(fontSize: 18),))
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      if (_formKey.currentState!.validate()) {
                        controller.updateProfile();
                      } else {
                        // Form is invalid, display error message
                      }

                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width/2.2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: AppColors.AppbtnColor),
                      child: const Center(child: Text("Update",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                      ),
                      ),
                    ),
                  ),
                 const SizedBox(height: 20,)
                ],
              ),
            ),
          ): const Center(child: CircularProgressIndicator())
        ),
      );
    },);
  }
}
