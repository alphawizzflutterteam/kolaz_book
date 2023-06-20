import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kolazz_book/Controller/broadcast_controller.dart';
import 'package:kolazz_book/Controller/edit_profile_controller.dart';
import 'package:kolazz_book/Controller/home_controller.dart';
import 'package:kolazz_book/Models/broadcast_list_model.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Models/get_country_model.dart';
import 'package:kolazz_book/Models/get_states_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/Type_of_photography_model.dart';
import '../../Utils/colors.dart';

class Broadcast_screen extends StatefulWidget {
  const Broadcast_screen({Key? key}) : super(key: key);

  @override
  State<Broadcast_screen> createState() => _Broadcast_screenState();
}

class _Broadcast_screenState extends State<Broadcast_screen> {
  bool _isToggled = false;

  List<CityList> citiesList = [];
  List<StateList> statesList = [];
  List<Countries> countryList = [];
  List<Categories> typeofPhotographyEvent = [];
  List<BroadcastList> broadCastList = [];
  var cityController;
  var countryController;
  var stateController;
  var photoGrapherType;
  String? message;



  DateTime? selectedDates;
  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();
  TextEditingController cityNameController = TextEditingController();

  Future<void> selectDate(BuildContext context,) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDates) {
      setState((){
        selectedDates = pickedDate;
      });

      // update();
    }
  }

  getPhotographerType() async {
    var uri = Uri.parse(getPhotographerApi.toString());
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

    // collectionModal = AllCateModel.fromJson(userData);
    typeofPhotographyEvent = TypeofPhotography.fromJson(userData).categories!;
    // print(
    //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
    print("this is photographer $typeofPhotographyEvent");
  }

  getBroadCastData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var uri = Uri.parse(getBroadcastListApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
     request.fields[RequestKeys.userId] =  userId.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    var finalResult = BroadcastListModel.fromJson(userData);

  setState(() {
    message  = finalResult.leftMessage.toString();
    broadCastList = BroadcastListModel.fromJson(userData).data!;
  });
    print("this is my message ${finalResult.leftMessage}");

  }

  addBroadCastData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var uri = Uri.parse(addBroadcastDataApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] =  userId.toString();
    request.fields[RequestKeys.type] =  photoGrapherType.toString();
    request.fields['date'] =  DateFormat('dd/MM/yyyy').format(selectedDates!).toString();
    request.fields[RequestKeys.country] =  countryController.toString();
    request.fields[RequestKeys.state] =  stateController.toString();
    request.fields[RequestKeys.city] =  cityController.toString();

    print("this is add broadcast request ${request.fields.toString()}");
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    if(response.statusCode == 200) {
      String responseData = await response.stream.transform(utf8.decoder)
          .join();
      var userData = json.decode(responseData);
      if (userData['error']) {
        Fluttertoast.showToast(msg: userData['message']);
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: userData['message']);
      }
    }


    // collectionModal = AllCateModel.fromJson(userData);
    // broadCastList = BroadcastListModel.fromJson(userData).data!;
    // print(
    //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
    print("this is photographer $typeofPhotographyEvent");
  }

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
    setState(() {

    });
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
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    statesList = GetStatesModel.fromJson(userData).data!;
    setState(() {

    });
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
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryList();
    getPhotographerType();
    getBroadCastData();
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: AppColors.backgruond,
        appBar: AppBar(
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
          backgroundColor: Color(0xff303030),

          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0,right: 10),
                  child: const Text("Broadcast", style: TextStyle(fontSize: 18, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
                  ),
                ),
                Expanded(
                  child:Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: FlutterSwitch(
                      height: 20.0,
                      width: 40.0,
                      padding: 4.0,
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      activeColor: AppColors.AppbtnColor,
                      value: _isToggled,
                      onToggle: (value) {
                        setState(() {
                          _isToggled = value;
                        });
                      },
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(_isToggled ? Icons.toggle_on_outlined : Icons.toggle_off,color: AppColors.AppbtnColor,size: 40,),
                  //   onPressed: () {
                  //     setState(() {
                  //       _isToggled = !_isToggled;
                  //     });
                  //   },
                  //
                  // ),
                ),
              ],
            ),
          ],
        ),
        body:
            // GetBuilder(
            //   init: BroadcastController(),
            //   builder: (controller){
            //     return
                  SingleChildScrollView(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.st,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width /2.5,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.containerclr2,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: GetBuilder(
                                    init: HomeController(),
                                  builder: (controller) {
                                    return controller.profiledata != null || controller.profiledata == "" ?
                                    Center(
                                      child: Text("Hi, ${controller.profiledata!.fname} ${controller.profiledata!.lname} ",
                                        style: TextStyle(color: AppColors.whit,fontSize: 15),),
                                    )
                                        : CircularProgressIndicator();
                                  }
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width /2.5,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.containerclr2,
                                    borderRadius: BorderRadius.circular(10)
                                ),

                                child: Center(child: Text(message.toString(),overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.whit),)),
                              )
                            ],
                          ),
                          SizedBox(height: 12,),
                          Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.containerclr2,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      Text("What You Need?",style: TextStyle(color:Color(0xff1E90FF,),fontSize: 17),),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Photographer",style: TextStyle( color:Color(0xff1E90FF)),),
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width/2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.backgruond,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton(
                                                  dropdownColor: AppColors.cardclr,
                                                  // Initial Value
                                                  value: photoGrapherType,
                                                  isExpanded: true,
                                                  hint: const Text(
                                                    "Type Of Photography",
                                                    style: TextStyle(color: AppColors.textclr),
                                                  ),
                                                  icon: const Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: AppColors.textclr,
                                                  ),
                                                  // Array list of items
                                                  items: typeofPhotographyEvent
                                                      .map((Categories items) {
                                                    return DropdownMenuItem(
                                                      value: items.resId,
                                                      child: Text(
                                                        items.resName.toString(),
                                                        style: const TextStyle(
                                                            color: AppColors.textclr),
                                                      ),
                                                    );
                                                  }).toList(),
                                                  // After selecting the desired option,it will
                                                  // change button value to selected value
                                                  onChanged: (newValue) {
                                                  photoGrapherType = newValue.toString();
                                                  print("this is photographer $photoGrapherType");

                                                    setState(() {});
                                                  },
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Date",style: TextStyle( color:Color(0xff1E90FF)),),
                                          InkWell(
                                            onTap: () async{
                                              final DateTime? pickedDate = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                lastDate: DateTime(2100),
                                              );
                                              if (pickedDate != null && pickedDate != selectedDates) {
                                                setState((){
                                                  selectedDates = pickedDate;
                                                });
                                                // update();
                                              }
                                              print("this is selected dat $selectedDates");
                                            },
                                            child: Container(
                                              height: 50,
                                              width: MediaQuery.of(context).size.width/2,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: AppColors.backgruond,
                                              ),
                                              child:  Padding(
                                                padding:  EdgeInsets.only(left: 8.0, top: 15),
                                                child:
                                                 selectedDates != null  ?
                                                Text(DateFormat('dd/MM/yyyy').format(selectedDates!).toString(), style: const TextStyle(color: AppColors.whit))
                                                :  const Text("Select Date", style: TextStyle(color: AppColors.whit),)

                                              ),
                                            ),
                                          )
                                        ],),

                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Country",style: TextStyle( color:Color(0xff1E90FF)),),
                                          Container(
                                            // height: 50,
                                            width: MediaQuery.of(context).size.width/2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.backgruond,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                                              child:  CustomSearchableDropDown(
                                                dropdownHintText: "Country",
                                                suffixIcon: const Icon(
                                                  Icons.keyboard_arrow_down_sharp,
                                                  color: AppColors.whit,
                                                ),
                                                backgroundColor: AppColors.backgruond,
                                                //Color(0xff6D6A6A),
                                                dropdownBackgroundColor:
                                                AppColors.containerclr2,
                                                dropdownItemStyle: const TextStyle(
                                                    color: AppColors.whit),
                                                // dropdownHintText: TextStyle(
                                                //   color: AppColors.whit
                                                // ),
                                                items: countryList,
                                                label: 'Country',
                                                labelStyle: const TextStyle(
                                                    color: AppColors.whit
                                                ),
                                                multiSelectTag: 'Country',
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
                                                dropDownMenuItems: countryList.map((item) {
                                                  return "${item.name}";
                                                }).toList() ??
                                                    [],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState((){
                                                      countryController = value.id;
                                                    });
                                                    getStateList(countryController.toString());
                                                  }
                                                  print("this is my country code ${countryController}");
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("State",style: TextStyle( color:Color(0xff1E90FF)),),
                                          Container(
                                            // height: 50,
                                            width: MediaQuery.of(context).size.width/2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.backgruond,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                                              child:  CustomSearchableDropDown(
                                                dropdownHintText: "State",
                                                suffixIcon: const Icon(
                                                  Icons.keyboard_arrow_down_sharp,
                                                  color: AppColors.whit,
                                                ),
                                                backgroundColor: AppColors.backgruond,
                                                dropdownBackgroundColor:
                                                AppColors.containerclr2,
                                                dropdownItemStyle: const TextStyle(
                                                    color: AppColors.whit),
                                                // dropdownHintText: TextStyle(
                                                //   color: AppColors.whit
                                                // ),
                                                items: statesList,
                                                label: 'State',
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
                                                dropDownMenuItems: statesList.map((item) {
                                                  return "${item.name}";
                                                }).toList() ??
                                                    [],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState((){
                                                    stateController = value.id;
                                                    });
                                                     getCitiesList(stateController.toString());
                                                  }
                                                  print("this is my country code ${stateController}");
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("City",style: TextStyle( color:Color(0xff1E90FF)),),
                                          Container(
                                            // height: 50,
                                            width: MediaQuery.of(context).size.width/2,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: AppColors.backgruond,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 8.0),
                                              child:   CustomSearchableDropDown(
                                                dropdownHintText: "City",
                                                suffixIcon: const Icon(
                                                  Icons.keyboard_arrow_down_sharp,
                                                  color: AppColors.whit,
                                                ),
                                                backgroundColor: AppColors.backgruond,
                                                dropdownBackgroundColor:
                                                AppColors.containerclr2,
                                                dropdownItemStyle: const TextStyle(
                                                    color: AppColors.whit),
                                                // dropdownHintText: TextStyle(
                                                //   color: AppColors.whit
                                                // ),
                                                items: citiesList,
                                                label: 'City',
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
                                                dropDownMenuItems: citiesList.map((item) {
                                                  return "${item.name}";
                                                }).toList() ??
                                                    [],
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    setState((){
                                                      cityController = value.id;
                                                    });
                                                    // getStateList(countryController.toString());
                                                  }
                                                  print("this is my country code ${cityController}");
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 20,),
                                      SizedBox(height: 50,width: MediaQuery.of(context).size.width,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // if(countryController == null || stateController == null || cityController == null ||
                                              //     photoGrapherType == null ||
                                              // selectedDates == null) {
                                              // Fluttertoast.showToast(msg: "Please select all required field!");
                                              // }else{
                                                addBroadCastData();
                                              // }
                                            },
                                            child: const Text('Send'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Color(0xff40ACFF),
                                              shape: StadiumBorder(),
                                            ),
                                          )
                                      ),
                                      SizedBox(height: 10,),
                                      const Text("Note-All KalazBook User See Your Broadcasr Message You Can send 2 message in 24 hrs",
                                        style: TextStyle(fontSize: 9,color: AppColors.whit), )

                                    ],
                                  ),
                                ),

                              ),
                              SizedBox(height: 18,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(child: Text("Kolaz Book Users",style: TextStyle(color:Color(0xff1E90FF),fontWeight: FontWeight.bold,fontSize: 18),),alignment: Alignment.topLeft,),
                                  Align(child: Text("India",style: TextStyle(color:Color(0xff1E90FF),fontWeight: FontWeight.bold,fontSize: 18),),alignment: Alignment.topLeft,),
                                ],),
                              SizedBox(height: 18,),
                              broadCastList.isNotEmpty ?
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: broadCastList.length,
                                  itemBuilder: (context, index){
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff6D6A6A),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Align(alignment: Alignment.topRight, child: SizedBox(height:5, child: IconButton(onPressed: (){}, icon: Icon(Icons.phone,color: Color(0xff1E90FF),)))),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: NetworkImage('https://media.istockphoto.com/id/877022826/photo/portrait-of-a-happy-young-asian-business-man.jpg?b=1&s=170667a&w=0&k=20&c=zBdoktuoe8bFhuBsdvtQgL_nJPnrZUn2gSf7OL3X2dM='),
                                                radius: 45,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("${broadCastList[index].userName}",style: TextStyle(fontSize: 16, color:Color(0xff1E90FF),fontWeight: FontWeight.bold),),
                                                    SizedBox(width: 200,
                                                        child: Text("I need ${broadCastList[index].typeOfPhotograpym} on ${broadCastList[index].date} in ${broadCastList[index].cityName}",overflow: TextOverflow.ellipsis,maxLines: 4,style: TextStyle(color: AppColors.textclr),))
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              })
                              : Container(
                                child: Text("No Data to show!", style: TextStyle(
                                  color: AppColors.whit
                                ),),
                              ),
                              SizedBox(height: 10,),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
            //   },
            // )


      );
  }
}
