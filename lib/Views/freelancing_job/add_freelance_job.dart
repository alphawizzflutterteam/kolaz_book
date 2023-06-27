// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:kolazz_book/Controller/ad_new_job_Controller.dart';
// import 'package:kolazz_book/Models/Type_of_photography_model.dart';
// import 'package:kolazz_book/Models/event_type_model.dart';
// import 'package:kolazz_book/Models/get_cities_model.dart';
// import 'package:kolazz_book/Models/photographer_list_model.dart';
// import 'package:kolazz_book/Utils/strings.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utils/colors.dart';
//
// class addNewJob extends StatefulWidget {
//   const addNewJob({Key? key}) : super(key: key);
//
//   @override
//   State<addNewJob> createState() => _freelancing_job_updateState();
// }
//
// class _freelancing_job_updateState extends State<addNewJob> {
//   String? _chosenValue;
//   var item = [
//     'Kaushik Prajapati',
//     ' Prajapati',
//     'Kaushik Prajapati',
//   ];
//   String? _cityValue;
//   var item2 = [
//     'Mumbai',
//     ' indore',
//     'delhi ',
//   ];
//   String? _photography;
//   var item3 = [
//     'Mumbai',
//     ' indore',
//     'delhi ',
//   ];
//
//   List jsonData = [];
//
//   List<Categories> typeofPhotographyEvent = [];
//   List<Data> photographersList = [];
//   List<EventType> eventList = [];
//   List<CityList> citiesList = [];
//   TextEditingController amountt = TextEditingController();
//
//   var eventController;
//   var cityController;
//   var photographerType;
//   var photographer;
//   // String? selectDates;
//   // String? selectTimes;
//   var photographeridd;
//   var totall = 0;
//   List<int> amountlist = [];
//
//   // List<DateTime> selectedDates = [DateTime.now()];
//   DateTime? selectedDates;
//   TimeOfDay selectedTime = TimeOfDay.now();
//   TimeOfDay selectedTime2 = TimeOfDay.now();
//
//   Future<void> selectDate(BuildContext context,) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null && pickedDate != selectedDates) {
//       selectedDates = pickedDate;
//       // update();
//     }
//   }
//
//   Future<void> selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//     );
//
//     if (pickedTime != null && pickedTime != selectedTime) {
//       selectedTime = pickedTime;
//       selectTime2(context);
//       // update();
//
//     }
//   }
//
//   Future<void> selectTime2(BuildContext context) async {
//     final TimeOfDay? pickedTime2 = await showTimePicker(
//       context: context,
//       initialTime: selectedTime2,
//     );
//
//     if (pickedTime2 != null && pickedTime2 != selectedTime2) {
//       selectedTime2 = pickedTime2;
//       // update();
//     }
//   }
//
//   getPhotographerType() async {
//     var uri = Uri.parse(getPhotographerApi.toString());
//     // '${Apipath.getCitiesUrl}');
//     var request = http.MultipartRequest("GET", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//
//     request.headers.addAll(headers);
//     // request.fields['type_id'] = "1";
//     // request.fields['vendor_id'] = userID;
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//
//     // collectionModal = AllCateModel.fromJson(userData);
//     typeofPhotographyEvent = TypeofPhotography.fromJson(userData).categories!;
//     // print(
//     //     "ooooo ${collectionModal!.status} and ${collectionModal!.categories!.length} and ${userID}");
//     print("this is photographer $typeofPhotographyEvent");
//   }
//
//   getPhotographerList() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userId = preferences.getString('id');
//     var uri = Uri.parse(getClientPhotographersApi.toString());
//
//     var request = http.MultipartRequest("POST", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//     request.fields.addAll({
//       'user_id': userId.toString(),
//       'type': 'photographers',
//     });
//     request.headers.addAll(headers);
//     // request.fields['user_id'] = userId.toString();
//     // request.fields['type'] = 'photographer';
//     print("this is my photographer requeswt ${request.fields.toString()}");
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//     final result = PhotographerListModel.fromJson(userData);
//     setState(() {
//       photographersList = result.data!;
//       photographeridd = photographersList[0].id;
//     });
//     print("this is photographersList ${photographersList[0].firstName}");
//   }
//
//   getEventTypes() async {
//     var uri = Uri.parse(getEventsApis.toString());
//     // '${Apipath.getCitiesUrl}');
//     var request = http.MultipartRequest("GET", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//
//     request.headers.addAll(headers);
//     // request.fields['type_id'] = "1";
//     // request.fields['vendor_id'] = userID;
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//
//     setState(() {
//       eventList = EventTypeModel.fromJson(userData).categories!;
//     });
//   }
//
//   getCitiesList() async {
//     var uri = Uri.parse(getCitiesApi.toString());
//     // '${Apipath.getCitiesUrl}');
//     var request = http.MultipartRequest("GET", uri);
//     Map<String, String> headers = {
//       "Accept": "application/json",
//     };
//
//     request.headers.addAll(headers);
//     // request.fields['type_id'] = "1";
//     // request.fields['vendor_id'] = userID;
//     var response = await request.send();
//     print(response.statusCode);
//     String responseData = await response.stream.transform(utf8.decoder).join();
//     var userData = json.decode(responseData);
//
//     setState(() {
//       citiesList = GetCitiesModel.fromJson(userData).data!;
//     });
//   }
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   final TextEditingController _textEditingController = TextEditingController();
//
//
//
//   Future<void> showAddInformationDialog(BuildContext context) async {
//     return await showDialog(
//         context: context,
//         builder: (context) {
//           bool isChecked = false;
//           return StatefulBuilder(builder: (context, dialogState) {
//             return AlertDialog(
//               backgroundColor: AppColors.back,
//               content: Form(
//                   key: _formKey,
//                   child: Column(
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       // Padding(
//                       //   padding: const EdgeInsets.only(bottom: 5.0, top: 5),
//                       //   child: Text(
//                       //     "Date",
//                       //     style: TextStyle(color: AppColors.pdfbtn),
//                       //   ),
//                       // ),
//                       InkWell(
//                         onTap: () {
//                           selectDate(
//                               context);
//                           setState(() {
//
//                           });
//                         },
//                         child: Container(
//                           width: MediaQuery.of(context).size.width /2,
//                          height: 35,
//                           padding: const EdgeInsets.only(
//                               left: 8, top: 10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: AppColors.containerclr2),
//                           child: Text(selectedDates != null
//                                 ? ' ${DateFormat('MM-dd-yyyy').format(selectedDates!)}'
//                                 : 'Select Date ',
//                             style: const TextStyle(
//                                 color: AppColors.textclr,
//                                 fontSize: 12),
//                           ),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.only(bottom: 5.0, top: 5),
//                       //   child: Text(
//                       //     "Start Time",
//                       //     style: TextStyle(color: AppColors.pdfbtn),
//                       //   ),
//                       // ),
//
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5.0, bottom: 5),
//                         child: InkWell(
//                           onTap: () {
//                             selectTime(context);
//                             dialogState((){
//                             });
//                             setState(() {
//
//                             });
//                           },
//                           child: Container(
//                             width: MediaQuery.of(context).size.width /2,
//                             height: 35,
//                             padding: const EdgeInsets.only(
//                                 left: 8, top: 10),
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: AppColors.containerclr2),
//                             child: Text(
//                               selectedTime != null
//                                   ? ' ${selectedTime.format(context)}'
//                                   : 'Start Time For Bookings',
//                               style: const TextStyle(
//                                   color: AppColors.textclr,
//                                   fontSize: 12),
//                             ),
//                           ),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.only(bottom: 5.0, top: 5),
//                       //   child: Text(
//                       //     "End Time",
//                       //     style: TextStyle(color: AppColors.pdfbtn),
//                       //   ),
//                       // ),
//                       InkWell(
//                         onTap: () {
//                           selectTime2(context);
//                           dialogState((){
//                           });
//                           setState(() {
//
//                           });
//                         },
//                         child: Container(
//                           width: MediaQuery.of(context).size.width /2,
//                           height: 35,
//                           padding: const EdgeInsets.only(
//                               left: 8, top: 10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: AppColors.containerclr2),
//                           child: Text(
//                             selectedTime2 != null
//                                 ? ' ${selectedTime2.format(context)}'
//                                 : 'End Time For Bookings',
//                             style: const TextStyle(
//                                 color: AppColors.textclr,
//                                 fontSize: 12),
//                           ),
//                         ),
//                       ),
//                       // Padding(
//                       //   padding: const EdgeInsets.only(bottom: 5.0, top: 5),
//                       //   child: Text(
//                       //     "Amount",
//                       //     style: TextStyle(color: AppColors.pdfbtn),
//                       //   ),
//                       // ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 5.0, bottom: 15),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width /2,
//                           height: 35,
//                           padding: const EdgeInsets.only(
//                               left: 8, top: 10),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: AppColors.containerclr2),
//                           child: TextFormField(
//                             style: const TextStyle(
//                                 color: AppColors.textclr),
//                             // controller: controller.outputController,
//                             keyboardType: TextInputType.number,
//                             controller: amountt,
//                             validator: (value) => value!.isEmpty
//                                 ? 'Amount cannot be blank'
//                                 : null,
//                             decoration: const InputDecoration(
//                                 hintText: 'Enter Amount',
//                                 hintStyle: TextStyle(
//                                     color: AppColors.textclr,
//                                     fontSize: 14),
//                                 border: InputBorder.none,
//                                 // contentPadding: EdgeInsets.only(
//                                 //     left: 8)
//                             ),
//                           ),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: InkWell(
//                           onTap: () {
//                             jsonData.add({
//                               "date": selectedDates, "from_time": selectedTime, "to_time": selectedTime2, "amount": amountt.text.toString()
//                             });
//                             setState(() {
//
//                             });
//                             print("this is my new json data $jsonData");
//                             Navigator.pop(context);
//                             // addFreelancer();
//                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
//                           },
//                           child: Container(
//                               height: 40,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color: AppColors.pdfbtn),
//                               width: MediaQuery.of(context).size.width / 2,
//                               child: const Center(
//                                   child: Text("Add",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: AppColors.textclr)))),
//                         ),
//                       ),
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //   children: [
//                       //     Text("Choice Box"),
//                       //     Checkbox(
//                       //         value: isChecked,
//                       //         onChanged: (checked) {
//                       //           setState(() {
//                       //             isChecked = checked;
//                       //           });
//                       //         })
//                       //   ],
//                       // ) ̰ e
//                     ],
//                   )),
//               // title: Text(''),
//               // actions: <Widget>[
//               //   InkWell(
//               //     child: Text('ADD'),
//               //     onTap: () {
//               //       if (_formKey.currentState!.validate()) {
//               //         // Do something like updating SharedPreferences or User Settings etc.
//               //         Navigator.of(context).pop();
//               //       }
//               //     },
//               //   ),
//               // ],
//             );
//           });
//         });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getPhotographerType();
//     getPhotographerList();
//     getEventTypes();
//     getCitiesList();
//   }
//
//   addFreelancer() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userId = preferences.getString('id');
//     var headers = {
//       'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
//     };
//     var request =
//         http.MultipartRequest('POST', Uri.parse(addFreelancerApi.toString()));
//     request.fields.addAll({
//       'client_name': photographer.toString(),
//       //clientNameController.text.toString(),
//       'city': cityController.toString(),
//       'type_event': eventController.toString(),
//       'amount[]': amountt.text.toString(),
//       // 'date[]': selectDates.toString(),
//       // 'time[]': selectTimes.toString(),
//       'total': totall.toString(),
//       'type': photographerType.toString(),
//       'user_id': userId.toString(),
//       'photographer_id': photographeridd.toString(),
//     });
//     print("this is add quotation request ${request.fields.toString()}");
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       String responseData =
//           await response.stream.transform(utf8.decoder).join();
//       var userData = json.decode(responseData);
//
//       Navigator.pop(context);
//       Fluttertoast.showToast(msg: userData['message']);
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: AddJobController(),
//       builder: (controller) {
//         return Scaffold(
//             backgroundColor: AppColors.backgruond,
//             appBar: AppBar(
//               backgroundColor: Color(0xff303030),
//               leading: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
//               actions: const [
//                 Center(
//                   child: Padding(
//                     padding: EdgeInsets.only(right: 14),
//                     child: Text("Add Freelancing Job",
//                         style: TextStyle(
//                             fontSize: 14,
//                             color: Color(0xff1E90FF),
//                             fontWeight: FontWeight.bold)),
//                   ),
//                 ),
//               ],
//             ),
//             body: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: controller.formKey,
//                   child: Column(
//                     children: [
//                       Container(
//                         padding: EdgeInsets.only(left: 10, right: 10),
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Color(0xff3B3B3B),
//                         ),
//                         child: Column(
//                           children: [
//                             // Padding(
//                             //   padding: const EdgeInsets.all(8.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //     children: [
//                             //       Text("Auto Job ID",
//                             //         style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
//                             //       Container(width:180,
//                             //         height: 30,
//                             //         decoration: BoxDecoration(
//                             //           borderRadius: BorderRadius.circular(8),
//                             //           color: AppColors.backgruond,
//                             //         ),
//                             //
//                             //         child: Align(alignment: Alignment.centerLeft, child: Padding(
//                             //           padding: const EdgeInsets.all(8.0),
//                             //           child: Text("FJ001",style: TextStyle(color: AppColors.whit),),
//                             //         )),)
//                             //     ],
//                             //   ),
//                             //
//                             // ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "Photographer",
//                                   style: TextStyle(color: AppColors.pdfbtn),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 8.0, horizontal: 0),
//                                   child: Container(
//                                     padding: EdgeInsets.only(left: 8),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: AppColors.containerclr2),
//                                     width:
//                                         MediaQuery.of(context).size.width / 2.1,
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton(
//                                         dropdownColor: AppColors.cardclr,
//                                         // Initial Value
//                                         value: photographer,
//                                         isExpanded: true,
//                                         hint: const Text(
//                                           "Photographer",
//                                           style: TextStyle(
//                                               color: AppColors.textclr),
//                                         ),
//                                         icon: const Icon(
//                                           Icons.keyboard_arrow_down,
//                                           color: AppColors.textclr,
//                                         ),
//                                         // Array list of items
//                                         items: photographersList.map((items) {
//                                           return DropdownMenuItem(
//                                             value: items.firstName.toString(),
//                                             child: Text(
//                                               items.firstName.toString(),
//                                               style: const TextStyle(
//                                                   color: AppColors.textclr),
//                                             ),
//                                           );
//                                         }).toList(),
//                                         // After selecting the desired option,it will
//                                         // change button value to selected value
//                                         onChanged: (newValue) {
//                                           setState(() {
//                                             photographer = newValue;
//                                           });
//                                         },
//                                       ),
//                                     ),
//
//                                     // TextFormField(
//                                     //   style:
//                                     //      const TextStyle(color: AppColors.textclr),
//                                     //   controller: eventController,
//                                     //   keyboardType: TextInputType.name,
//                                     //   validator: (value) => value!.isEmpty
//                                     //       ? ' Events cannot be blank'
//                                     //       : null,
//                                     //   decoration: const InputDecoration(
//                                     //       hintText: 'Enter Events',
//                                     //       hintStyle: TextStyle(
//                                     //           color: AppColors.textclr,
//                                     //           fontSize: 14),
//                                     //       border: InputBorder.none,
//                                     //       contentPadding: EdgeInsets.only(
//                                     //           left: 10, bottom: 6)),
//                                     // ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "City/Venue",
//                                   style: TextStyle(color: AppColors.pdfbtn),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 8.0, horizontal: 0),
//                                   child: Container(
//                                     padding: EdgeInsets.only(left: 8),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: AppColors.containerclr2),
//                                     width:
//                                         MediaQuery.of(context).size.width / 2.1,
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton(
//                                         dropdownColor: AppColors.cardclr,
//                                         // Initial Value
//                                         value: cityController,
//                                         isExpanded: true,
//                                         hint: const Text(
//                                           "City",
//                                           style: TextStyle(
//                                               color: AppColors.textclr),
//                                         ),
//                                         icon: const Icon(
//                                           Icons.keyboard_arrow_down,
//                                           color: AppColors.textclr,
//                                         ),
//                                         // Array list of items
//                                         items: citiesList.map((items) {
//                                           return DropdownMenuItem(
//                                             value: items.name.toString(),
//                                             child: Text(
//                                               items.name.toString(),
//                                               style: const TextStyle(
//                                                   color: AppColors.textclr),
//                                             ),
//                                           );
//                                         }).toList(),
//                                         // After selecting the desired option,it will
//                                         // change button value to selected value
//                                         onChanged: (newValue) {
//                                           setState(() {
//                                             cityController = newValue;
//                                           });
//                                         },
//                                       ),
//                                     ),
//
//                                     // TextFormField(
//                                     //   style:
//                                     //      const TextStyle(color: AppColors.textclr),
//                                     //   controller: eventController,
//                                     //   keyboardType: TextInputType.name,
//                                     //   validator: (value) => value!.isEmpty
//                                     //       ? ' Events cannot be blank'
//                                     //       : null,
//                                     //   decoration: const InputDecoration(
//                                     //       hintText: 'Enter Events',
//                                     //       hintStyle: TextStyle(
//                                     //           color: AppColors.textclr,
//                                     //           fontSize: 14),
//                                     //       border: InputBorder.none,
//                                     //       contentPadding: EdgeInsets.only(
//                                     //           left: 10, bottom: 6)),
//                                     // ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 const Text(
//                                   "Event",
//                                   style: TextStyle(color: AppColors.pdfbtn),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 8.0, horizontal: 0),
//                                   child: Container(
//                                     padding: EdgeInsets.only(left: 8),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(10),
//                                         color: AppColors.containerclr2),
//                                     width:
//                                         MediaQuery.of(context).size.width / 2.1,
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton(
//                                         dropdownColor: AppColors.cardclr,
//                                         // Initial Value
//                                         value: eventController,
//                                         isExpanded: true,
//                                         hint: const Text(
//                                           "Event",
//                                           style: TextStyle(
//                                               color: AppColors.textclr),
//                                         ),
//                                         icon: const Icon(
//                                           Icons.keyboard_arrow_down,
//                                           color: AppColors.textclr,
//                                         ),
//                                         // Array list of items
//                                         items: eventList.map((items) {
//                                           return DropdownMenuItem(
//                                             value: items.cName.toString(),
//                                             child: Text(
//                                               items.cName.toString(),
//                                               style: const TextStyle(
//                                                   color: AppColors.textclr),
//                                             ),
//                                           );
//                                         }).toList(),
//                                         // After selecting the desired option,it will
//                                         // change button value to selected value
//                                         onChanged: (newValue) {
//                                           setState(() {
//                                             eventController = newValue;
//                                           });
//                                         },
//                                       ),
//                                     ),
//
//                                     // TextFormField(
//                                     //   style:
//                                     //      const TextStyle(color: AppColors.textclr),
//                                     //   controller: eventController,
//                                     //   keyboardType: TextInputType.name,
//                                     //   validator: (value) => value!.isEmpty
//                                     //       ? ' Events cannot be blank'
//                                     //       : null,
//                                     //   decoration: const InputDecoration(
//                                     //       hintText: 'Enter Events',
//                                     //       hintStyle: TextStyle(
//                                     //           color: AppColors.textclr,
//                                     //           fontSize: 14),
//                                     //       border: InputBorder.none,
//                                     //       contentPadding: EdgeInsets.only(
//                                     //           left: 10, bottom: 6)),
//                                     // ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(8.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //     children: [
//                             //       Text("City/Venue",
//                             //         style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
//                             //       Container(width:180,
//                             //         height: 30,
//                             //         decoration: BoxDecoration(
//                             //           borderRadius: BorderRadius.circular(8),
//                             //           color: AppColors.backgruond,
//                             //         ),
//                             //         child: Align(alignment: Alignment.centerLeft, child: Padding(
//                             //           padding: const EdgeInsets.all(8.0),
//                             //           child: Text("Mumbai",style: TextStyle(color: AppColors.whit),),
//                             //         )),)
//                             //     ],
//                             //   ),
//                             // ),
//                             // Padding(
//                             //   padding: const EdgeInsets.all(8.0),
//                             //   child: Row(
//                             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             //     children: [
//                             //       Text("Events",
//                             //         style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
//                             //       Container(
//                             //         width:180,
//                             //         height: 35,
//                             //         decoration: BoxDecoration(
//                             //           borderRadius: BorderRadius.circular(8),
//                             //           color: AppColors.backgruond,
//                             //         ),
//                             //         child: DropdownButtonHideUnderline(
//                             //           child: DropdownButton(
//                             //             elevation: 0,
//                             //             underline: Container(),
//                             //             isExpanded: true,
//                             //             value: _cityValue,
//                             //             icon: const Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
//                             //             hint: const Align(alignment: Alignment.centerLeft,
//                             //               child: Padding(
//                             //                 padding:  EdgeInsets.all(8.0),
//                             //                 child: Text("Mumbai", style: TextStyle(
//                             //                     color:AppColors.whit
//                             //                 ),),
//                             //               ),
//                             //             ),
//                             //             items:item2.map((String items) {
//                             //               return DropdownMenuItem(
//                             //                   value: items,
//                             //                   child: Text(items)
//                             //               );
//                             //             }
//                             //             ).toList(),
//                             //             onChanged: (String? newValue){
//                             //               setState(() {
//                             //                 _cityValue = newValue!;
//                             //               });
//                             //             },
//                             //
//                             //           ),
//                             //         ),
//                             //       ),
//                             //     ],
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 12,
//                       ),
//                       Container(
//                         height: 90,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: Color(0xff8B8B8B),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(14.0),
//                           child: Column(
//                             children: [
//                               Align(
//                                   alignment: Alignment.topCenter,
//                                   child: Text(
//                                     "Type Of Photography",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: AppColors.whit,
//                                         fontSize: 14),
//                                   )),
//                               const SizedBox(
//                                 height: 8,
//                               ),
//                               Container(
//                                 padding: const EdgeInsets.only(left: 8),
//                                 height: 35,
//                                 width: 220,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   color: Color(0xffbfbfbf),
//                                 ),
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton(
//                                     dropdownColor: AppColors.cardclr,
//                                     // Initial Value
//                                     value: photographerType,
//                                     isExpanded: true,
//                                     hint: const Text(
//                                       "Type Of Photography",
//                                       style:
//                                           TextStyle(color: AppColors.textclr),
//                                     ),
//                                     icon: const Icon(
//                                       Icons.keyboard_arrow_down,
//                                       color: AppColors.textclr,
//                                     ),
//                                     // Array list of items
//                                     items: typeofPhotographyEvent.map((items) {
//                                       return DropdownMenuItem(
//                                         value: items.resName.toString(),
//                                         child: Text(
//                                           items.resName.toString(),
//                                           style: const TextStyle(
//                                               color: AppColors.textclr),
//                                         ),
//                                       );
//                                     }).toList(),
//                                     // After selecting the desired option,it will
//                                     // change button value to selected value
//                                     onChanged: (newValue) {
//                                       setState(() {
//                                         photographerType = newValue;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 12,
//                       ),
//                       Container(
//                         height: 45,
//                         width: MediaQuery.of(context).size.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Color(0xff42ACFE),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Date",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.whit),
//                               ),
//                               Text(
//                                 "Time",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.whit),
//                               ),
//                               Text(
//                                 "Amount",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: AppColors.whit),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 200,
//                         child: Expanded(
//                           child: ListView.builder(
//                             // physics: const NeverScrollableScrollPhysics(),
//                             itemCount: jsonData.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 5.0),
//                                 child: Container(
//                                   height: 45,
//                                   width: MediaQuery.of(context).size.width,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     color: const Color(0xff8B8B8B),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             // controller.selectDate(
//                                             //     context, index);
//                                             // selectDates = controller
//                                             //     .selectedDates
//                                             //     .join(',');
//                                             // print(
//                                             //     'this is selected dates $selectDates');
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 8, vertical: 5),
//                                             decoration: const BoxDecoration(
//                                                 // color:AppColors.datecontainer,
//                                                 ),
//                                             child: Text(
//                                               // jsonData[index]['date'] != null
//                                               //     ?
//                                               ' ${DateFormat('MM-dd-yyyy').format(jsonData[index]['date'])}',
//                                                   // : 'Select Date ',
//                                               style: const TextStyle(
//                                                   color: AppColors.textclr,
//                                                   fontSize: 12),
//                                             ),
//                                           ),
//                                         ),
//                                         // Text("(MM-DD-YYYY)",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
//                                         InkWell(
//                                           onTap: () {
//                                             // controller.selectTime(context);
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 8, vertical: 5),
//                                             decoration: const BoxDecoration(
//                                                 // color:AppColors.datecontainer,
//                                                 ),
//                                             child: Text(
//                                               jsonData[index]['from_time'] != null
//                                                   ? ' ${
//                                                   jsonData[index]['from_time'].format(context)} to ${jsonData[index]['to_time'].format(context)}'
//                                                   : 'Select Time For Bookings',
//                                               style: const TextStyle(
//                                                   color: AppColors.textclr,
//                                                   fontSize: 12),
//                                             ),
//                                           ),
//                                         ),
//                                         Text(
//                                           jsonData[index]['amount'] != null
//                                               ? ' ${jsonData[index]['amount']}'
//                                               : 'Select Time For Bookings',
//                                           style: const TextStyle(
//                                               color: AppColors.textclr,
//                                               fontSize: 12),
//                                         ),
//
//                                         // Text("Enter Time Optional",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
//                                         // Text("Enter Amount",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () {
//                           if (controller.formKey.currentState!.validate() &&
//                               controller.selectedDates.isNotEmpty) {
//                             controller.increment();
//                           }
//                         },
//                         child: Container(
//                           height: 45,
//                           width: MediaQuery.of(context).size.width,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(8),
//                             color: const Color(0xff8B8B8B),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: InkWell(
//                               onTap: () async {
//                                await showAddInformationDialog(context);
//                                 // if (controller.formKey.currentState!
//                                 //     .validate()) {
//                                 //   controller.increment();
//                                 //
//                                 //   var a = int.parse(amountt.text);
//                                 //   totall = (totall + a);
//                                 //
//                                 //   //amountt.clear();
//                                 //   a = 0;
//                                 // }
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: const [
//                                   Icon(
//                                     Icons.add_circle_outline,
//                                     color: Color(0xff42ACFE),
//                                     size: 30,
//                                   ),
//                                   Text(
//                                     "Add More",
//                                     style: TextStyle(
//                                         color: Color(0xff42ACFE),
//                                         fontWeight: FontWeight.bold),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 18,
//                       ),
//                       Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Text(
//                                     "Total",
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: AppColors.whit),
//                                   )),
//                               Container(
//                                 height: 30,
//                                 width: 230,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(8),
//                                   color: Color(0xffbfbfbf),
//                                 ),
//                                 child: Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Text(
//                                       "${totall}   =Sum(Amount)",
//                                       style: TextStyle(
//                                           color: AppColors.whit,
//                                           fontStyle: FontStyle.italic),
//                                     )),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: InkWell(
//                           onTap: () {
//                             addFreelancer();
//                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
//                           },
//                           child: Container(
//                               height: 55,
//                               decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(50),
//                                   color: AppColors.pdfbtn),
//                               width: MediaQuery.of(context).size.width / 1.5,
//                               child: Center(
//                                   child: Text("Add",
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           color: AppColors.textclr)))),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ));
//       },
//     );
//   }
// }
import 'dart:convert';

