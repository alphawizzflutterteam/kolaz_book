import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:kolazz_book/Models/Type_of_photography_model.dart';
import 'package:kolazz_book/Models/client_model.dart';
import 'package:kolazz_book/Models/event_type_model.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Models/get_quotation_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/colors.dart';
import '../../Utils/strings.dart';

class EditQuotation extends StatefulWidget {
  final String? qid, id;
  const EditQuotation({Key? key, this.qid, this.id}) : super(key: key);

  @override
  State<EditQuotation> createState() => _EditQuotationState();
}

class _EditQuotationState extends State<EditQuotation> {
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
  List pType = [];
  List pData = [];
  List newList = [];

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
  List<Setting> quotationData = [];

  String? SelectedGender;
  String? dropdownValue;
  String? qid;

  int dateIndex = 0;
  var photographerType;

  void increment(int ind) {
    print(ind);
    if (up[ind] >= 0 && up[ind] < 10) {
      up[ind]++;
    }
    setState(() {});
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
        // var newIndex = quotationData[0].photographersDetails!.length;
        // quotationData[0].photographersDetails![newIndex].setDate = date;
        showSelectedDate.add(date);

        // quotationData[0].photographersDetails![newIndex].setDate = date;
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

  // _shareQrCode({String? text}) async{
  //
  //     // iconVisible = true ;
  //     var status =  await Permission.photos.request();
  //     //Permission.manageExternalStorage.request();
  //
  //     //PermissionStatus storagePermission = await Permission.storage.request();
  //     if ( status.isGranted/*storagePermission == PermissionStatus.denied*/) {
  //       final directory = (await getApplicationDocumentsDirectory()).path;
  //
  //       RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
  //       /*if(bound.debugNeedsPaint){
  //       Timer(const Duration(seconds: 2),()=>_shareQrCode());
  //       return null;
  //     }*/
  //       ui.Image image = await bound.toImage(pixelRatio: 10);
  //       ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //
  //       print('${byteData?.buffer.lengthInBytes}___________');
  //       // this will save image screenshot in gallery
  //       if(byteData != null ){
  //         Uint8List pngBytes = byteData.buffer.asUint8List();
  //         String fileName = DateTime
  //             .now()
  //             .microsecondsSinceEpoch
  //             .toString();
  //         final imagePath = await File('$directory/$fileName.png').create();
  //         await imagePath.writeAsBytes(pngBytes);
  //         Share.shareFiles([imagePath.path],text: text);
  //         // final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}.png');
  //         //print(resultsave);
  //       }
  //       /*_screenshotController.capture().then((Uint8List? image) async {
  //       if (image != null) {
  //         try {
  //           String fileName = DateTime
  //               .now()
  //               .microsecondsSinceEpoch
  //               .toString();
  //
  //           final imagePath = await File('$directory/$fileName.png').create();
  //           if (imagePath != null) {
  //             await imagePath.writeAsBytes(image);
  //             Share.shareFiles([imagePath.path],text: text);
  //           }
  //         } catch (error) {}
  //       }
  //     }).catchError((onError) {
  //       print('Error --->> $onError');
  //     });*/
  //     } else if (await status.isDenied/*storagePermission == PermissionStatus.denied*/) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           const SnackBar(content: Text('This Permission is recommended')));
  //     } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
  //       openAppSettings().then((value) {
  //
  //       });
  //     }
  //   }

  // Future<void> selectDate(BuildContext context, int index) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime(2100),
  //   );
  //   if (picked != null && picked != adquatationDate) {
  //     setState(() {
  //       adquatationDate = picked;
  //       String date = DateFormat('dd-MM-yyyy').format(picked);
  //       print("this is selected date $date");
  //       showSelectedDate.add(date);
  //       selectedDate = showSelectedDate.join(',');
  //       // showPhotographer.add(adquatationDate);
  //       selectedDates.add(date);
  //       stringList.add(selectedvlaue);
  //     });
  //     print(
  //         "this is selected date data $adquatationDate fggd ${showSelectedDate.length} and $selectedDate and $selectedDates");
  //     increment(index);
  //     // update();
  //     // selectedValue.add(categoryValue!);
  //   }
  //   newList.add(
  //       jsonEncode({"date": showSelectedDate[currentIndex], "data": pType}));
  //   print("this is list data $newList and $pType");
  //   pType.clear();
  // }
  deleteConfirmation(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      title: const Text(
        'Delete Quotation!',
        style: TextStyle(color: AppColors.textclr),
      ),
      content: const Text(
        'Are you sure you want to delete this quotation?',
        style: TextStyle(color: AppColors.textclr),
      ),
      actions: [
        TextButton(
          child: Container(
              height: 25,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.AppbtnColor),
              child: const Center(
                  child: Text(
                'No',
                style: TextStyle(color: AppColors.textclr),
              ))),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        TextButton(
          child: Container(
              height: 25,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.AppbtnColor),
              child: const Center(
                  child: Text(
                'Yes',
                style: TextStyle(color: AppColors.textclr),
              ))),
          onPressed: () {
            deleteQuotation(quotationData[0].id.toString(), context);
            Navigator.of(context).pop(true);
          },
        ),
      ],
    );
  }

  deleteQuotation(String id, BuildContext context) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();ff
    // String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(deleteQuotationApi.toString()));
    request.fields.addAll({'id': id.toString()});
    print(
        "this is delete quotation request ${request.fields.toString()} and $deleteQuotationApi");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (userData['error'] == false) {
        Navigator.pop(context, false);
        Fluttertoast.showToast(msg: userData['message']);

      } else {
        Fluttertoast.showToast(msg: userData['message']);
        // Fluttertoast.showToast(msg: userData['msg']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  // Widget dateCard(int index) {
  //   return InkWell(
  //     onTap: () {
  //       if (currentIndex == index) {
  //       }
  //     },
  //     child: Stack(
  //       children: [
  //         Container(
  //           // width: 100,
  //           decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //                 topRight: Radius.circular(8), topLeft: Radius.circular(8)),
  //             color: AppColors.teamcard2,
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
  //             child: Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
  //               decoration: const BoxDecoration(
  //                 color: AppColors.datecontainer,
  //               ),
  //               child: Text(
  //                 showSelectedDate[index] != null
  //                     ? ' ${showSelectedDate[index]}'
  //                     : 'Select Start Date',
  //                 style:
  //                 const TextStyle(color: AppColors.textclr, fontSize: 12),
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //             right: -12,
  //             top: -17,
  //             child: IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //
  //                   });
  //                   showSelectedDate.removeAt(index);
  //                   // removeDate(index);
  //                 },
  //                 icon: const Icon(
  //                   Icons.remove_circle_outline,
  //                   size: 18,
  //                   color: AppColors.temtextclr,
  //                 )))
  //       ],
  //     ),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    getQuotationDetails();
    getPhotographerType();
    getCitiesList();
    getEventTypes();
  }

  getQuotationDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var uri = Uri.parse(getQuotationApi.toString());

    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.fields.addAll({
      'user_id': userId.toString(),
      'type': 'client',
      'id': widget.id.toString(),
    });
    request.headers.addAll(headers);
    // request.fields['user_id'] = userId.toString();
    // request.fields['type'] = 'photographer';
    print("this is my quotation Details  ${request.fields.toString()}");
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    final result = GetQuotationModel.fromJson(userData);
    quotationData = result.setting!;
    clientNameController.text = quotationData[0].clientName.toString();
    cityController = quotationData[0].city.toString();
    cityNameController.text = quotationData[0].cityName.toString();
    eventController = quotationData[0].typeEvent.toString();
    amountController.text = quotationData[0].amount.toString();
    outputController.text = quotationData[0].output.toString();
    // clientNameController.text = quotationData![0].clientName.toString();
  }

  createClientJob(BuildContext context) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? userId = preferences.getString('id');
    var uri = Uri.parse(createClientJobApi.toString());

    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.fields.addAll({
      // 'user_id': userId.toString(),
      // 'type': 'client',
      'id': widget.id.toString(),
    });
    request.headers.addAll(headers);
    // request.fields['user_id'] = userId.toString();
    // request.fields['type'] = 'photographer';
    print("this is my quotation Details  ${request.fields.toString()}");
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    Fluttertoast.showToast(msg: userData['message']);
    Navigator.pop(context);
    Navigator.pop(context, true);
  }
  // getQuotationDetails() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? id = preferences.getString('id');
  //   var uri =
  //   Uri.parse(getQuotationApi.toString());
  //   // '${Apipath.getCitiesUrl}');
  //   var request = http.MultipartRequest("POST", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //
  //   request.headers.addAll(headers);
  //   request.fields[RequestKeys.userId] = id!;
  //   request.fields[RequestKeys.type] = 'client';
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //
  //   setState(() {
  //     getQuotation = GetQuotationModel.fromJson(userData).setting!;
  //   });
  // }

  updateQuotation() async {
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
      'user_id': userId.toString(),
      'id': widget.id.toString()
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.AppbtnColor,
            )),
        backgroundColor: AppColors.secondary,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Text("Edit Quotation",
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
          child: quotationData.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: AppColors.teamcard2,
                    //       borderRadius: BorderRadius.circular(10)),
                    //   child: Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
                    //     child: Column(
                    //       children: [
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //
                    //             const Text("Auto Q ID",style: TextStyle(color: AppColors.pdfbtn),),
                    //             Padding(
                    //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
                    //               child: Container(
                    //
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                     color: AppColors.containerclr2),
                    //                 padding: EdgeInsets.symmetric(vertical: 5),
                    //                 width: MediaQuery.of(context).size.width/2.1,
                    //                 child: const Padding(
                    //                   padding: EdgeInsets.all(10.0),
                    //                   child: Text("Q001",style: TextStyle(color: AppColors.textclr),),
                    //                 ),),
                    //             )
                    //           ],
                    //         ),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             const Text("Client Name",style: TextStyle(color: AppColors.pdfbtn),),
                    //             Padding(
                    //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
                    //               child: Container(
                    //
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                     color: AppColors.containerclr2),
                    //                 padding: EdgeInsets.symmetric(vertical: 5),
                    //                 width: MediaQuery.of(context).size.width/2.1,
                    //                 child: const Padding(
                    //                   padding: EdgeInsets.all(10.0),
                    //                   child: Text("Kinjal Patel",style: TextStyle(color: AppColors.textclr),),
                    //                 ),),
                    //             )
                    //
                    //           ],
                    //         ) ,
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text("City/Venue",style: TextStyle(color: AppColors.pdfbtn),),
                    //             Padding(
                    //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
                    //               child: Container(
                    //
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                     color: AppColors.containerclr2),
                    //                 padding: EdgeInsets.symmetric(vertical: 5),
                    //                 width: MediaQuery.of(context).size.width/2.1,
                    //                 child: const Padding(
                    //                   padding: EdgeInsets.all(10.0),
                    //                   child: Text("Kanpur",style: TextStyle(color: AppColors.textclr),),
                    //                 ),),
                    //             )
                    //
                    //           ],
                    //         ),
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text("Event",style: TextStyle(color: AppColors.pdfbtn),),
                    //             Padding(
                    //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
                    //               child: Container(
                    //
                    //                 decoration: BoxDecoration(
                    //                     borderRadius: BorderRadius.circular(10),
                    //                     color: AppColors.containerclr2),
                    //                 padding: EdgeInsets.symmetric(vertical: 5),
                    //                 width: MediaQuery.of(context).size.width/2.1,
                    //                 child: const Padding(
                    //                   padding: EdgeInsets.all(10.0),
                    //                   child: Text("Wedding",style: TextStyle(color: AppColors.textclr),),
                    //                 ),),
                    //             )
                    //
                    //           ],
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff3B3B3B),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Auto CF ID",
                                  style: TextStyle(
                                      color: Color(0xff42ACFE),
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.1,
                                  // width:180,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.backgruond,
                                  ),

                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          widget.qid.toString(),
                                          // quotationData![0].qid.toString(),
                                          style:
                                              TextStyle(color: AppColors.whit),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Client Name",
                                  style: TextStyle(
                                      color: Color(0xff42ACFE),
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.containerclr2),
                                    // padding: EdgeInsets.symmetric(vertical: 1),
                                    // width:180,
                                    // height: 30,
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: TextFormField(
                                      style: const TextStyle(
                                          color: AppColors.textclr),
                                      controller: clientNameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) => value!.isEmpty
                                          ? 'Client Name cannot be blank'
                                          : null,
                                      decoration: const InputDecoration(
                                          hintText: 'Enter Client Name',
                                          hintStyle: TextStyle(
                                              color: AppColors.textclr,
                                              fontSize: 14),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                              left: 8, bottom: 12)),
                                    ),
                                  ),
                                )
                                // Container(
                                //   width:180,
                                //   height: 35,
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(8),
                                //     color: AppColors.backgruond,
                                //   ),
                                //   child: DropdownButtonHideUnderline(
                                //     child: DropdownButton(
                                //       elevation: 0,
                                //       underline: Container(),
                                //       isExpanded: true,
                                //       value: _chosenValue,
                                //       icon: Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
                                //       hint: Align(alignment: Alignment.centerLeft,
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: Text("Kaushik Prajapati", style: TextStyle(
                                //               color:AppColors.whit
                                //           ),),
                                //         ),
                                //       ),
                                //       items:item.map((String items) {
                                //         return DropdownMenuItem(
                                //             value: items,
                                //             child: Text(items)
                                //         );
                                //       }
                                //       ).toList(),
                                //       onChanged: (String? newValue){
                                //         setState(() {
                                //           _chosenValue = newValue!;
                                //         });
                                //       },
                                //
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
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
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.containerclr2),
                                    width:
                                        MediaQuery.of(context).size.width / 2.1,
                                    child: TextFormField(
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
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    quotationData.isNotEmpty
                        ? Row(
                            children: [
                              Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width /1.4,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: quotationData[0]
                                        .photographersDetails!
                                        .length,
                                    itemBuilder: (context, j) {
                                      return Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              dateIndex = j;
                                              setState(() {});
                                            },
                                            child: Container(
                                              // width: 110,
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
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 5),
                                                  decoration: const BoxDecoration(
                                                    color: AppColors.datecontainer,
                                                  ),
                                                  child: Text(
                                                    quotationData[0]
                                                        .photographersDetails![j]
                                                        .date
                                                        .toString(),
                                                    overflow: TextOverflow.fade,
                                                    style: const TextStyle(
                                                        color: AppColors.textclr),
                                                  ),
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
                                                    quotationData[0]
                                                        .photographersDetails!.removeAt(j);
                                                    // removeDate(index);
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_circle_outline,
                                                    size: 18,
                                                    color: AppColors.temtextclr,
                                                  )))
                                        ],
                                      );
                                    }),
                              ),
                              // showSelectedDate.isNotEmpty ?   Container(
                              //   height: 45,
                              //   width: MediaQuery.of(context).size.width / 3,
                              //   child: ListView.builder(
                              //       scrollDirection: Axis.horizontal,
                              //       shrinkWrap: true,
                              //       itemCount: showSelectedDate.length,
                              //       itemBuilder: (context, index) {
                              //         currentIndex = index;
                              //         return dateCard(index);
                              //       })
                              // )
                              // : SizedBox.shrink(),
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
                          )
                        : SizedBox.shrink(),
                    // Row(
                    //   children: [
                    //
                    //   Container(
                    //     margin: EdgeInsets.zero,
                    //     decoration: const BoxDecoration(
                    //       borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                    //       color: AppColors.teamcard2,
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    //         decoration: const BoxDecoration(
                    //           color:AppColors.datecontainer,
                    //z
                    //         ),
                    //         child: const Text("22/2/2023",style: TextStyle(color: AppColors.textclr),),
                    //       ),
                    //     ),
                    //   ),
                    //   const Padding(
                    //     padding:  EdgeInsets.all(5.0),
                    //     child: Icon(Icons.add_circle_outline,color: AppColors.temtextclr,size: 30,),
                    //   ),
                    //   Text("Add Date",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),)
                    //
                    // ],),
                    Container(
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
                          //   child: Text(
                          //     "(For Developer User Can Hold/Or To Delete This Row)",
                          //     style: TextStyle(
                          //         fontStyle: FontStyle.italic,
                          //         color: AppColors.textclr,
                          //         fontSize: 12),
                          //   ),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 8),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
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
                                quotationData.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        // scrollDirection: Axis.horizontal,
                                        itemCount: quotationData[0]
                                            .photographersDetails![dateIndex]
                                            .data!
                                            .length,
                                        itemBuilder: (context, j) {
                                          photographerType = quotationData[0]
                                              .photographersDetails![dateIndex]
                                              .data![j]
                                              .photographerType;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0.0, vertical: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 30,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8,
                                                      vertical: 0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      color: AppColors
                                                          .datecontainer),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.4,
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      dropdownColor:
                                                          AppColors.cardclr,
                                                      // Initial Value
                                                      value: photographerType,
                                                      // typeofPhotographyEvent[index].selectedValue,
                                                      isExpanded: true,
                                                      hint: const Text(
                                                        "Type Of Photography",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .textclr),
                                                      ),
                                                      icon: const Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color:
                                                            AppColors.textclr,
                                                      ),
                                                      // Array list of items
                                                      items:
                                                          typeofPhotographyEvent
                                                              .map((items) {
                                                        return DropdownMenuItem(
                                                          value: items.resName,
                                                          child: Text(
                                                            items.resName
                                                                .toString(),
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .textclr),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      // After selecting the desired option,it will
                                                      // change button value to selected value
                                                      onChanged: (newValue) {
                                                        setState(() {
                                                          quotationData[0]
                                                                  .photographersDetails![
                                                                      dateIndex]
                                                                  .data![j]
                                                                  .setPhotographer =
                                                              newValue;
                                                        });

                                                        // selectValue(newValue ?? Categories(), index);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      quotationData[0]
                                                          .photographersDetails![
                                                              dateIndex]
                                                          .data!
                                                          .removeAt(j);
                                                      // up.removeAt(index);
                                                      setState(() {});
                                                    },
                                                    child: const Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.red,
                                                    ))
                                              ],
                                            ),
                                          );
                                        })
                                    : const SizedBox.shrink(),
                                // SizedBox(
                                //   height: 165,
                                //   child: ListView.builder(
                                //     physics: NeverScrollableScrollPhysics(),
                                //     itemCount: up[dateIndex],
                                //     itemBuilder: (context, index) {
                                //       return Padding(
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 0.0, vertical: 5),
                                //         child: Row(
                                //           children: [
                                //             Container(
                                //               height: 30,
                                //               padding: const EdgeInsets.symmetric(
                                //                   horizontal: 8, vertical: 0),
                                //               decoration: BoxDecoration(
                                //                   borderRadius: BorderRadius.circular(0),
                                //                   color: AppColors.datecontainer),
                                //               width: MediaQuery.of(context).size.width / 1.4,
                                //               child: DropdownButtonHideUnderline(
                                //                 child: DropdownButton(
                                //                   dropdownColor: AppColors.cardclr,
                                //                   // Initial Value
                                //                   value: photographerType,
                                //                   isExpanded: true,
                                //                   hint: const Text(
                                //                     "Type Of Photography",
                                //                     style: TextStyle(color: AppColors.textclr),
                                //                   ),
                                //                   icon: const Icon(
                                //                     Icons.keyboard_arrow_down,
                                //                     color: AppColors.textclr,
                                //                   ),
                                //                   // Array list of items
                                //                   items: typeofPhotographyEvent
                                //                       .map((Categories items) {
                                //                     return DropdownMenuItem<Categories>(
                                //                       value: items,
                                //                       child: Text(
                                //                         items.resName.toString(),
                                //                         style: const TextStyle(
                                //                             color: AppColors.textclr),
                                //                       ),
                                //                     );
                                //                   }).toList(),
                                //                   // After selecting the desired option,it will
                                //                   // change button value to selected value
                                //                   onChanged: (newValue) {
                                //                     // selectValue(newValue ?? Categories(), index);
                                //
                                //                     setState(() {});
                                //                   },
                                //                 ),
                                //               ),
                                //             ),
                                //             InkWell(onTap: (){
                                //               up.removeAt(index);
                                //               setState(() {
                                //
                                //               });
                                //             }, child: Icon(Icons.delete_forever, color: Colors.red,))
                                //           ],
                                //         ),
                                //       );
                                //     },
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    increment(currentIndex);
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
                              ],
                            ),
                          ),

                          ///ADD PHOTOGRAPHER TYPE BUTTON
                          // Align(
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     "(For Developer User Can Hold/Or To Delete This Row)",
                          //     style: TextStyle(
                          //         fontStyle: FontStyle.italic,
                          //         color: AppColors.textclr,
                          //         fontSize: 13),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(5.0),
                          //   child: Icon(
                          //     Icons.add_circle_outline,
                          //     color: AppColors.temtextclr,
                          //     size: 30,
                          //   ),
                          // ),
                          // Text(
                          //   "Add Type Of Photographer",
                          //   style: TextStyle(
                          //       color: AppColors.temtextclr,
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          ///ADD PHOTOGRAPHER TYPE BUTTON
                        ],
                      ),
                    ),
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
                    const SizedBox(
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
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            updateQuotation();
                            // await showDialog(
                            //     context: context,
                            //     builder: (context) {
                            //       return deleteConfirmation(context);
                            //     });
                          },
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppColors.AppbtnColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                                child: Text(
                                  "Update",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textclr,
                                      fontSize: 18),
                                )),
                          ),
                        ),
                        // Container(
                        //   height: 50,
                        //   width: 150,
                        //   decoration: BoxDecoration(
                        //       color: AppColors.AppbtnColor,
                        //       borderRadius: BorderRadius.circular(5)),
                        //   child: Center(
                        //       child: Text(
                        //     "Update",
                        //     style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: AppColors.textclr,
                        //         fontSize: 18),
                        //   )),
                        // ),
                        Image.asset(
                          "assets/images/pdf.png",
                          scale: 1.6,
                        ),
                        InkWell(
                          onTap: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return deleteConfirmation(context);
                                });
                          },
                          child: Container(
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: AppColors.contaccontainerred,
                                borderRadius: BorderRadius.circular(30)),
                            child: const Center(
                                child: Text(
                              "Delete",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textclr,
                                  fontSize: 18),
                            )),
                          ),
                        ),
                      ],
                    ),

                   const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        createClientJob(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => MoreQuatations()));
                      },
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: AppColors.pdfbtn),
                        child: const Center(
                          child: Text("Final Booking",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.whit)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 40,
                      child: const CircularProgressIndicator(
                        color: AppColors.AppbtnColor,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
