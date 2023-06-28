import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kolazz_book/Models/Type_of_photography_model.dart';
import 'package:kolazz_book/Models/event_type_model.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Models/get_freelancer_jobs_model.dart';
import 'package:kolazz_book/Models/photographer_list_model.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/colors.dart';

class EditFreelanceJob extends StatefulWidget {
  final bool? type;
  final AllJobs? allJobs;
  final UpcomingJobs? upcomingJobs;
  const EditFreelanceJob({Key? key, this.type, this.allJobs, this.upcomingJobs})
      : super(key: key);

  @override
  State<EditFreelanceJob> createState() => _EditFreelanceJobState();
}

class _EditFreelanceJobState extends State<EditFreelanceJob> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotographerType();
    getPhotographerList();
    getEventTypes();
    getCitiesList();

    if (widget.type == true) {
      setState(() {
        cityNameController.text = widget.allJobs!.cityName.toString();
        eventController = widget.allJobs!.eventId.toString();
        photographerid = widget.allJobs!.photographerId.toString();
        photographerType = widget.allJobs!.typeOfPhotography;
        // amountController.text = widget.allJobs!.amount.toString();
        // outputController.text = widget.allJobs!.output.toString();
      });
    } else {
      setState(() {
        cityNameController.text = widget.upcomingJobs!.cityName.toString();
        eventController = widget.upcomingJobs!.eventId.toString();
        photographerid = widget.upcomingJobs!.photographerId.toString();
        photographerType = widget.upcomingJobs!.typeOfPhotography;
        // amountController.text = widget.upcomingJobs!.amount.toString();
        // outputController.text = widget.upcomingJobs!.output.toString();
      });
    }
  }

  List jsonData = [];

  List<Categories> typeofPhotographyEvent = [];
  List<Data> photographersList = [];
  List<EventType> eventList = [];
  List<CityList> citiesList = [];
  TextEditingController amountController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var photographerName;

  var eventController;
  var cityController;
  var photographerType;
  var photographer;
  // String? selectDates;
  // String? selectTimes;
  var photographerid;
  var totall = 0;
  double totalAmount = 0.0;
  List<int> amountlist = [];

  // List<DateTime> selectedDates = [DateTime.now()];
  DateTime? selectedDates;
  TimeOfDay? selectedTime;
  TimeOfDay? selectedTime2;
  TextEditingController cityNameController = TextEditingController();

  Future<void> selectDate(BuildContext context, setState) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDates) {
      setState(() {
        selectedDates = pickedDate;
      });
      // update();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;
      selectTime2(context);
      // update();

    }
  }

  Future<void> selectTime2(BuildContext context) async {
    final TimeOfDay? pickedTime2 = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime2 != null && pickedTime2 != selectedTime2) {
      selectedTime2 = pickedTime2;
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

  getPhotographerList() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var uri = Uri.parse(getClientPhotographersApi.toString());

    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.fields.addAll({
      'user_id': userId.toString(),
      'type': 'photographers',
    });
    request.headers.addAll(headers);
    // request.fields['user_id'] = userId.toString();
    // request.fields['type'] = 'photographer';
    print("this is my photographer requeswt ${request.fields.toString()}");
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    final result = PhotographerListModel.fromJson(userData);
    setState(() {
      photographersList = result.data!;
      // photographeridd = photographersList[0].id;
    });
    print("this is photographersList ${photographersList[0].firstName}");
  }

  getEventTypes() async {
    var uri = Uri.parse(getEventsApis.toString());
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

    setState(() {
      eventList = EventTypeModel.fromJson(userData).categories!;
    });
  }

  getCitiesList() async {
    var uri = Uri.parse(getCitiesApi.toString());
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

    setState(() {
      citiesList = GetCitiesModel.fromJson(userData).data!;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  Future<void> editUpdateInformationDialog(BuildContext context, int index, var data) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              backgroundColor: AppColors.back,
              content: Form(
                  key: _formKey,
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () async {
                          await selectDate(context,setState);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width /2,
                          height: 45,
                          padding: const EdgeInsets.only(
                              left: 8, top: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.containerclr2),
                          child: Text(selectedDates != null
                              ? ' ${DateFormat('dd-MM-yyyy').format(selectedDates!)}'
                              : 'Select Date ',
                            style: const TextStyle(
                                color: AppColors.textclr,
                                fontSize: 12),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width /2,
                          height: 45,
                          padding: const EdgeInsets.only(
                              left: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.containerclr2),
                          child: TextFormField(
                            style: const TextStyle(
                                color: AppColors.textclr),
                            // controller: controller.outputController,
                            keyboardType: TextInputType.number,
                            controller: amountController,
                            validator: (value) => value!.isEmpty
                                ? 'Amount cannot be blank'
                                : null,
                            decoration: const InputDecoration(
                              // contentPadding: EdgeInsets.only(bottom: 5),
                              hintText: 'Enter Amount',
                              hintStyle: TextStyle(
                                  color: AppColors.textclr,
                                  fontSize: 14),
                              border: InputBorder.none,
                              // contentPadding: EdgeInsets.only(
                              //     left: 8)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 15),
                        child: Container(
                          width: MediaQuery.of(context).size.width /2,
                          height: 60,
                          padding: const EdgeInsets.only(
                              left: 8, top: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.containerclr2),
                          child: TextFormField(
                            style: const TextStyle(
                                color: AppColors.textclr),
                            // controller: controller.outputController,
                            keyboardType: TextInputType.text,
                            maxLines: 4,
                            controller: descriptionController,
                            validator: (value) => value!.isEmpty
                                ? 'Description cannot be blank'
                                : null,
                            decoration: const InputDecoration(
                              hintText: 'Enter Description',
                              hintStyle: TextStyle(
                                  color: AppColors.textclr,
                                  fontSize: 14),
                              border: InputBorder.none,
                              // contentPadding: EdgeInsets.only(
                              //     left: 8)
                            ),
                          ),
                        ),
                      ),

                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            setState((){
                              // descriptionController  = TextEditingController(
                              //     text: widget.allJobs?.jsonData?[index].description
                              // );
                              data.amount = amountController.text.toString();
                              data.description = descriptionController.text.toString();
                            });
                            Navigator.pop(context);
                          },
                          child: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.pdfbtn),
                              child: const Center(
                                  child: Text("Edit",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.textclr)))),
                        ),
                      ),

                    ],
                  )),
            );
          });
        });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getPhotographerType();
  //   getPhotographerList();
  //   getEventTypes();
  //   getCitiesList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgruond,
        appBar: AppBar(
          backgroundColor: Color(0xff303030),
          leading: const BackButton(
            color: Color(0xff1E90FF), // <-- SEE HERE
          ),
          actions: const [
             Center(
              child: Padding(
                padding:  EdgeInsets.only(right: 14),
                child: Text("Edit Freelancing Job",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff1E90FF),
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff3B3B3B),
                    ),
                     child: Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Auto Job ID",
                        //         style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
                        //       Container(width:180,
                        //         height: 30,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8),
                        //           color: AppColors.backgruond,
                        //         ),
                        //
                        //         child: Align(alignment: Alignment.centerLeft, child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Text("FJ001",style: TextStyle(color: AppColors.whit),),
                        //         )),)
                        //     ],
                        //   ),
                        //
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Photographer",
                              style: TextStyle(color: AppColors.pdfbtn),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 0),
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.containerclr2),
                                width: MediaQuery.of(context).size.width / 2.1,

                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: AppColors.cardclr,
                                    // Initial Value
                                    value: photographerid,
                                    isExpanded: true,
                                    hint: const Text(
                                      "Event",
                                      style:
                                          TextStyle(color: AppColors.textclr),
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.textclr,
                                    ),
                                    // Array list of items
                                    items: photographersList.map((items) {
                                      return DropdownMenuItem(
                                        value: items.id.toString(),
                                        child: Text(
                                          "${items.firstName.toString()} ${items.lastName.toString()}",
                                          style: const TextStyle(
                                              color: AppColors.textclr),
                                        ),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (newValue) {
                                      setState(() {
                                        photographerid = newValue;
                                      });
                                    },
                                  ),
                                ),
                                //  DropdownButtonHideUnderline(
                                //   child: DropdownButton(
                                //     dropdownColor: AppColors.cardclr,
                                //     // Initial Value
                                //     value: photographer,
                                //     isExpanded: true,
                                //     hint: const Text(
                                //       "Photographer",
                                //       style: TextStyle(
                                //           color: AppColors.textclr),
                                //     ),
                                //     icon: const Icon(
                                //       Icons.keyboard_arrow_down,
                                //       color: AppColors.textclr,
                                //     ),
                                //     // Array list of items
                                //     items: photographersList.map((items) {
                                //       return DropdownMenuItem(
                                //         value: items.id.toString(),
                                //         child: Text(
                                //           items.firstName.toString(),
                                //           style: const TextStyle(
                                //               color: AppColors.textclr),
                                //         ),
                                //       );
                                //     }).toList(),
                                //     // After selecting the desired option,it will
                                //     // change button value to selected value
                                //     onChanged: (newValue) {
                                //       setState(() {
                                //         photographer = newValue;
                                //       });
                                //     },
                                //   ),
                                // ),

                                // TextFormField(
                                //   style:
                                //      const TextStyle(color: AppColors.textclr),
                                //   controller: eventController,
                                //   keyboardType: TextInputType.name,
                                //   validator: (value) => value!.isEmpty
                                //       ? ' Events cannot be blank'
                                //       : null,
                                //   decoration: const InputDecoration(
                                //       hintText: 'Enter Events',
                                //       hintStyle: TextStyle(
                                //           color: AppColors.textclr,
                                //           fontSize: 14),
                                //       border: InputBorder.none,
                                //       contentPadding: EdgeInsets.only(
                                //           left: 10, bottom: 6)),
                                // ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "City/Venue",
                              style: TextStyle(color: AppColors.pdfbtn),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 0),
                              child: Container(
                                  padding: EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.containerclr2),
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  child: TextFormField(
                                    style:
                                        const TextStyle(color: AppColors.whit),
                                    controller: cityNameController,
                                    decoration: const InputDecoration(
                                        hintText: "City Name",
                                        hintStyle:
                                            TextStyle(color: AppColors.whit),
                                        border: InputBorder.none),
                                  )

                                  // TextFormField(
                                  //   style:
                                  //      const TextStyle(color: AppColors.textclr),
                                  //   controller: eventController,
                                  //   keyboardType: TextInputType.name,
                                  //   validator: (value) => value!.isEmpty
                                  //       ? ' Events cannot be blank'
                                  //       : null,
                                  //   decoration: const InputDecoration(
                                  //       hintText: 'Enter Events',
                                  //       hintStyle: TextStyle(
                                  //           color: AppColors.textclr,
                                  //           fontSize: 14),
                                  //       border: InputBorder.none,
                                  //       contentPadding: EdgeInsets.only(
                                  //           left: 10, bottom: 6)),
                                  // ),
                                  ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Event",
                              style: TextStyle(color: AppColors.pdfbtn),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 0),
                              child: Container(
                                padding: EdgeInsets.only(left: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.containerclr2),
                                width: MediaQuery.of(context).size.width / 2.1,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    dropdownColor: AppColors.cardclr,
                                    // Initial Value
                                    value: eventController,
                                    isExpanded: true,
                                    hint: const Text(
                                      "Event",
                                      style:
                                          TextStyle(color: AppColors.textclr),
                                    ),
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.textclr,
                                    ),
                                    // Array list of items
                                    items: eventList.map((items) {
                                      return DropdownMenuItem(
                                        value: items.id.toString(),
                                        child: Text(
                                          items.cName.toString(),
                                          style: const TextStyle(
                                              color: AppColors.textclr),
                                        ),
                                      );
                                    }).toList(),
                                    // After selecting the desired option,it will
                                    // change button value to selected value
                                    onChanged: (newValue) {
                                      setState(() {
                                        eventController = newValue;
                                      });
                                    },
                                  ),
                                ),

                                // TextFormField(
                                //   style:
                                //      const TextStyle(color: AppColors.textclr),
                                //   controller: eventController,
                                //   keyboardType: TextInputType.name,
                                //   validator: (value) => value!.isEmpty
                                //       ? ' Events cannot be blank'
                                //       : null,
                                //   decoration: const InputDecoration(
                                //       hintText: 'Enter Events',
                                //       hintStyle: TextStyle(
                                //           color: AppColors.textclr,
                                //           fontSize: 14),
                                //       border: InputBorder.none,
                                //       contentPadding: EdgeInsets.only(
                                //           left: 10, bottom: 6)),
                                // ),
                              ),
                            )
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("City/Venue",
                        //         style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
                        //       Container(width:180,
                        //         height: 30,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8),
                        //           color: AppColors.backgruond,
                        //         ),
                        //         child: Align(alignment: Alignment.centerLeft, child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Text("Mumbai",style: TextStyle(color: AppColors.whit),),
                        //         )),)
                        //     ],
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text("Events",
                        //         style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
                        //       Container(
                        //         width:180,
                        //         height: 35,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(8),
                        //           color: AppColors.backgruond,
                        //         ),
                        //         child: DropdownButtonHideUnderline(
                        //           child: DropdownButton(
                        //             elevation: 0,
                        //             underline: Container(),
                        //             isExpanded: true,
                        //             value: _cityValue,
                        //             icon: const Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
                        //             hint: const Align(alignment: Alignment.centerLeft,
                        //               child: Padding(
                        //                 padding:  EdgeInsets.all(8.0),
                        //                 child: Text("Mumbai", style: TextStyle(
                        //                     color:AppColors.whit
                        //                 ),),
                        //               ),
                        //             ),
                        //             items:item2.map((String items) {
                        //               return DropdownMenuItem(
                        //                   value: items,
                        //                   child: Text(items)
                        //               );
                        //             }
                        //             ).toList(),
                        //             onChanged: (String? newValue){
                        //               setState(() {
                        //                 _cityValue = newValue!;
                        //               });
                        //             },
                        //
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff8B8B8B),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                "Type Of Photography",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whit,
                                    fontSize: 14),
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            height: 35,
                            width: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffbfbfbf),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                dropdownColor: AppColors.cardclr,
                                // Initial Value
                                value: photographerType,
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
                                items: typeofPhotographyEvent.map((items) {
                                  return DropdownMenuItem(
                                    value: items.resId.toString(),
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
                                  setState(() {
                                    photographerType = newValue;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff42ACFE),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          Text(
                            "Date",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.whit),
                          ),
                          const SizedBox(width: 40,),
                          Container(
                            width: MediaQuery.of(context).size.width/2 - 30,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whit),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Text(
                              "Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whit),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 200,
                  //   child: ListView.builder(
                  //
                  //     // physics: const NeverScrollableScrollPhysics(),
                  //     itemCount: jsData.length,
                  //     itemBuilder: (context, index) {
                  //       return InkWell(
                  //         onTap: () async{
                  //           //  setState(() {
                  //           //    selectedDates = DateTime.parse(jsData[index]['date']);
                  //           //    descriptionController.text = jsData[index]['description'];
                  //           //    amountController.text = jsData[index]['amount'];
                  //           //  });
                  //           // await editUpdateInformationDialog(context);
                  //         },
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(top: 5.0),
                  //           child: Container(
                  //             height: 50,
                  //             width: MediaQuery.of(context).size.width,
                  //             decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(8),
                  //               color: const Color(0xff8B8B8B),
                  //             ),
                  //             child: Padding(
                  //               padding: const EdgeInsets.all(8.0),
                  //               child: Row(
                  //                 mainAxisAlignment:
                  //                 MainAxisAlignment.spaceBetween,
                  //                 crossAxisAlignment:
                  //                 CrossAxisAlignment.center,
                  //                 children: [
                  //                   Container(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         vertical: 5),
                  //                     decoration: const BoxDecoration(
                  //                       // color:AppColors.datecontainer,
                  //                     ),
                  //                     child: Text(
                  //                       // jsonData[index]['date'] != null
                  //                       //     ?
                  //                       ' ${jsData[index]['date']}',
                  //                       // : 'Select Date ',
                  //                       style: const TextStyle(
                  //                           color: AppColors.textclr,
                  //                           fontSize: 12),
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     width: MediaQuery.of(context).size.width/2 - 10,
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 8, vertical: 5),
                  //                     decoration: const BoxDecoration(
                  //                       // color:AppColors.datecontainer,
                  //                     ),
                  //                     child: Text(
                  //                       jsData[index]['description'] != null
                  //                           ? ' ${
                  //                           jsData[index]['description']}'
                  //                           : 'Description',
                  //                       style: const TextStyle(
                  //                           color: AppColors.textclr,
                  //                           fontSize: 12),
                  //                     ),
                  //                   ),
                  //                   Text(
                  //                     jsData[index]['amount'] != null
                  //                         ? '₹ ${jsData[index]['amount']}'
                  //                         : 'Amount',
                  //                     style: const TextStyle(
                  //                         color: AppColors.textclr,
                  //                         fontWeight: FontWeight.w600,
                  //                         fontSize: 12),
                  //                   ),
                  //                   // IconButton(onPressed: (){
                  //                   //   jsData.removeAt(index);
                  //                   //   setState(() {
                  //                   //
                  //                   //   });
                  //                   // }, icon: const
                  //                   InkWell(
                  //                       onTap: (){
                  //                         jsData.removeAt(index);
                  //                         setState(() {
                  //                         });
                  //                       },
                  //                       child: Icon(Icons.delete_forever, color: Colors.red,))
                  //                   // )
                  //
                  //                   // Text("Enter Time Optional",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
                  //                   // Text("Enter Amount",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
                  //                 ],
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  Container(
                    height: 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                        itemCount: widget.type == true
                            ? widget.allJobs!.jsonData!.length
                            : widget.upcomingJobs!.jsonData!.length,
                        itemBuilder: (context, index) {
                          if (widget.type == true) {
                            var data = widget.allJobs!.jsonData![index];
                            return InkWell(
                              onTap: () async{
                                 setState(() {
                                   selectedDates = DateFormat('dd-MM-yyyy').parse(data.date.toString());
                                   descriptionController.text = data.description.toString();
                                   amountController.text = data.amount.toString();
                                 });
                                await editUpdateInformationDialog(context, index, data);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: const Color(0xff8B8B8B),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          decoration: const BoxDecoration(
                                            // color:AppColors.datecontainer,
                                          ),
                                          child: Text(
                                            // jsonData[index]['date'] != null
                                            //     ?
                                            ' ${data.date}',
                                            // : 'Select Date ',
                                            style: const TextStyle(
                                                color: AppColors.textclr,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width/2 - 10,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          decoration: const BoxDecoration(
                                            // color:AppColors.datecontainer,
                                          ),
                                          child: Text(
                                            data.description != null
                                                ? ' ${data.description}'
                                                :
                                            'Description',
                                            style: const TextStyle(
                                                color: AppColors.textclr,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Text(
                                          data.amount != null
                                              ? '₹ ${data.amount}'
                                              : 'Amount',
                                          style: const TextStyle(
                                              color: AppColors.textclr,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12),
                                        ),
                                        // IconButton(onPressed: (){
                                        //   jsData.removeAt(index);
                                        //   setState(() {
                                        //
                                        //   });
                                        // }, icon: const
                                        InkWell(
                                            onTap: (){
                                              if(widget.type == true) {
                                                widget.allJobs!.jsonData!
                                                    .removeAt(index);
                                                // data.removeAt(index);
                                                setState(() {});
                                              }else{
                                                widget.upcomingJobs!.jsonData!
                                                    .removeAt(index);
                                                // data.removeAt(index);
                                                setState(() {});
                                              }
                                            },
                                            child: Icon(Icons.delete_forever, color: Colors.red,))
                                        // )

                                        // Text("Enter Time Optional",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
                                        // Text("Enter Amount",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          var data = widget.upcomingJobs!.jsonData![index];
                          return InkWell(
                            onTap: () async{
                              //  setState(() {
                              //    selectedDates = DateTime.parse(jsData[index]['date']);
                              //    descriptionController.text = jsData[index]['description'];
                              //    amountController.text = jsData[index]['amount'];
                              //  });
                              // await editUpdateInformationDialog(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: const Color(0xff8B8B8B),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        decoration: const BoxDecoration(
                                          // color:AppColors.datecontainer,
                                        ),
                                        child: Text(
                                          // jsonData[index]['date'] != null
                                          //     ?
                                          ' ${data.date}',
                                          // : 'Select Date ',
                                          style: const TextStyle(
                                              color: AppColors.textclr,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width/2 - 10,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 5),
                                        decoration: const BoxDecoration(
                                          // color:AppColors.datecontainer,
                                        ),
                                        child: Text(
                                          data.description != null
                                              ? ' ${data.description}'
                                              :
                                          'Description',
                                          style: const TextStyle(
                                              color: AppColors.textclr,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Text(
                                        data.amount != null
                                            ? '₹ ${data.amount}'
                                            : 'Amount',
                                        style: const TextStyle(
                                            color: AppColors.textclr,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                      // IconButton(onPressed: (){
                                      //   jsData.removeAt(index);
                                      //   setState(() {
                                      //
                                      //   });
                                      // }, icon: const
                                      InkWell(
                                          onTap: (){
                                            widget.allJobs!.jsonData!.removeAt(index);
                                            // data.removeAt(index);
                                            setState(() {
                                            });
                                          },
                                          child: Icon(Icons.delete_forever, color: Colors.red,))
                                      // )

                                      // Text("Enter Time Optional",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
                                      // Text("Enter Amount",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Total",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whit),
                              )),
                          // Container(
                          //   height: 30,
                          //   width: 230,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(8),
                          //     color: Color(0xffbfbfbf),
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(right: 8.0),
                          //     child: Align(
                          //         alignment: Alignment.centerRight,
                          //         child: Text(
                          //
                          //           widget.type == true ?
                          //           "₹ ${widget.allJobs!.jsonData![0].amount.toString()}"
                          //           :  "₹ ${widget.upcomingJobs!.jsonData![0].amount.toString()}",
                          //           style: const TextStyle(
                          //               color: Colors.black,
                          //               fontStyle: FontStyle.italic),
                          //         )),
                          //   ),
                          // )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 140,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Update'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff40ACFF),
                                ),
                              ),
                            ),
                            Image.asset(
                              "assets/images/pdf.png",
                              scale: 2.1,
                            ),
                            SizedBox(
                              width: 140,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