import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kolazz_book/Controller/ad_new_job_Controller.dart';
import 'package:kolazz_book/Models/Type_of_photography_model.dart';
import 'package:kolazz_book/Models/event_type_model.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Models/photographer_list_model.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/colors.dart';

class AddFreelanceJob extends StatefulWidget {
  const AddFreelanceJob({Key? key}) : super(key: key);

  @override
  State<AddFreelanceJob> createState() => AddFreelanceJobState();
}

class AddFreelanceJobState extends State<AddFreelanceJob> {

  List jsonData = [];
  List jsData = [];

  List<Categories> typeofPhotographyEvent = [];
  List<Data> photographersList = [];
  List<EventType> eventList = [];
  List<CityList> citiesList = [];
  TextEditingController amountController = TextEditingController();
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
  double totalAmount   = 0.0;
  List<int> amountlist = [];

  // List<DateTime> selectedDates = [DateTime.now()];
  DateTime? selectedDates;
  TimeOfDay? selectedTime;
  TimeOfDay? selectedTime2 ;
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

  final TextEditingController _textEditingController = TextEditingController();



  Future<void> showAddInformationDialog(BuildContext context) async {
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
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 5.0, top: 5),
                      //   child: Text(
                      //     "Date",
                      //     style: TextStyle(color: AppColors.pdfbtn),
                      //   ),
                      // ),
                      InkWell(
                        onTap: () async {

                       await selectDate(context,setState);
                          // final DateTime? pickedDate = await showDatePicker(
                          //   context: context,
                          //   initialDate: DateTime.now(),
                          //   firstDate: DateTime(2000),
                          //   lastDate: DateTime(2100),
                          // );
                          // setState(() {
                          //
                          // });
                          // if (pickedDate != null && pickedDate != selectedDates) {
                          //   setState(() {
                          //     selectedDates = pickedDate;
                          //   });
                          //   // update();
                          // }
                         // await  selectDate(
                         //      context);
                         //  setState(() {
                         //
                         //  });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width /2,
                          height: 40,
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
                          height: 40,
                          padding: const EdgeInsets.only(
                              left: 8, top: 6),
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
                            jsonData.add(jsonEncode({
                              "date": DateFormat('dd-MM-yyyy').format(selectedDates!).toString(), "description": descriptionController.text.toString(), "amount": amountController.text.toString()
                            }));
                            jsData.add({
                              "date": DateFormat('dd-MM-yyyy').format(selectedDates!).toString(), "description": descriptionController.text.toString(), "amount": amountController.text.toString()
                            });
                            setState(() {
                              totalAmount += double.parse(amountController.text.toString());
                            });
                            print("this is my new json data $jsonData");
                            Navigator.pop(context);
                            // addFreelancer();
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                          },
                          child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.pdfbtn),
                              width: MediaQuery.of(context).size.width / 2,
                              child: const Center(
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.textclr)))),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Choice Box"),
                      //     Checkbox(
                      //         value: isChecked,
                      //         onChanged: (checked) {
                      //           setState(() {
                      //             isChecked = checked;
                      //           });
                      //         })
                      //   ],
                      // ) ̰ e
                    ],
                  )),
              // title: Text(''),
              // actions: <Widget>[
              //   InkWell(
              //     child: Text('ADD'),
              //     onTap: () {
              //       if (_formKey.currentState!.validate()) {
              //         // Do something like updating SharedPreferences or User Settings etc.
              //         Navigator.of(context).pop();
              //       }
              //     },
              //   ),
              // ],
            );
          });
        });
  }

  // Future<void> editUpdateInformationDialog(BuildContext context) async {
  //   return await showDialog(
  //       context: context,
  //       builder: (context) {
  //         bool isChecked = false;
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //             backgroundColor: AppColors.back,
  //             content: Form(
  //                 key: _formKey,
  //                 child: Column(
  //                   // crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     // Padding(
  //                     //   padding: const EdgeInsets.only(bottom: 5.0, top: 5),
  //                     //   child: Text(
  //                     //     "Date",
  //                     //     style: TextStyle(color: AppColors.pdfbtn),
  //                     //   ),
  //                     // ),
  //                     InkWell(
  //                       onTap: () async {
  //
  //                         await selectDate(context,setState);
  //                         // final DateTime? pickedDate = await showDatePicker(
  //                         //   context: context,
  //                         //   initialDate: DateTime.now(),
  //                         //   firstDate: DateTime(2000),
  //                         //   lastDate: DateTime(2100),
  //                         // );
  //                         // setState(() {
  //                         //
  //                         // });
  //                         // if (pickedDate != null && pickedDate != selectedDates) {
  //                         //   setState(() {
  //                         //     selectedDates = pickedDate;
  //                         //   });
  //                         //   // update();
  //                         // }
  //                         // await  selectDate(
  //                         //      context);
  //                         //  setState(() {
  //                         //
  //                         //  });
  //                       },
  //                       child: Container(
  //                         width: MediaQuery.of(context).size.width /2,
  //                         height: 40,
  //                         padding: const EdgeInsets.only(
  //                             left: 8, top: 10),
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             color: AppColors.containerclr2),
  //                         child: Text(selectedDates != null
  //                             ? ' ${DateFormat('MM-dd-yyyy').format(selectedDates!)}'
  //                             : 'Select Date ',
  //                           style: const TextStyle(
  //                               color: AppColors.textclr,
  //                               fontSize: 12),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 15.0, bottom: 15),
  //                       child: Container(
  //                         width: MediaQuery.of(context).size.width /2,
  //                         height: 40,
  //                         padding: const EdgeInsets.only(
  //                             left: 8, top: 6),
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             color: AppColors.containerclr2),
  //                         child: TextFormField(
  //                           style: const TextStyle(
  //                               color: AppColors.textclr),
  //                           // controller: controller.outputController,
  //                           keyboardType: TextInputType.number,
  //                           controller: amountController,
  //                           validator: (value) => value!.isEmpty
  //                               ? 'Amount cannot be blank'
  //                               : null,
  //                           decoration: const InputDecoration(
  //                             // contentPadding: EdgeInsets.only(bottom: 5),
  //                             hintText: 'Enter Amount',
  //                             hintStyle: TextStyle(
  //                                 color: AppColors.textclr,
  //                                 fontSize: 14),
  //                             border: InputBorder.none,
  //                             // contentPadding: EdgeInsets.only(
  //                             //     left: 8)
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(top: 5.0, bottom: 15),
  //                       child: Container(
  //                         width: MediaQuery.of(context).size.width /2,
  //                         height: 60,
  //                         padding: const EdgeInsets.only(
  //                             left: 8, top: 5),
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(10),
  //                             color: AppColors.containerclr2),
  //                         child: TextFormField(
  //                           style: const TextStyle(
  //                               color: AppColors.textclr),
  //                           // controller: controller.outputController,
  //                           keyboardType: TextInputType.text,
  //                           maxLines: 4,
  //                           controller: descriptionController,
  //                           validator: (value) => value!.isEmpty
  //                               ? 'Description cannot be blank'
  //                               : null,
  //                           decoration: const InputDecoration(
  //                             hintText: 'Enter Description',
  //                             hintStyle: TextStyle(
  //                                 color: AppColors.textclr,
  //                                 fontSize: 14),
  //                             border: InputBorder.none,
  //                             // contentPadding: EdgeInsets.only(
  //                             //     left: 8)
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //
  //                     Align(
  //                       alignment: Alignment.center,
  //                       child: InkWell(
  //                         onTap: () {
  //                           jsonData.add(jsonEncode({
  //                             "date": DateFormat('dd-MM-yyyy').format(selectedDates!).toString(), "description": descriptionController.text.toString(), "amount": amountController.text.toString()
  //                           }));
  //                           jsData.add({
  //                             "date": DateFormat('yyyy-MM-dd').format(selectedDates!).toString(), "description": descriptionController.text.toString(), "amount": amountController.text.toString()
  //                           });
  //                           setState(() {
  //                             totalAmount += double.parse(amountController.text.toString());
  //                           });
  //                           print("this is my new json data $jsonData");
  //                           Navigator.pop(context);
  //                           // addFreelancer();
  //                           // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
  //                         },
  //                         child: Container(
  //                             height: 40,
  //                             decoration: BoxDecoration(
  //                                 borderRadius: BorderRadius.circular(50),
  //                                 color: AppColors.pdfbtn),
  //                             width: MediaQuery.of(context).size.width / 2,
  //                             child: const Center(
  //                                 child: Text("Add",
  //                                     style: TextStyle(
  //                                         fontSize: 18,
  //                                         color: AppColors.textclr)))),
  //                       ),
  //                     ),
  //                     // Row(
  //                     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     //   children: [
  //                     //     Text("Choice Box"),
  //                     //     Checkbox(
  //                     //         value: isChecked,
  //                     //         onChanged: (checked) {
  //                     //           setState(() {
  //                     //             isChecked = checked;
  //                     //           });
  //                     //         })
  //                     //   ],
  //                     // ) ̰ e
  //                   ],
  //                 )),
  //             // title: Text(''),
  //             // actions: <Widget>[
  //             //   InkWell(
  //             //     child: Text('ADD'),
  //             //     onTap: () {
  //             //       if (_formKey.currentState!.validate()) {
  //             //         // Do something like updating SharedPreferences or User Settings etc.
  //             //         Navigator.of(context).pop();
  //             //       }
  //             //     },
  //             //   ),
  //             // ],
  //           );
  //         });
  //       });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPhotographerType();
    getPhotographerList();
    getEventTypes();
    getCitiesList();
  }

  addFreelancerJob() async {
    print("working1");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
    };
    var request =
    http.MultipartRequest('POST', Uri.parse(addFreelancerJobApi.toString()));
    request.fields.addAll({
      'json_data': jsonData.toString(),
      // 'client_name': photographer.toString(),
      'city_name': cityNameController.text.toString(),
      //clientNameController.text.toString(),
      // 'city': cityController.toString(),
      'event_id': eventController.toString(),
      // 'amount[]': amountt.text.toString(),
      // 'date[]': selectDates.toString(),
      // 'time[]': selectTimes.toString(),
      // 'total': totall.toString(),
      'type_of_photography': photographerType.toString(),
      'user_id': userId.toString(),
      'photographer_id': photographerid.toString(),
    });
    print("this is add freelancer job request ${request.fields.toString()} and $addFreelancerJobApi");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseData =
      await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);

      Navigator.pop(context, true);
      Fluttertoast.showToast(msg: userData['message']);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddJobController(),
      builder: (controller) {
        return Scaffold(
            backgroundColor: AppColors.backgruond,
            appBar: AppBar(
              backgroundColor: Color(0xff303030),
              leading: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
              actions: const [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 14),
                    child: Text("Add Freelancing Job",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff1E90FF),
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
              child: SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
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
                                    // padding: EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.containerclr2),
                                    width:
                                    MediaQuery.of(context).size.width / 2.1,

                                    child:  CustomSearchableDropDown(
                                      dropdownHintText: "Photographer",
                                      suffixIcon: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: AppColors.whit,
                                      ),
                                      backgroundColor: AppColors.containerclr2,
                                      dropdownBackgroundColor:
                                      AppColors.containerclr2,
                                      dropdownItemStyle: const TextStyle(
                                          color: AppColors.whit),
                                      // dropdownHintText: TextStyle(
                                      //   color: AppColors.whit
                                      // ),
                                      items: photographersList,
                                      label: 'Photographer',
                                      labelStyle: const TextStyle(
                                          color: AppColors.whit
                                      ),
                                      multiSelectTag: 'Names',
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
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.all(2.0),
                                      //   child: Container(
                                      //       height: 30,
                                      //       width: 30,
                                      //       child: Image.asset(
                                      //         "assets/drawerImages/designation.png", scale: 1.5,)
                                      //   ),
                                      // ),
                                      dropDownMenuItems: photographersList.map((item) {
                                        return "${item.firstName} ${item.lastName}";
                                      }).toList() ??
                                          [],
                                      onChanged: (value) {
                                        if (value != null) {
                                         setState(() {
                                           photographerName = "${value.firstName} ${value.lastName}";
                                           photographerid = value.id;
                                           cityNameController.text = value.city;
                                         });
                                       print("this is my photogrpher data $photographerName and $photographerid");
                                        }
                                      },
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
                                      child:TextFormField(
                                        style: const TextStyle(
                                            color: AppColors.whit
                                        ),
                                        controller: cityNameController,
                                        decoration: const InputDecoration(
                                            hintText: "City Name",

                                            hintStyle: TextStyle(
                                                color: AppColors.whit
                                            ),
                                            border: InputBorder.none
                                        ),
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
                                    width:
                                    MediaQuery.of(context).size.width / 2.1,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        dropdownColor: AppColors.cardclr,
                                        // Initial Value
                                        value: eventController,
                                        isExpanded: true,
                                        hint: const Text(
                                          "Event",
                                          style: TextStyle(
                                              color: AppColors.textclr),
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
                                      style:
                                      TextStyle(color: AppColors.textclr),
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
                     const SizedBox(
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
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          // physics: const NeverScrollableScrollPhysics(),
                          itemCount: jsData.length,
                          itemBuilder: (context, index) {
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
                                padding: const EdgeInsets.only(top: 5.0),
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
                                            ' ${jsData[index]['date']}',
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
                                            jsData[index]['description'] != null
                                                ? ' ${
                                                jsData[index]['description']}'
                                                : 'Description',
                                            style: const TextStyle(
                                                color: AppColors.textclr,
                                                fontSize: 12),
                                          ),
                                        ),
                                        Text(
                                          jsData[index]['amount'] != null
                                              ? '₹ ${jsData[index]['amount']}'
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
                                            jsData.removeAt(index);
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
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (controller.formKey.currentState!.validate() &&
                              controller.selectedDates.isNotEmpty) {
                            controller.increment();
                          }
                        },
                        child: Container(
                          height: 45,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff8B8B8B),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                selectedDates = null;
                                selectedTime = null ;
                                selectedTime2 = null;
                                amountController.clear();
                                descriptionController.clear();

                                await showAddInformationDialog(context);

                                // if (controller.formKey.currentState!
                                //     .validate()) {
                                //   controller.increment();
                                //
                                //   var a = int.parse(amountt.text);
                                //   totall = (totall + a);
                                //
                                //   //amountt.clear();
                                //   a = 0;
                                // }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.add_circle_outline,
                                    color: Color(0xff42ACFE),
                                    size: 30,
                                  ),
                                  Text(
                                    "Add More",
                                    style: TextStyle(
                                        color: Color(0xff42ACFE),
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
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
                              Container(
                                padding: EdgeInsets.only(right: 8),
                                height: 30,
                                width: 230,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffbfbfbf),
                                ),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child:  Text(
                                      "₹ ${totalAmount.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    )),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            print("working");
                            if(totalAmount != 0 ) {
                              if(eventController != null && photographerType != null) {
                                addFreelancerJob();
                              }else{
                                Fluttertoast.showToast(msg: "Please fill all the details first");
                              }
                            }else{
                              Fluttertoast.showToast(msg: "Please fill all the details first");
                            }
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
                          },
                          child: Container(
                              height: 55,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.pdfbtn),
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Center(
                                  child: Text("Add",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.textclr)))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
