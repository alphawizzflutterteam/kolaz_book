import 'dart:convert';
import 'package:custom_searchable_dropdown/custom_searchable_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kolazz_book/Models/add_quatation_model.dart';
import 'package:kolazz_book/Models/client_model.dart';
import 'package:kolazz_book/Models/event_type_model.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/addQuatation_controller.dart';
import '../../Controller/contact_screen_controller.dart';
import '../../Models/Type_of_photography_model.dart';
import '../../Utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_button2/dropdown_button2.dart';

class AddQuotation extends StatefulWidget {
  const AddQuotation({Key? key}) : super(key: key);

  @override
  State<AddQuotation> createState() => _AddQuotationState();
}

class _AddQuotationState extends State<AddQuotation> {
  List<Widget> customWidgets = [];
  int cardCount = 0;
  int value1 = 0;
  List<String> selectedvlaue = [];

  List<List<String>> stringList = [];
  List<Categories> typeofPhotographyEvent = [];
  List<EventType> eventList = [];
  List<CityList> citiesList = [];

  String photographer = "photographer";

  // Future<TypeofPhotography> getEventstypeApi(Map<String, String> body) async {
  //   if (await connectivity.checkConnectivity() == ConnectivityResult.wifi ||
  //       await connectivity.checkConnectivity() == ConnectivityResult.mobile) {
  //     String res =
  //     await _apiClient.postMethod(method: _apiMethods.getRventstype, body: body);
  //     if (res.isNotEmpty) {
  //       try {
  //         return typeofPhotographyFromJson(res);
  //
  //       } catch (e) {
  //         if (kDebugMode) {
  //           print(e);
  //           print('____fdgfd______${e}___________');
  //         }
  //         return TypeofPhotography(status: 1, msg: e.toString());
  //       }
  //     } else {
  //       return TypeofPhotography(status: 0, msg: 'Something went wrong');
  //     }
  //   } else {
  //     return TypeofPhotography(status: 1, msg: 'No Internet');
  //   }
  // }

  // Categories? categoryValue;

  List selectedDates = [];

  DateTime? adquatationDate;
  List showSelectedDate = [];
  List showPhotographer = [];
  int currentIndex = 0;

  List<int> up = [0];
  final formKey = GlobalKey<FormState>();

  TextEditingController clientNameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController outputController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();

  String? selectedEvents;
  var eventController;
  var cityController;
  var clientName;
  String? userId;
  List<ClientList> clientList = [];

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

