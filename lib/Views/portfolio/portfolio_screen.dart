import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kolazz_book/Controller/edit_profile_controller.dart';
import 'package:kolazz_book/Models/Type_of_photography_model.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Models/get_portfolio_model.dart';
import 'package:kolazz_book/Models/get_states_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:kolazz_book/Views/edit_profile/edit_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Controller/home_controller.dart';
import '../../Utils/colors.dart';
import 'add_portfolio.dart';
import 'my_portfolio.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  String? selectedcityList;
  var categoryValue;
  var categoryValue1;
  var categoryValue2;

  List<CityList> citiesList = [];
  List<StateList> statesList = [];
  List<Categories> typeofPhotographyEvent = [];

  var stateController;
  var stateName;
  var cityController;
  var cityName;
  var typeController;
  var typeName;
  String countryName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPortfolios();
    getUserPortfolioData();
    getStateList('');
    getPhotographerType();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  getCitiesList(String stateId) async {
    var uri = Uri.parse(getCitiesApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['state_id'] = stateId.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    citiesList = GetCitiesModel.fromJson(userData).data!;
    print("this is working ${citiesList.length}");
    setState(() {});
  }

  getStateList(String countryId) async {
    var uri = Uri.parse(getStatesApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['country_name'] = countryId.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    statesList = GetStatesModel.fromJson(userData).data!;
    setState(() {});
  }

  getPhotographerType() async {
    var uri = Uri.parse(getPhotographerApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
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

    // collectionModal = AllCateModel.fromJson(userData);
    typeofPhotographyEvent = TypeofPhotography.fromJson(userData).categories!;
    // print(
    //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
    print("this is photographer $typeofPhotographyEvent");
  }

  List<Portfolio> getPortfolioData = [];

  List<Portfolio> myPortfolioData = [];

  getPortfolios() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(getPortfolioApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    // request.fields[RequestKeys.userId] = id!;
    request.fields['city'] = cityName != null ? cityName.toString() : '';
    request.fields['category'] =
        typeController != null ? typeController.toString() : '';
    request.fields['state'] = stateName != null ? stateName.toString() : '';
    // request.fields[RequestKeys.type] = 'client';
    var response = await request.send();
    print("this is my portfolio request ${request.fields.toString()}");
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      getPortfolioData = GetPortfolioModel.fromJson(userData).data!;
    });
    print("this is portfolio data ${getPortfolioData.length}");
  }

  getUserPortfolioData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(getPortfolioApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = id!;
    var response = await request.send();
    print("this is my portfolio request ${request.fields.toString()}");
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      myPortfolioData = GetPortfolioModel.fromJson(userData).data!;
    });
    print("this is portfolio data ${getPortfolioData.length}");
  }

  Future<Null> _refresh() {
    return callApi();
  }

  callApi() {
    statesList.clear();
    citiesList.clear();
    typeofPhotographyEvent.clear();

    setState(() {
      stateController = null;
      stateName = null;
      cityName = null;
      cityController = null;
      typeController = null;
      typeName = null;
    });
    getPortfolios();
    getUserPortfolioData();
    getStateList('');
    getPhotographerType();
  }

  @override
  Widget build(BuildContext context) {
    return
        // RefreshIndicator(
        //   color: AppColors.AppbtnColor,
        //   key: _refreshIndicatorKey,
        //   onRefresh: _refresh,
        //   child:
        Scaffold(
            backgroundColor: AppColors.backgruond,
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
            body: GetBuilder(
                init: HomeController(),
                builder: (controller) {
                  countryName = controller.profiledata!.country!;
                  getStateList(countryName);
                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 70,
                          color: const Color(0xff303030),
                          child: GetBuilder(
                              init: EditProfileController(),
                              builder: (controller) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // Get.to(EditProfileScreen());
                                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> MyPortfolioScreen(data: myPortfolioData[0])));
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  child: controller
                                                                  .profilePic ==
                                                              null ||
                                                          controller
                                                                  .profilePic ==
                                                              ''
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          child: controller
                                                                      .imageFile !=
                                                                  null
                                                              ? Image.file(
                                                                  controller
                                                                      .imageFile!,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  height: 40,
                                                                  width: 40,
                                                                )
                                                              : Image.asset(
                                                                  "assets/images/loginlogo.png",
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height: 40,
                                                                  width: 40,
                                                                ))
                                                      : ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(40),
                                                          child:
                                                              // rcImage != null ?
                                                              Image.network(
                                                            controller
                                                                .profilePic
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              controller.profiledata != null ||
                                                      controller.profiledata ==
                                                          ""
                                                  ? Text(
                                                      "${controller.profiledata!.fname} ${controller.profiledata!.lname} ",
                                                      style: const TextStyle(
                                                          color: AppColors
                                                              .AppbtnColor,
                                                          fontSize: 15),
                                                    )
                                                  : CircularProgressIndicator(),
                                              InkWell(
                                                  onTap: () {
                                                    if (myPortfolioData
                                                        .isNotEmpty) {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddPortfolioScreen(
                                                                      data: myPortfolioData[
                                                                          0])));
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  AddPortfolioScreen()));
                                                    }
                                                  },
                                                  child: const Text(
                                                    "My Portfolio",
                                                    style: TextStyle(
                                                        color: AppColors.whit,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // SizedBox(
                              //   width: 17,
                              // ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 2.0, bottom: 5),
                                    child: Text(
                                      "Filter by State",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    ),
                                  ),
                                  Container(
                                    // height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.teamcard2
                                        //Color(0xff686767),
                                        ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: CustomSearchableDropDown(
                                        dropdownHintText: "State",
                                        suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: AppColors.teamcard2,
                                        ),
                                        backgroundColor: AppColors.teamcard2,
                                        dropdownBackgroundColor:
                                            AppColors.teamcard2,
                                        // AppColors.containerclr2,
                                        dropdownItemStyle: const TextStyle(
                                            color: AppColors.whit),
                                        // dropdownHintText: TextStyle(
                                        //   color: AppColors.whit
                                        // ),
                                        items: statesList,
                                        label: 'State',
                                        labelStyle: const TextStyle(
                                            color: AppColors.whit),
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
                                        dropDownMenuItems:
                                            statesList.map((item) {
                                                  return "${item.name}";
                                                }).toList() ??
                                                [],
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              stateController = value.id;
                                              stateName = value.name;
                                            });
                                            getCitiesList(
                                                stateController.toString());
                                            getPortfolios();
                                          }
                                          print(
                                              "this is my country code ${stateController}");
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 2.0, bottom: 5),
                                    child: Text(
                                      "Filter by City",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11),
                                    ),
                                  ),
                                  Container(
                                    // height: 50,
                                    width:
                                        MediaQuery.of(context).size.width / 2 -
                                            20,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.teamcard2,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8),
                                      child: CustomSearchableDropDown(
                                        dropdownHintText: "City",
                                        suffixIcon: const Icon(
                                          Icons.keyboard_arrow_down_sharp,
                                          color: AppColors.teamcard2,
                                        ),
                                        backgroundColor: AppColors.teamcard2,
                                        dropdownBackgroundColor:
                                            AppColors.teamcard2,
                                        dropdownItemStyle: const TextStyle(
                                            color: AppColors.whit),
                                        // dropdownHintText: TextStyle(
                                        //   color: AppColors.whit
                                        // ),
                                        items: citiesList,
                                        label: 'City',
                                        labelStyle: const TextStyle(
                                            color: AppColors.whit),
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
                                        dropDownMenuItems:
                                            citiesList.map((item) {
                                                  return "${item.name}";
                                                }).toList() ??
                                                [],
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              cityController = value.id;
                                              cityName = value.name;
                                            });
                                          }
                                          getPortfolios();
                                          print(
                                              "this is my country code ${cityController}");
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 15.0, bottom: 5, left: 12),
                          child: Text(
                            "Filter By Type of Photography",
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                // height: 50,
                                width: MediaQuery.of(context).size.width / 1.4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.teamcard2,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8),
                                  child: CustomSearchableDropDown(
                                    dropdownHintText: "Type of Photography",
                                    suffixIcon: const Icon(
                                      Icons.keyboard_arrow_down_sharp,
                                      color: AppColors.whit,
                                    ),
                                    backgroundColor: AppColors.teamcard2,
                                    dropdownBackgroundColor:
                                        AppColors.teamcard2,
                                    dropdownItemStyle:
                                        const TextStyle(color: AppColors.whit),
                                    // dropdownHintText: TextStyle(
                                    //   color: AppColors.whit
                                    // ),
                                    items: typeofPhotographyEvent,
                                    label: 'Type of Photography',
                                    labelStyle:
                                        const TextStyle(color: AppColors.whit),
                                    multiSelectTag: 'Type of Photography',
                                    decoration: BoxDecoration(
                                        color: AppColors.containerclr2,
                                        borderRadius: BorderRadius.circular(15)
                                        // color: Colors.white
                                        // border: Border.all(
                                        //   color: CustomColors.lightgray.withOpacity(0.5),
                                        // )
                                        ),
                                    multiSelect: false,
                                    dropDownMenuItems:
                                        typeofPhotographyEvent.map((item) {
                                              return "${item.resName}";
                                            }).toList() ??
                                            [],
                                    onChanged: (value) {
                                      if (value != null) {
                                        setState(() {
                                          typeController = value.resId;
                                          typeName = value.resName;
                                        });
                                        getPortfolios();
                                      }
                                      print(
                                          "this is my country code ${typeController}");
                                    },
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    // stateName = null;
                                    // stateController = null;
                                    _refresh();
                                    // stateController = null;
                                    // stateName = null;
                                    // cityController = null;
                                    // cityName = null;
                                    // typeController = null ;
                                    // typeName = null;
                                  });
                                  // setState(() {
                                  // });
                                },
                                child: Text(
                                  'Clear',
                                  style: TextStyle(color: AppColors.whit),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.contaccontainerred),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        getPortfolioData.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    itemCount: getPortfolioData.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyPortfolioScreen(
                                                          data:
                                                              getPortfolioData[
                                                                  index])));
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Container(
                                            // height: 200,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: AppColors.teamcard2,
                                            child: Stack(
                                              children: [
                                                Column(
                                                  children: [
                                                    getPortfolioData[index]
                                                                    .coverImage !=
                                                                null ||
                                                            getPortfolioData[
                                                                        index]
                                                                    .coverImage
                                                                    .toString() !=
                                                                ''
                                                        ? Container(
                                                            height: 120,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .whit,
                                                                image: DecorationImage(
                                                                    image: NetworkImage(getPortfolioData[
                                                                            index]
                                                                        .coverImage
                                                                        .toString()),
                                                                    fit: BoxFit
                                                                        .fill)),
                                                          )
                                                        : Container(
                                                            height: 120,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color:
                                                                        AppColors
                                                                            .whit,
                                                                    image:
                                                                        DecorationImage(
                                                                      image: AssetImage(
                                                                          "assets/images/loginlogo.png"),
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    )),
                                                          ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 50,
                                                              left: 25,
                                                              bottom: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${getPortfolioData[index].fname.toString()} ${getPortfolioData[index].lname.toString()}',
                                                                style: const TextStyle(
                                                                    color: Color(
                                                                        0xff42ACFE),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5.0),
                                                                child: Text(
                                                                  '${getPortfolioData[index].city.toString()} ${getPortfolioData[index].state.toString()} ${getPortfolioData[index].country.toString()}',
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          13),
                                                                ),
                                                              ),
                                                              Text(
                                                                getPortfolioData[index].companyName ==
                                                                            null ||
                                                                        getPortfolioData[index].companyName ==
                                                                            ''
                                                                    ? ""
                                                                    : getPortfolioData[index]
                                                                            .companyName
                                                                            .toString() ??
                                                                        "",
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        13),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Text(
                                                              getPortfolioData[
                                                                      index]
                                                                  .categoryId
                                                                  .toString(),
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize: 14),
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
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColors
                                                                .AppbtnColor),
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                getPortfolioData[
                                                                        index]
                                                                    .profilePic
                                                                    .toString()))),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            : const Center(
                                child: Text(
                                  "No data to show!",
                                  style: TextStyle(color: AppColors.whit),
                                ),
                              ),
                        // Container(
                        //   width: double.infinity,
                        //   height: 5,
                        //   color: Colors.black,
                        // ),
                        // Container(
                        //   height: 200,
                        //   width: double.infinity,
                        //   child: Stack(
                        //     children: [
                        //       Container(
                        //         color: Colors.grey,
                        //       ),
                        //       Positioned(
                        //         top: 0,
                        //         left: 0,
                        //         child: Container(
                        //           height: 120,
                        //           width: 360,
                        //           color: Colors.lightBlue,
                        //         ),
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.only(top: 90, left: 25),
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //               //shape: BoxShape.circle,
                        //               //border: Border.all(
                        //               //color: Colors.blue, // Set the outline border color
                        //               //width: 1, // Set the outline border width
                        //               //),
                        //               ),
                        //           child: Row(
                        //             children: [
                        //               Column(
                        //                 mainAxisAlignment: MainAxisAlignment.start,
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   CircleAvatar(
                        //                     backgroundColor: Colors.white,
                        //                     radius: 28,
                        //                   ),
                        //                   Text(
                        //                     "Ramesh Patel",
                        //                     style: TextStyle(
                        //                         color: Color(0xff42ACFE),
                        //                         fontWeight: FontWeight.bold,
                        //                         fontSize: 15),
                        //                   ),
                        //                   Text(
                        //                     "City,State,Country",
                        //                     style: TextStyle(
                        //                         color: Colors.white,
                        //                         fontWeight: FontWeight.w400,
                        //                         fontSize: 13),
                        //                   ),
                        //                   Text(
                        //                     "Company Name",
                        //                     style: TextStyle(
                        //                         color: Colors.white,
                        //                         fontWeight: FontWeight.w400,
                        //                         fontSize: 13),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.only(left: 159, top: 30),
                        //                 child: Text(
                        //                   "Category",
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.w400,
                        //                       fontSize: 14),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // Container(
                        //   height: 109,
                        //   width: MediaQuery.of(context).size.width,
                        //   color: Colors.black54,
                        // ),
                      ],
                    ),
                  );
                }));
    // );
  }
}