  getClients() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    var uri = Uri.parse(getClientPhotographersApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['type'] = "client";
    request.fields['user_id'] = userId.toString();
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      clientList = ClientModel.fromJson(userData).data!;
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

  void increment(int ind) {
    if (up[ind] >= 0 && up[ind] < 10) {
      up[ind]++;
    }
    setState(() {});
  }

  void removeDate(int ind) {
    // if(up[ind]>=0 && up[ind]<10) {
    //   up[ind]--;
    // }
    setState(() {
      showSelectedDate.remove(adquatationDate);
      // selectedDate = showSelectedDate.join(',');
    });
  }

  selectValue(Categories newValue, int index) {
    typeofPhotographyEvent[index].selectedValue = newValue;
    pType.add({
      "photographer_type":
      typeofPhotographyEvent[index].selectedValue!.resName.toString()
    });
    print("this is selected json $pType");
    // if(up[index] >1) {
    //
    // }
    print("____this is new Valueeeeeeeeeeee${newValue.resName}");
    selectedvlaue
        .add(typeofPhotographyEvent[index].selectedValue!.resName.toString());
    selectedEvents = selectedvlaue.join(',');

    print("__________________${selectedvlaue}");

    print('________this____is__________stringlist${selectedEvents}');
  }

  String? selectedDate;

  Future<void> selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != adquatationDate) {
      setState(() {
        adquatationDate = picked;
        String date = DateFormat('dd-MM-yyyy').format(picked);
        print("this is selected date $date");
        showSelectedDate.add(date);
        selectedDate = showSelectedDate.join(',');
        // showPhotographer.add(adquatationDate);
        selectedDates.add(date);
        stringList.add(selectedvlaue);
      });
      print(
          "this is selected date data $adquatationDate fggd ${showSelectedDate.length} and $selectedDate and $selectedDates");
      increment(index);
      // update();
      // selectedValue.add(categoryValue!);
    }
    newList.add(
        jsonEncode({"date": showSelectedDate[currentIndex], "data": pType}));
    print("this is list data $newList and $pType");
    pType.clear();
  }

  // Widget photographerCard(int ind) {
  //   return  GetBuilder(
  //       init: AddQuatationController(),
  //       builder: (controller) {
  //
  //         for(ind = 0 ; ind < showSelectedDate.length ; ind ++) {
  //           controller.up.add(ind);
  //         }
  //         return Container(
  //       decoration: const BoxDecoration(
  //           color: AppColors.teamcard2,
  //           borderRadius: BorderRadius.only(
  //               topRight: Radius.circular(10),
  //               bottomRight: Radius.circular(10),
  //               bottomLeft: Radius.circular(10))),
  //       child: Column(
  //         children: [
  //           const Align(
  //             alignment: Alignment.topRight,
  //             child: Padding(
  //               padding: EdgeInsets.only(top: 4.0, right: 4),
  //               child: Text(
  //                 "(For Developer User Can Hold/Or To Delete This Row)",
  //                 style: TextStyle(
  //                     fontStyle: FontStyle.italic,
  //                     color: AppColors.textclr,
  //                     fontSize: 12),
  //               ),
  //             ),
  //           ),
  //           const  SizedBox(
  //             height: 10,
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.symmetric(
  //                 horizontal: 8.0, vertical: 5),
  //             child: Column(
  //               children: [
  //                 const Padding(
  //                   padding: EdgeInsets.only(bottom: 8.0),
  //                   child: Align(
  //                     alignment: Alignment.topLeft,
  //                     child: Text(
  //                       "Type Of Photographer",
  //                       style: TextStyle(
  //                           fontWeight: FontWeight.w500,
  //                           color: AppColors.textclr,
  //                           fontSize: 18),
  //                     ),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: 165,
  //                   child: ListView.builder(
  //                     itemCount: controller.up[ind],
  //                     itemBuilder: (context, index) {
  //                       return Padding(
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 0.0, vertical: 5),
  //                         child: Container(
  //                           height: 30,
  //                           padding: const EdgeInsets.symmetric(
  //                               horizontal: 8, vertical: 0),
  //                           decoration: BoxDecoration(
  //                               borderRadius:
  //                               BorderRadius.circular(0),
  //                               color: AppColors.datecontainer),
  //                           width: MediaQuery.of(context)
  //                               .size
  //                               .width /
  //                               1.0,
  //                           child: DropdownButtonHideUnderline(
  //                             child: DropdownButton(
  //                               dropdownColor: AppColors.cardclr,
  //                               // Initial Value
  //                               value: controller.typeofPhotographyEvent[index]
  //                                   .selectedValue,
  //                               isExpanded: true,
  //                               hint: const Text(
  //                                 "Type Of Photography",
  //                                 style: TextStyle(
  //                                     color: AppColors.textclr),
  //                               ),
  //                               icon: const Icon(
  //                                 Icons.keyboard_arrow_down,
  //                                 color: AppColors.textclr,
  //                               ),
  //                               // Array list of items
  //                               items: controller
  //                                   .typeofPhotographyEvent
  //                                   .map((Categories items) {
  //                                 return DropdownMenuItem<
  //                                     Categories>(
  //                                   value: items,
  //                                   child: Text(
  //                                     items.resName.toString(),
  //                                     style: const TextStyle(
  //                                         color:
  //                                         AppColors.textclr),
  //                                   ),
  //                                 );
  //                               }).toList(),
  //                               // After selecting the desired option,it will
  //                               // change button value to selected value
  //                               onChanged: (newValue) {
  //                                 controller.selectValue(
  //                                     newValue ?? Categories(),
  //                                     index);
  //                                 controller.update();
  //                               },
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           const Align(
  //             alignment: Alignment.center,
  //             child: Text(
  //               "(For Developer User Can Hold/Or To Delete This Row)",
  //               style: TextStyle(
  //                   fontStyle: FontStyle.italic,
  //                   color: AppColors.textclr,
  //                   fontSize: 13),
  //             ),
  //           ),
  //           const SizedBox(
  //             height: 10,
  //           ),
  //           InkWell(
  //             onTap: () {
  //              controller.increment(ind);
  //             },
  //             child: Column(
  //               children: const [
  //                 Padding(
  //                   padding: EdgeInsets.all(5.0),
  //                   child: Icon(
  //                     Icons.add_circle_outline,
  //                     color: AppColors.temtextclr,
  //                     size: 30,
  //                   ),
  //                 ),
  //                 Text(
  //                   "Add Type Of Photographer",
  //                   style: TextStyle(
  //                       color: AppColors.temtextclr,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ],
  //             ),
  //           ),
  //          const SizedBox(
  //             height: 20,
  //           ),
  //         ],
  //       ),
  //     );
  //       }
  //   );
  // }

  Widget photographerCard1(int ind) {
    for (ind = 0; ind < showSelectedDate.length; ind++) {
      up.add(ind);
    }
    return Container(
      decoration: const BoxDecoration(
          color: AppColors.teamcard2,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10),
              bottomLeft: Radius.circular(10))),
      child: Column(
        children: [
          // const Align(
          //   alignment: Alignment.topRight,
          //   child: Padding(
          //     padding: EdgeInsets.only(top: 4.0, right: 4),
          //     child: Text(
          //       "(For Developer User Can Hold/Or To Delete This Row)",
          //       style: TextStyle(
          //           fontStyle: FontStyle.italic,
          //           color: AppColors.textclr,
          //           fontSize: 12),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Type Of Photographer",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.textclr,
                          fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(
                  height: 165,
                  child: ListView.builder(
                    itemCount: up[ind],
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 30,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: AppColors.datecontainer),
                              width: MediaQuery.of(context).size.width / 1.4,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  dropdownColor: AppColors.cardclr,
                                  // Initial Value
                                  value:
                                  typeofPhotographyEvent[index].selectedValue,
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
                                    return DropdownMenuItem<Categories>(
                                      value: items,
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
                                    selectValue(newValue ?? Categories(), index);

                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: (){
                                  setState(() {
                                    up.removeAt(index);
                                  });

                                }, child: Icon(Icons.delete_forever, color: Colors.red,))
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // const Align(
          //   alignment: Alignment.center,
          //   child: Text(
          //     "(For Developer User Can Hold/Or To Delete This Row)",
          //     style: TextStyle(
          //         fontStyle: FontStyle.italic,
          //         color: AppColors.textclr,
          //         fontSize: 13),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              increment(ind);
            },
            child: Column(
              children: const [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.add_circle_outline,
                    color: AppColors.temtextclr,
                    size: 30,
                  ),
                ),
                Text(
                  "Add Type Of Photographer",
                  style: TextStyle(
                      color: AppColors.temtextclr,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool show = false;

  Widget dateCard(int index) {
    return InkWell(
      onTap: () {
        if (currentIndex == index) {
          setState(() {
            show = true;
          });
        }
      },
      child: Stack(
        children: [
          Container(
            // width: 100,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8), topLeft: Radius.circular(8)),
              color: AppColors.teamcard2,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: const BoxDecoration(
                  color: AppColors.datecontainer,
                ),
                child: Text(
                  showSelectedDate[index] != null
                      ? ' ${showSelectedDate[index]}'
                      : 'Select Start Date',
                  style:
                  const TextStyle(color: AppColors.textclr, fontSize: 12),
                ),
              ),
            ),
          ),
          Positioned(
              right: -12,
              top: -17,
              child: IconButton(
                  onPressed: () {
                    setState(() {

                    });
                    showSelectedDate.removeAt(index);
                    // removeDate(index);
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    size: 18,
                    color: AppColors.temtextclr,
                  )))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getPhotographerType();
    getEventTypes();
    getCitiesList();
    getClients();
  }

  List pType = [];
  List pData = [];
  List newList = [];

  addQuotation() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
    };

    var request =
    http.MultipartRequest('POST', Uri.parse(addQuotationApi.toString()));

    request.fields.addAll({
      'client_name': clientName.toString(),
      'city': cityNameController.text.toString(),
      'mobile': mobileController.text.toString(),
      'type_event': eventController.toString(),
      'output': outputController.text.toString(),
      'amount': amountController.text.toString(),
      // 'event[]': selectedEvents.toString(),
      'type': 'client',
      'event_details': newList.toString(),
      // 'date[]': selectedDate.toString(),
      'user_id': userId.toString()
    });
    print("this is add quotation request ${request.fields.toString()}");

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

  // Future<void> addQuotation() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? userId = preferences.getString('id');
  //
  //   var request = http.MultipartRequest('POST', Uri.parse(addQuotationApi.toString()));
  //
  //   // Loop through the key values
  //   // var keyValueList = [
  //   //   {'key': 'name', 'value': 'John'},
  //   //   {'key': 'name', 'value': 'Alice'},
  //   //   {'key': 'name', 'value': 'Bob'}
  //   // ];
  //   request.fields.addAll({
  //     'client_name': clientNameController.text.toString(),
  //     'city': cityController.toString(),
  //     'mobile': mobileController.text.toString(),
  //     'type_event': eventController.toString(),
  //     'output': outputController.text.toString(),
  //     'amount': amountController.text.toString(),
  //     'event[]': selectedEvents.toString(),
  //     'type': 'client',
  //     'date[]': selectedDate.toString(),
  //     'user_id': userId.toString()
  //   });
  //   // var fields = {
  //   //   'date[]': 'value1',
  //   // };
  //
  //   showSelectedDate.forEach((value) {
  //     request.fields['date[]'] = value;
  //   });
  //   for (var i=0; i < showSelectedDate.length; i ++) {
  //     request.fields['date[]'] = showSelectedDate[i];
  //   }
  //   print("this is add quotation request ${request.fields.toString()}");
  //
  //   // Attach files if needed
  //   // request.files.add(await http.MultipartFile.fromPath(
  //   //   'file',
  //   //   'path/to/file.jpg',
  //   //   contentType: MediaType('image', 'jpeg'),
  //   // ));
  //
  //   var response = await request.send();
  //   if (response.statusCode == 200) {
  //     String responseData = await response.stream.transform(utf8.decoder).join();
  //     var userData = json.decode(responseData);
  //     Navigator.pop(context, true);
  //     Fluttertoast.showToast(msg: userData['message']);
  //     // print('Multipart request sent successfully!');
  //   } else {
  //     print('Error sending multipart request. Status code: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AddQuatationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.back,
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.AppbtnColor,
                )),
            backgroundColor: AppColors.secondary,
            actions: const [
              Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                  child: Text("Add New Quotation",
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.AppbtnColor,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.teamcard2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 0),
                        child: Column(
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     const Text("Auto Q ID",style: TextStyle(color: AppColors.pdfbtn),),
                            //     Padding(
                            //       padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(10),
                            //             color: AppColors.containerclr2),
                            //         padding: EdgeInsets.symmetric(vertical: 5),
                            //         width: MediaQuery.of(context).size.width/2.1,
                            //         child: const Padding(
                            //           padding: EdgeInsets.all(10.0),
                            //           child: Text("Q001",style: TextStyle(color: AppColors.textclr),),
                            //         ),),
                            //     )
                            //   ],
                            // ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Client Name",
                                  style: TextStyle(color: AppColors.pdfbtn),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.containerclr2),
                                    // padding: EdgeInsets.symmetric(vertical: 1),
                                    width:
                                    MediaQuery.of(context).size.width / 2.1,
                                    child: CustomSearchableDropDown(
                                      dropdownHintText: "Client Name",
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
                                      items: clientList,
                                      label: 'Client Name',
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
                                      dropDownMenuItems: clientList.map((item) {
                                        return "${item.firstName} ${item.lastName}";
                                      }).toList() ??
                                          [],
                                      onChanged: (value) {
                                        if (value != null) {
                                          print("this is my value ${value.firstName}");
                                          clientName = "${value.firstName} ${value.lastName}";
                                          cityNameController.text = value.city;
                                          mobileController.text = value.mobile;
                                          //  setState(() {
                                          //   selectedDesignation = jsonDecode(value);
                                          //   // });
                                          // }
                                          // else {
                                          //   //setState(() {
                                          //   selectedDesignation.clear();
                                          // });
                                        }
                                      },
                                    ),

                                  ),
                                ),
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
                                    // padding: EdgeInsets.only(left: 8),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.containerclr2),
                                    width:
                                    MediaQuery.of(context).size.width / 2.1,
                                    child:
                                    // DropdownButtonHideUnderline(
                                    //   child: DropdownButton(
                                    //     dropdownColor: AppColors.cardclr,
                                    //     // Initial Value
                                    //     value: cityController,
                                    //     isExpanded: true,
                                    //     hint: const Text(
                                    //       "City",
                                    //       style: TextStyle(
                                    //           color: AppColors.textclr),
                                    //     ),
                                    //     icon: const Icon(
                                    //       Icons.keyboard_arrow_down,
                                    //       color: AppColors.textclr,
                                    //     ),
                                    //     // Array list of items
                                    //
                                    //     items: citiesList.map((items) {
                                    //       return DropdownMenuItem(
                                    //         value: items.id.toString(),
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
                                    //         cityController = newValue;
                                    //       });
                                    //     },
                                    //   ),
                                    // ),
                                    TextFormField(
                                      style: const TextStyle(
                                          color: AppColors.textclr),
                                      controller: cityNameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) => value!.isEmpty
                                          ? ' City/Venue cannot be blank'
                                          : null,
                                      decoration: const InputDecoration(
                                          hintText: 'City/Venue',
                                          hintStyle: TextStyle(
                                              color: AppColors.textclr,
                                              fontSize: 14),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 10, bottom: 6)),
                                    ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Mobile",
                                  style: TextStyle(color: AppColors.pdfbtn),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.containerclr2),
                                    width:
                                    MediaQuery.of(context).size.width / 2.1,
                                    child: TextFormField(
                                      style: const TextStyle(
                                          color: AppColors.textclr),
                                      controller: mobileController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 10,
                                      validator: (value) => value!.isEmpty
                                          ? ' Mobile cannot be blank'
                                          : null,
                                      decoration: const InputDecoration(
                                          counterText: "",
                                          hintText: 'Enter Mobile',
                                          hintStyle: TextStyle(
                                              color: AppColors.textclr,
                                              fontSize: 14),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 10, bottom: 6)),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 40,
                          width: showSelectedDate.isEmpty
                              ? 125
                              : MediaQuery.of(context).size.width - 125,
                          child: showSelectedDate.isEmpty
                              ? InkWell(
                            onTap: () {
                              // if(currentIndex == index){
                              //   setState(() {
                              //     show = true;
                              //   });
                              // }
                            },
                            child: Container(
                              width: 125,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8)),
                                color: AppColors.teamcard2,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  decoration: const BoxDecoration(
                                    color: AppColors.datecontainer,
                                  ),
                                  child: const Text(
                                    // showSelectedDate[index] != null
                                    //     ? ' ${DateFormat('yyyy-MM-dd').format(showSelectedDate[index])}'
                                    'Select Start Date',
                                    style: TextStyle(
                                        color: AppColors.textclr,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          )
                              : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: showSelectedDate.length,
                              itemBuilder: (context, index) {
                                currentIndex = index;
                                return dateCard(index);
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                            onTap: () {
                              // if(showSelectedDate.isNotEmpty) {

                              // setState(() {
                              //   customWidgets.add(photographerCard());
                              // });
                              // if(cardCount>=0&&cardCount<10) { v
                              //   cardCount++;
                              // }
                              selectDate(context, 1);
                              // }else{
                              //   selectDate(context, 1);
                              // }
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: AppColors.temtextclr,
                                  size: 28,
                                ),
                                Text(
                                  "Add Date",
                                  style: TextStyle(
                                      color: AppColors.temtextclr,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    photographerCard1(currentIndex),
                    //       ListView.builder(
                    //         shrinkWrap: true,
                    //         itemCount: showSelectedDate.length,
                    //                 itemBuilder: (context, i) {
                    //                   return
                    // currentIndex == i ?
                    //                 photographerCard1(currentIndex)
                    //                   : SizedBox.shrink();
                    //
                    //           }),
                    // Container(
                    //   height: 300,
                    //   // width: 300,
                    //   child: ListView.builder(
                    //       shrinkWrap: true,
                    //       itemCount: showPhotographer.length,
                    //       itemBuilder: (context, index){
                    //         return
                    //           photographerCard(currentIndex);
                    //       }),
                    // ),

                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,

                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Output",
                            style: TextStyle(
                                color: AppColors.textclr,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.teamcard,
                                borderRadius: BorderRadius.circular(10)),
                            height: 70,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                maxLines: 4,
                                style: const TextStyle(
                                    color: AppColors.textclr, fontSize: 14),
                                controller: outputController,
                                keyboardType: TextInputType.name,
                                validator: (value) => value!.isEmpty
                                    ? 'Output cannot be blank'
                                    : null,
                                decoration: const InputDecoration(
                                    hintText: '',
                                    hintStyle: TextStyle(
                                        color: AppColors.textclr, fontSize: 14),
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 10, bottom: 10)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          const Text(
                            "Amount",
                            style: TextStyle(
                                color: AppColors.textclr,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Spacer(),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.teamcard,
                                borderRadius: BorderRadius.circular(10)),
                            height: 35,
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: TextFormField(
                              style: TextStyle(color: AppColors.textclr),
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              validator: (value) => value!.isEmpty
                                  ? 'Amount cannot be blank'
                                  : null,
                              decoration: const InputDecoration(
                                  hintText: '',
                                  hintStyle: TextStyle(
                                      color: AppColors.textclr, fontSize: 14),
                                  border: InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.only(left: 10, bottom: 10)),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          newList.add(jsonEncode({
                            "date": showSelectedDate[currentIndex],
                            "data": pType
                          }));
                          List finalList = [];
                          for(var i = 0 ; i < newList.length; i++) {
                            finalList.add(newList[i]);
                          }
                          print("this final List $newList and and $finalList");
                          if(eventController != null) {
                             addQuotation();
                          }
                          else {
                            Fluttertoast.showToast(
                                msg: "Please select city or event!");
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please select city or event!");
                        }

                        // Navigator.push(context, MaterialPageRoute(builder: (context) => MoreQuatations()));
                      },
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width / 1.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.pdfbtn),
                        child: const Center(
                          child: Text("Add",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whit)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
