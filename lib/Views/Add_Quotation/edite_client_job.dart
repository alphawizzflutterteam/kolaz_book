import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kolazz_book/Models/Type_of_photography_model.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Models/get_client_jobs_model.dart';
import 'package:kolazz_book/Models/photographer_list_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Models/event_type_model.dart';
import '../../Utils/colors.dart';
import '../Jobs/jobs_screen.dart';
import 'package:http/http.dart' as http;

class EditClientJob extends StatefulWidget {
  final AllJobs? allJobs;
  final bool? type;
  final UpcomingJobs? upcomingJobs;
  const EditClientJob({Key? key, this.allJobs, this.type, this.upcomingJobs}) : super(key: key);

  @override
  State<EditClientJob> createState() => _EditClientJobState();
}

class _EditClientJobState extends State<EditClientJob> {

  List pType = [];
  List newList = [];
  int typeIndex = 0 ;
  List photographer =[];
  List photographerIds = [];
  TextEditingController clientNameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController outputController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  List<String> selectedvlaue = [];

  String? SelectedGender;
  String? dropdownValue;
  String? qid;
  List<JobData> quotationData = [];
  List<EventType> eventList = [];
  List<CityList> citiesList = [];
  List<Data> photographersList = [];
  var eventController;
  var cityController;
  var photographerType;
  int dateIndex = 0 ;
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
    // selectedEvents = selectedvlaue.join(',');

    print("__________________${selectedvlaue}");

    // print('________this____is__________stringlist${selectedEvents}');
  }

  List<Categories> typeofPhotographyEvent = [];

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

  deleteConfirmation(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      title: const Text(
        'Delete Client Job!',
        style: TextStyle(color: AppColors.textclr),
      ),
      content: const Text(
        'Are you sure you want to delete this clients job?',
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
            deleteQuotation(context);
            Navigator.of(context).pop(true);

          },
        ),
      ],
    );
  }

  deleteQuotation( BuildContext context) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();ff
    // String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(deleteQuotationApi.toString()));
    request.fields.addAll({
      'id': widget.type == true ?
        widget.allJobs!.id.toString()
    : widget.upcomingJobs!.id.toString()
    });
    print("this is delete quotation request ${request.fields.toString()} and $deleteQuotationApi");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseData =
      await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (userData['error'] == false) {
        Fluttertoast.showToast(msg: userData['message']);
        Navigator.pop(context, false);

      } else {
        Fluttertoast.showToast(msg: userData['message']);
        // Fluttertoast.showToast(msg: userData['msg']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }


  Widget photographerDropdownCard(int j){
    var photographerName;
    var pId;
    if (photographer.length < j + 1) {
      photographer.add(photographerName);
      photographerIds.add(pId);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(
            left: 10, top: 5),
        decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(0),
            color: AppColors.datecontainer),
        width:
        MediaQuery.of(context).size.width /
            2.6,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            dropdownColor: AppColors.cardclr,
            // Initial Value
            value: photographer[j],
            isExpanded: true,
            hint: const Text(
              "Photographer",
              style: TextStyle(
                  color: AppColors.textclr),
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
                  items.firstName.toString(),
                  style: const TextStyle(
                      color: AppColors.textclr),
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (newValue) {
              print("this is new value $newValue");
              setState(() {
                photographer[j] = newValue!;

                // widget.allJobs!.photographersDetails![dateIndex].data![j].photographerName = photographer[j];
              });
              pType.add({
                "photographer_type":
              widget.type == true ?   widget.allJobs!.photographersDetails![dateIndex].data![j].photographerType
                :  widget.upcomingJobs!.photographersDetails![dateIndex].data![j].photographerType,
                "photographer_id": photographer[j]
              });
              print("this is my new response $pType");
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
    );
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
    });

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

  updateClientJob() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
    };

    var request =
    http.MultipartRequest('POST', Uri.parse(updateClientJobApi.toString()));
    request.fields.addAll({
      'client_name': clientNameController.text.toString(),
      'city': cityNameController.text.toString(),
      'mobile': mobileController.text.toString(),
      'type_event': eventController.toString(),
      'output': outputController.text.toString(),
      'amount': amountController.text.toString(),
      'id': widget.type == true ? widget.allJobs!.id.toString()
    : widget.upcomingJobs!.id.toString(),
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




  @override
  void initState() {
    super.initState();
    // getClientJobs();
    getCitiesList();
    getPhotographerType();
    getEventTypes();
    getPhotographerList();
    if(widget.type == true) {
      setState(() {
        clientNameController.text = widget.allJobs!.clientName.toString();
        cityNameController.text = widget.allJobs!.city.toString();
        eventController = widget.allJobs!.typeEvent.toString();
        amountController.text = widget.allJobs!.amount.toString();
        outputController.text = widget.allJobs!.output.toString();
      });
    }else{
      setState(() {
        clientNameController.text = widget.upcomingJobs!.clientName.toString();
        cityController = widget.upcomingJobs!.city.toString();
        cityNameController.text = widget.upcomingJobs!.city.toString();
        eventController = widget.upcomingJobs!.typeEvent.toString();
        amountController.text = widget.upcomingJobs!.amount.toString();
        outputController.text = widget.upcomingJobs!.output.toString();
      });
    }
  }

  // getClientJobs() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   String? id = preferences.getString('id');
  //   var uri =
  //   Uri.parse(getClientJobsApi.toString());
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
  //     result = GetClientJobsModel.fromJson(userData).data!;
  //     quotationData = result.setting!;
  //     clientNameController.text = quotationData[0].toString();
  //     cityController = quotationData[0].city.toString();
  //     eventController = quotationData[0].typeEvent.toString();
  //     amountController.text = quotationData[0].amount.toString();
  //     outputController.text = quotationData[0].output.toString();
  //   });
  // }

  // createClientJob() async {
  //   // SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // String? userId = preferences.getString('id');
  //   var uri = Uri.parse(createClientJobApi.toString());
  //
  //   var request = http.MultipartRequest("POST", uri);
  //   Map<String, String> headers = {
  //     "Accept": "application/json",
  //   };
  //   request.fields.addAll({
  //     // 'user_id': userId.toString(),
  //     // 'type': 'client',
  //     'id': widget.qid.toString(),
  //   });
  //   request.headers.addAll(headers);
  //   // request.fields['user_id'] = userId.toString();
  //   // request.fields['type'] = 'photographer';
  //   print("this is my quotation Details  ${request.fields.toString()}");
  //   var response = await request.send();
  //   print(response.statusCode);
  //   String responseData = await response.stream.transform(utf8.decoder).join();
  //   var userData = json.decode(responseData);
  //   Fluttertoast.showToast(msg: userData['message']);
  //   Navigator.pop(context);
  //   Navigator.pop(context, true);
  // }
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
              child: Text("Edit Client Job",
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.AppbtnColor,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body:
      widget.type! ?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
        child: SingleChildScrollView(
          child:
          widget.allJobs != null ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
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
                          const  Text(
                            "Auto CF ID",
                            style: TextStyle(
                                color: Color(0xff42ACFE),
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.1,
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
                                    widget.type == true?
                                    widget.allJobs!.qid.toString()
                                        : widget.upcomingJobs!.qid.toString(),
                                    // quotationData![0].qid.toString(),
                                    style: TextStyle(color: AppColors.whit),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const  Text(
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
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: TextFormField(
                                style:
                                const TextStyle(color: AppColors.textclr),
                                controller: clientNameController,
                                keyboardType: TextInputType.name,
                                validator: (value) => value!.isEmpty
                                    ? 'Client Name cannot be blank'
                                    : null,
                                decoration: const InputDecoration(
                                    hintText: 'Enter Client Name',
                                    hintStyle: TextStyle(
                                        color: AppColors.textclr, fontSize: 14),
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 8, bottom: 12)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                              // padding: EdgeInsets.only(left: 5, top: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.containerclr2),
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: TextFormField(
                                style:
                                const TextStyle(color: AppColors.textclr),
                                controller: cityNameController,
                                keyboardType: TextInputType.name,
                                validator: (value) => value!.isEmpty
                                    ? 'City/Venue cannot be blank'
                                    : null,
                                decoration: const InputDecoration(
                                    hintText: 'Enter City Name',
                                    hintStyle: TextStyle(
                                        color: AppColors.textclr, fontSize: 14),
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 8, top: 5)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  dropdownColor: AppColors.cardclr,
                                  // Initial Value
                                  value: eventController,
                                  isExpanded: true,
                                  hint: const Text(
                                    "Event",
                                    style: TextStyle(color: AppColors.textclr),
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

              // quotationData.isNotEmpty
              Row(
                children: [
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                        widget.allJobs!.photographersDetails!.length,
                        itemBuilder: (context, j) {
                          return InkWell(
                            onTap: () {
                              dateIndex = j;
                              setState(() {});
                            },
                            child: Container(
                              width: 110,
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
                                    widget.allJobs!.photographersDetails![dateIndex].date.toString(),
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                        color: AppColors.textclr),
                                  ),
                                ),
                              ),
                            ),
                          );
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
                        // selectDate(context, 1);
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
                  // : SizedBox.shrink(),
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
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding:  EdgeInsets.only(bottom: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Type Of Photographer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textclr,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                widget.allJobs!.photographersDetails!.isNotEmpty ?
                                Container(
                                  width: MediaQuery.of(context).size.width /2.3,
                                  height: 200,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // scrollDirection: Axis.horizontal,
                                      itemCount: widget.allJobs!.photographersDetails![dateIndex].data!.length,
                                      itemBuilder: (context, j) {
                                        typeIndex = j;
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child:   Container(
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
                                                value: photographerType,
                                                // typeofPhotographyEvent[j].selectedValue,
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
                                                  // selectValue(newValue ?? Categories(), j);

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width/2.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const  Padding(
                                  padding:  EdgeInsets.only(bottom: 6.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Select Photographer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textclr,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                widget.allJobs!.photographersDetails!.isNotEmpty ?
                                Container(
                                  width: MediaQuery.of(context).size.width /2.3,
                                  height: 200,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // scrollDirection: Axis.horizontal,
                                      itemCount: widget.allJobs!.photographersDetails![dateIndex].data!.length,
                                      itemBuilder: (context, j) {
                                        return photographerDropdownCard(j);
                                      }),
                                )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              ///OLD edit freelancer job
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/2.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding:  EdgeInsets.only(bottom: 8.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Type Of Photographer",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textclr,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          widget.allJobs!.photographersDetails!.isNotEmpty ?
                          Container(
                            width: MediaQuery.of(context).size.width /2.3,
                            height: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                // scrollDirection: Axis.horizontal,
                                itemCount: widget.allJobs!.photographersDetails![dateIndex].data!.length,
                                itemBuilder: (context, j) {
                                  typeIndex = j;
                                  photographerType = widget.upcomingJobs!.photographersDetails![dateIndex].data![j].photographerType;
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child:   Container(
                                      height: 40,
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
                                          items: typeofPhotographyEvent
                                              .map((Categories items) {
                                            return DropdownMenuItem(
                                              value: items.resName,
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
                                            // selectValue(newValue ?? Categories(), j);

                                            setState(() {});
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      width: MediaQuery.of(context).size.width/2.4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const  Padding(
                            padding:  EdgeInsets.only(bottom: 6.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Select Photographer",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textclr,
                                    fontSize: 14),
                              ),
                            ),
                          ),
                          widget.allJobs!.photographersDetails!.isNotEmpty ?
                          Container(
                            width: MediaQuery.of(context).size.width /2.3,
                            height: 200,
                            child: ListView.builder(
                                shrinkWrap: true,
                                // scrollDirection: Axis.horizontal,
                                itemCount: widget.allJobs!.photographersDetails![dateIndex].data!.length,
                                itemBuilder: (context, j) {
                                  return photographerDropdownCard(j);
                                }),
                          )
                              : const SizedBox.shrink(),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //       ///ADD PHOTOGRAPHER TYPE BUTTON
              //       // Align(
              //       //   alignment: Alignment.center,
              //       //   child: Text(
              //       //     "(For Developer User Can Hold/Or To Delete This Row)",
              //       //     style: TextStyle(
              //       //         fontStyle: FontStyle.italic,
              //       //         color: AppColors.textclr,
              //       //         fontSize: 13),
              //       //   ),
              //       // ),
              //       // SizedBox(
              //       //   height: 10,
              //       // ),
              //       // Padding(
              //       //   padding: const EdgeInsets.all(5.0),
              //       //   child: Icon(
              //       //     Icons.add_circle_outline,
              //       //     color: AppColors.temtextclr,
              //       //     size: 30,
              //       //   ),
              //       // ),
              //       // Text(
              //       //   "Add Type Of Photographer",
              //       //   style: TextStyle(
              //       //       color: AppColors.temtextclr,
              //       //       fontSize: 16,
              //       //       fontWeight: FontWeight.bold),
              //       // ),
              //       // SizedBox(
              //       //   height: 20,
              //       // ),
              //       ///ADD PHOTOGRAPHER TYPE BUTTON
              //     ],
              //   ),
              // ),
              ///OLD edit freelancer job
              const  SizedBox(
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


                          style: const TextStyle(color: AppColors.textclr,fontSize: 14),
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
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const  Text(
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

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     InkWell(
              //       onTap: (){
              //         newList.add(
              //             jsonEncode({"date": widget.type == true? widget.allJobs!.photographersDetails![dateIndex].date.toString()
              //                 :  widget.upcomingJobs!.photographersDetails![dateIndex].date.toString()
              //               , "data": pType}));
              //         updateClientJob();
              //         print("this is new list $newList");
              //       },
              //       child: Container(
              //         height: 50,
              //         width: 150,
              //         decoration: BoxDecoration(
              //             color: AppColors.AppbtnColor,
              //             borderRadius: BorderRadius.circular(5)),
              //         child: Center(
              //             child: Text(
              //               "Update",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: AppColors.textclr,
              //                   fontSize: 18),
              //             )),
              //       ),
              //     ),
              //     Image.asset(
              //       "assets/images/pdf.png",
              //       scale: 1.6,
              //     ),
              //     InkWell(
              //       onTap: () async {
              //         await showDialog(
              //             context: context,
              //             builder: (context) {
              //               return
              //                 deleteConfirmation(context);
              //               }
              //         );
              //       },
              //       child: Container(
              //         height: 50,
              //         width: 100,
              //         decoration: BoxDecoration(
              //             color: AppColors.contaccontainerred,
              //             borderRadius: BorderRadius.circular(5)),
              //         child: const Center(
              //             child: Text(
              //               "Delete",
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: AppColors.textclr,
              //                   fontSize: 18),
              //             )),
              //       ),
              //     ),
              //   ],
              // ),


              const  SizedBox(
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
      )
          : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 0),
        child: SingleChildScrollView(
          child:
          widget.upcomingJobs != null ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
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
                          const  Text(
                            "Auto CF ID",
                            style: TextStyle(
                                color: Color(0xff42ACFE),
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.1,
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
                                    widget.upcomingJobs!.qid.toString(),
                                    // quotationData![0].qid.toString(),
                                    style: TextStyle(color: AppColors.whit),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const  Text(
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
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: TextFormField(
                                style:
                                const TextStyle(color: AppColors.textclr),
                                controller: clientNameController,
                                keyboardType: TextInputType.name,
                                validator: (value) => value!.isEmpty
                                    ? 'Client Name cannot be blank'
                                    : null,
                                decoration: const InputDecoration(
                                    hintText: 'Enter Client Name',
                                    hintStyle: TextStyle(
                                        color: AppColors.textclr, fontSize: 14),
                                    border: InputBorder.none,
                                    contentPadding:
                                    EdgeInsets.only(left: 8, bottom: 12)),
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
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                              width: MediaQuery.of(context).size.width / 2.1,
                              child:
                              // DropdownButtonHideUnderline(
                              //   child: DropdownButton(
                              //     dropdownColor: AppColors.cardclr,
                              //     // Initial Value
                              //     value: cityController,
                              //     isExpanded: true,
                              //     hint: const Text(
                              //       "City",
                              //       style: TextStyle(color: AppColors.textclr),
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
                                style:
                                const TextStyle(color: AppColors.textclr),
                                controller: cityNameController,
                                keyboardType: TextInputType.name,
                                validator: (value) => value!.isEmpty
                                    ? ' City cannot be blank'
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
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
                              width: MediaQuery.of(context).size.width / 2.1,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  dropdownColor: AppColors.cardclr,
                                  // Initial Value
                                  value: eventController,
                                  isExpanded: true,
                                  hint: const Text(
                                    "Event",
                                    style: TextStyle(color: AppColors.textclr),
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
              const  SizedBox(
                height: 20,
              ),
              // quotationData.isNotEmpty ?
              Row(
                children: [
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.upcomingJobs!.photographersDetails!.length,
                        itemBuilder: (context, j) {
                          return InkWell(
                            onTap: () {
                              dateIndex = j;
                              setState(() {});
                            },
                            child: Container(
                              width: 110,
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
                                    widget.upcomingJobs!.photographersDetails![j].date.toString(),
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                        color: AppColors.textclr),
                                  ),
                                ),
                              ),
                            ),
                          );
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
                        // selectDate(context, 1);
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
                  // : SizedBox.shrink(),
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
                      child: Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/2.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding:  EdgeInsets.only(bottom: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Type Of Photographer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textclr,
                                          fontSize: 12),
                                    ),
                                  ),
                                ),
                                widget.upcomingJobs!.photographersDetails!.isNotEmpty ?
                                Container(
                                  width: MediaQuery.of(context).size.width /2.3,
                                  height: 200,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // scrollDirection: Axis.horizontal,
                                      itemCount: widget.upcomingJobs!.photographersDetails![dateIndex].data!.length,
                                      itemBuilder: (context, j) {
                                        typeIndex = j;
                                        photographerType = widget.upcomingJobs!.photographersDetails![dateIndex].data![j].photographerType;
                                        return Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child:   Container(
                                            height: 40,
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
                                                items: typeofPhotographyEvent
                                                    .map((Categories items) {
                                                  return DropdownMenuItem(
                                                    value: items.resName,
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
                                                  // selectValue(newValue ?? Categories(), j);

                                                  setState(() {});
                                                },
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width/2.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const  Padding(
                                  padding:  EdgeInsets.only(bottom: 6.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Select Photographer",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textclr,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                                widget.upcomingJobs!.photographersDetails!.isNotEmpty ?
                                Container(
                                  width: MediaQuery.of(context).size.width /2.3,
                                  height: 200,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // scrollDirection: Axis.horizontal,
                                      itemCount: widget.upcomingJobs!.photographersDetails![dateIndex].data!.length,
                                      itemBuilder: (context, j) {
                                        return photographerDropdownCard(j);
                                      }),
                                )
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
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
              // Container(
              //   height: 45,
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: widget.upcomingJobs!.photographersDetails!.length,
              //       itemBuilder: (context, j) {
              //         return InkWell(
              //           onTap: (){
              //             dateIndex = j ;
              //             setState(() {
              //               newList.add(
              //                   jsonEncode({"date": widget.type == true? widget.allJobs!.photographersDetails![dateIndex].date.toString()
              //                       :  widget.upcomingJobs!.photographersDetails![dateIndex].date.toString(), "data": pType}));
              //               pType.clear();
              //
              //               print("this is new list $newList");
              //             });
              //           },
              //           child: Container(
              //             width: 100,
              //             decoration: const BoxDecoration(
              //               borderRadius: BorderRadius.only(
              //                   topRight: Radius.circular(8),
              //                   topLeft: Radius.circular(8)),
              //               color: AppColors.teamcard2,
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 8.0, vertical: 8),
              //               child: Container(
              //                 padding: const EdgeInsets.symmetric(
              //                     horizontal: 8, vertical: 5),
              //                 decoration: const BoxDecoration(
              //                   color: AppColors.datecontainer,
              //                 ),
              //                 child: Text(
              //                   widget.upcomingJobs!.photographersDetails![dateIndex].date.toString(),
              //                   overflow: TextOverflow.fade,
              //                   style: const TextStyle(color: AppColors.textclr),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       }),
              // ),
              // quotationData.isNotEmpty ?
              // Container(
              //   height: 45,
              //   child: ListView.builder(
              //       shrinkWrap: true,
              //       scrollDirection: Axis.horizontal,
              //       itemCount: widget.type == true ?
              //       widget.allJobs!.photographersDetails!.length
              //     :  widget.upcomingJobs!.photographersDetails!.length,
              //       itemBuilder: (context, j) {
              //         return InkWell(
              //           onTap: (){
              //             // dateIndex = j ;
              //             // setState(() {
              //             // });
              //           },
              //           child: Container(
              //             width: 100,
              //             decoration: const BoxDecoration(
              //               borderRadius: BorderRadius.only(
              //                   topRight: Radius.circular(8),
              //                   topLeft: Radius.circular(8)),
              //               color: AppColors.teamcard2,
              //             ),
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(
              //                   horizontal: 8.0, vertical: 8),
              //               child: Container(
              //                 padding: const EdgeInsets.symmetric(
              //                     horizontal: 8, vertical: 5),
              //                 decoration: const BoxDecoration(
              //                   color: AppColors.datecontainer,
              //                 ),
              //                 child: Text(
              //                   widget.type == true ?
              //                   widget.allJobs!.photographersDetails![j].date.toString()
              //                  : widget.upcomingJobs!.photographersDetails![j].date.toString(),
              //                   overflow: TextOverflow.fade,
              //                   style: const TextStyle(color: AppColors.textclr),
              //                 ),
              //               ),
              //             ),
              //           ),
              //         );
              //       }),
              // )
              //     : SizedBox.shrink(),
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
              //
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
              // Container(
              //   decoration: const BoxDecoration(
              //       color: AppColors.teamcard2,
              //       borderRadius: BorderRadius.only(
              //           topRight: Radius.circular(10),
              //           bottomRight: Radius.circular(10),
              //           bottomLeft: Radius.circular(10))),
              //   child: Column(
              //     children: [
              //       // const Align(
              //       //   alignment: Alignment.topRight,
              //       //   child: Text(
              //       //     "(For Developer User Can Hold/Or To Delete This Row)",
              //       //     style: TextStyle(
              //       //         fontStyle: FontStyle.italic,
              //       //         color: AppColors.textclr,
              //       //         fontSize: 12),
              //       //   ),
              //       // ),
              //       const SizedBox(
              //         height: 10,
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.symmetric(
              //             horizontal: 8.0, vertical: 8),
              //         child: Row(
              //           children: [
              //             Container(
              //               width: MediaQuery.of(context).size.width/2.4,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.only(bottom: 8.0),
              //                     child: Align(
              //                       alignment: Alignment.topLeft,
              //                       child: Text(
              //                         "Type Of Photographer",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.w500,
              //                             color: AppColors.textclr,
              //                             fontSize: 12),
              //                       ),
              //                     ),
              //                   ),
              //                   Container(
              //                     width: MediaQuery.of(context).size.width /2.3,
              //                     height: 200,
              //                     child: ListView.builder(
              //                         shrinkWrap: true,
              //                         // scrollDirection: Axis.horizontal,
              //                         itemCount: widget.type == true ?
              //                         widget.allJobs!.photographersDetails![dateIndex].data!.length
              //                         : widget.upcomingJobs!.photographersDetails![dateIndex].data!.length,
              //                         itemBuilder: (context, j) {
              //                           return Padding(
              //                             padding: const EdgeInsets.only(top: 8.0),
              //                             child: Container(
              //                                 height: 35,
              //                                 padding: const EdgeInsets.only(
              //                                     left: 10, top: 5),
              //                                 decoration: BoxDecoration(
              //                                     borderRadius:
              //                                     BorderRadius.circular(0),
              //                                     color: AppColors.datecontainer),
              //                                 width:
              //                                 MediaQuery.of(context).size.width /
              //                                     2.6,
              //                                 child: Text(widget.upcomingJobs!.photographersDetails![dateIndex].data![j].photographerType.toString(),
              //                                   style: const TextStyle(
              //                                       fontSize: 14,
              //                                       color: AppColors.AppbtnColor,
              //                                       fontWeight: FontWeight.w400),)
              //                               // DropdownButtonHideUnderline(
              //                               //   child: DropdownButton<String>(
              //                               //     value: dropdownValue,
              //                               //     hint: Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
              //                               //     icon: const Icon(Icons.keyboard_arrow_down_rounded,
              //                               //       color: Colors.white,),
              //                               //     elevation: 16,
              //                               //     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
              //                               //     underline: Container(
              //                               //       // height: 2,
              //                               //       color: Colors.black54,
              //                               //     ),
              //                               //     onChanged: (String? value) {
              //                               //       // This is called when the user selects an item.
              //                               //       setState(() {
              //                               //         dropdownValue = value!;
              //                               //       });
              //                               //     },
              //                               //     items: items
              //                               //         .map<DropdownMenuItem<String>>((String value) {
              //                               //       return DropdownMenuItem<String>(
              //                               //         value: value,
              //                               //         child: Text(value),
              //                               //       );
              //                               //     }).toList(),
              //                               //   ),
              //                               // ),
              //                             ),
              //                           );
              //                         }),
              //                   ),
              //                   //     : const SizedBox.shrink()
              //                   // : SizedBox.shrink(),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             const SizedBox(width: 10,),
              //             Container(
              //               width: MediaQuery.of(context).size.width/2.4,
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Padding(
              //                     padding: const EdgeInsets.only(bottom: 6.0),
              //                     child: Align(
              //                       alignment: Alignment.topLeft,
              //                       child: Text(
              //                         "Select Photographer",
              //                         style: TextStyle(
              //                             fontWeight: FontWeight.w500,
              //                             color: AppColors.textclr,
              //                             fontSize: 14),
              //                       ),
              //                     ),
              //                   ),
              //                   widget.upcomingJobs!.photographersDetails!.isNotEmpty ?
              //                   Container(
              //                     width: MediaQuery.of(context).size.width /2.3,
              //                     height: 200,
              //                     child: ListView.builder(
              //                         shrinkWrap: true,
              //                         // scrollDirection: Axis.horizontal,
              //                         itemCount: widget.upcomingJobs!.photographersDetails![dateIndex].data!.length,
              //                         itemBuilder: (context, j) {
              //                           return photographerDropdownCard(j);
              //                         }),
              //                   )
              //                       : const SizedBox.shrink(),
              //                   const SizedBox(
              //                     height: 10,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //       ///ADD PHOTOGRAPHER TYPE BUTTON
              //       // Align(
              //       //   alignment: Alignment.center,
              //       //   child: Text(
              //       //     "(For Developer User Can Hold/Or To Delete This Row)",
              //       //     style: TextStyle(
              //       //         fontStyle: FontStyle.italic,
              //       //         color: AppColors.textclr,
              //       //         fontSize: 13),
              //       //   ),
              //       // ),
              //       // SizedBox(
              //       //   height: 10,
              //       // ),
              //       // Padding(
              //       //   padding: const EdgeInsets.all(5.0),
              //       //   child: Icon(
              //       //     Icons.add_circle_outline,
              //       //     color: AppColors.temtextclr,
              //       //     size: 30,
              //       //   ),
              //       // ),
              //       // Text(
              //       //   "Add Type Of Photographer",
              //       //   style: TextStyle(
              //       //       color: AppColors.temtextclr,
              //       //       fontSize: 16,
              //       //       fontWeight: FontWeight.bold),
              //       // ),
              //       // SizedBox(
              //       //   height: 20,
              //       // ),
              //       ///ADD PHOTOGRAPHER TYPE BUTTON
              //     ],
              //   ),
              // ),
              const  SizedBox(
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


                          style: const TextStyle(color: AppColors.textclr,fontSize: 14),
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
              const SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    const  Text(
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
                    onTap: (){
                      newList.add(
                          jsonEncode({"date": widget.type == true? widget.allJobs!.photographersDetails![dateIndex].date.toString()
                              :  widget.upcomingJobs!.photographersDetails![dateIndex].date.toString()
                            , "data": pType}));
                      updateClientJob();
                      print("this is new list $newList");
                    },
                    child: Container(
                      height: 35,
                      width: 150,
                      decoration: BoxDecoration(
                          color: AppColors.AppbtnColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                          child: Text(
                            "Update",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textclr,
                                fontSize: 18),
                          )),
                    ),
                  ),
                  Image.asset(
                    "assets/images/pdf.png",
                    scale: 1.6,
                  ),
                  InkWell(
                    onTap: () async {

                      await showDialog(
                          context: context,
                          builder: (context) {
                            return
                              deleteConfirmation(context);}
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                          color: AppColors.contaccontainerred,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
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


              const  SizedBox(
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



// String? SelectedGender;
//   String? dropdownValue;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.back,
//       appBar: AppBar(
//         leading: GestureDetector(
//             onTap: (){
//               Navigator.pop(context);
//             },
//             child: Icon(Icons.arrow_back_ios, color:AppColors.AppbtnColor,)),
//         backgroundColor:AppColors.secondary ,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(15),
//             child: Center(child: Text("Edit Client Job",
//                 style: TextStyle(fontSize: 16, color:AppColors.AppbtnColor, fontWeight: FontWeight.bold)
//             ),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               // Container(
//               //   decoration: BoxDecoration(
//               //       color: AppColors.teamcard2,
//               //       borderRadius: BorderRadius.circular(10)),
//               //   child: Padding(
//               //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
//               //     child: Column(
//               //       children: [
//               //         Row(
//               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //           children: [
//               //
//               //             const Text("Auto Q ID",style: TextStyle(color: AppColors.pdfbtn),),
//               //             Padding(
//               //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
//               //               child: Container(
//               //
//               //                 decoration: BoxDecoration(
//               //                     borderRadius: BorderRadius.circular(10),
//               //                     color: AppColors.containerclr2),
//               //                 padding: EdgeInsets.symmetric(vertical: 5),
//               //                 width: MediaQuery.of(context).size.width/2.1,
//               //                 child: const Padding(
//               //                   padding: EdgeInsets.all(10.0),
//               //                   child: Text("Q001",style: TextStyle(color: AppColors.textclr),),
//               //                 ),),
//               //             )
//               //           ],
//               //         ),
//               //         Row(
//               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //           children: [
//               //             const Text("Client Name",style: TextStyle(color: AppColors.pdfbtn),),
//               //             Padding(
//               //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
//               //               child: Container(
//               //
//               //                 decoration: BoxDecoration(
//               //                     borderRadius: BorderRadius.circular(10),
//               //                     color: AppColors.containerclr2),
//               //                 padding: EdgeInsets.symmetric(vertical: 5),
//               //                 width: MediaQuery.of(context).size.width/2.1,
//               //                 child: const Padding(
//               //                   padding: EdgeInsets.all(10.0),
//               //                   child: Text("Kinjal Patel",style: TextStyle(color: AppColors.textclr),),
//               //                 ),),
//               //             )
//               //
//               //           ],
//               //         ) ,
//               //         Row(
//               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //           children: [
//               //             Text("City/Venue",style: TextStyle(color: AppColors.pdfbtn),),
//               //             Padding(
//               //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
//               //               child: Container(
//               //
//               //                 decoration: BoxDecoration(
//               //                     borderRadius: BorderRadius.circular(10),
//               //                     color: AppColors.containerclr2),
//               //                 padding: EdgeInsets.symmetric(vertical: 5),
//               //                 width: MediaQuery.of(context).size.width/2.1,
//               //                 child: const Padding(
//               //                   padding: EdgeInsets.all(10.0),
//               //                   child: Text("Kanpur",style: TextStyle(color: AppColors.textclr),),
//               //                 ),),
//               //             )
//               //
//               //           ],
//               //         ),
//               //         Row(
//               //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //           children: [
//               //             Text("Event",style: TextStyle(color: AppColors.pdfbtn),),
//               //             Padding(
//               //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
//               //               child: Container(
//               //
//               //                 decoration: BoxDecoration(
//               //                     borderRadius: BorderRadius.circular(10),
//               //                     color: AppColors.containerclr2),
//               //                 padding: EdgeInsets.symmetric(vertical: 5),
//               //                 width: MediaQuery.of(context).size.width/2.1,
//               //                 child: const Padding(
//               //                   padding: EdgeInsets.all(10.0),
//               //                   child: Text("Wedding",style: TextStyle(color: AppColors.textclr),),
//               //                 ),),
//               //             )
//               //
//               //           ],
//               //         )
//               //       ],
//               //     ),
//               //   ),
//               // ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Color(0xff3B3B3B),
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Auto CF ID",
//                             style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
//                           Container(width:180,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: AppColors.backgruond,
//                             ),
//
//                             child: Align(alignment: Alignment.centerLeft, child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text("FJ001",style: TextStyle(color: AppColors.whit),),
//                             )),)
//                         ],
//                       ),
//
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Client Name",
//                             style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
//                           Container(
//                             width:180,
//                             height: 35,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: AppColors.backgruond,
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 elevation: 0,
//                                 underline: Container(),
//                                 isExpanded: true,
//                                 value: _chosenValue,
//                                 icon: Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
//                                 hint: Align(alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text("Kaushik Prajapati", style: TextStyle(
//                                         color:AppColors.whit
//                                     ),),
//                                   ),
//                                 ),
//                                 items:item.map((String items) {
//                                   return DropdownMenuItem(
//                                       value: items,
//                                       child: Text(items)
//                                   );
//                                 }
//                                 ).toList(),
//                                 onChanged: (String? newValue){
//                                   setState(() {
//                                     _chosenValue = newValue!;
//                                   });
//                                 },
//
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("City/Venue",
//                             style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
//                           Container(width:180,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: AppColors.backgruond,
//                             ),
//
//                             child: Align(alignment: Alignment.centerLeft, child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text("Mumbai",style: TextStyle(color: AppColors.whit),),
//                             )),)
//                         ],
//                       ),
//
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Events",
//                             style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
//                           Container(
//                             width:180,
//                             height: 30,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(8),
//                               color: AppColors.backgruond,
//                             ),
//                             child: DropdownButtonHideUnderline(
//                               child: DropdownButton(
//                                 elevation: 0,
//                                 underline: Container(),
//                                 isExpanded: true,
//                                 value: _cityValue,
//                                 icon: Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
//                                 hint: Align(alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text("Wedding", style: TextStyle(
//                                         color:AppColors.whit
//                                     ),),
//                                   ),
//                                 ),
//                                 items:item2.map((String items) {
//                                   return DropdownMenuItem(
//                                       value: items,
//                                       child: Text(items)
//                                   );
//                                 }
//                                 ).toList(),
//                                 onChanged: (String? newValue){
//                                   setState(() {
//                                     _cityValue = newValue!;
//                                   });
//                                 },
//
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//
//               Row(
//                 children: [
//                 Container(decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
//                   color: AppColors.teamcard2,
//                 ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
//                       decoration: BoxDecoration(
//                         color:AppColors.datecontainer,
//
//                       ),
//                       child: Text("22/2/2023",style: TextStyle(color: AppColors.textclr),),
//                     ),
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.zero,
//
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
//                     color: AppColors.teamcard2,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
//                       decoration: BoxDecoration(
//                         color:AppColors.datecontainer,
//
//                       ),
//                       child: Text("22/2/2023",style: TextStyle(color: AppColors.textclr),),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Icon(Icons.add_circle_outline,color: AppColors.temtextclr,size: 30,),
//                 ),
//                 Text("Add Date",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),)
//
//               ],),
//               Container(
//                 decoration: BoxDecoration(
//                     color: AppColors.teamcard2,
//                     borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
//                 ),
//                 child: Column(
//                   children: [
//                     Align(
//                       alignment: Alignment.topRight,
//
//                       child: Text("(For Developer User Can Hold/Or To Delete This Row)",style: TextStyle(fontStyle: FontStyle.italic,color: AppColors.textclr,fontSize: 12),),
//                     ),
//                     SizedBox(height: 10,),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(bottom: 8.0),
//                             child: Row(
//                               children: [
//                                 Text("Type Of Photographer",style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.textclr,fontSize: 15),),
//                                 SizedBox(width: 65,),
//                                 Text("Select Photographer",style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.textclr,fontSize: 15),),
//                               ],
//                             ),
//                           ),
//                           Row(
//                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(0),
//                                     color: AppColors.datecontainer),
//                                 width: MediaQuery.of(context).size.width/2.1,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue,
//                                     hint:Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
//                                     icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                                       color: Colors.white,),
//                                     elevation: 16,
//                                     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                     underline: Container(
//                                       // height: 2,
//                                       color: Colors.black54,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         dropdownValue = value!;
//                                       });
//                                     },
//                                     items: items
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 5,),
//                               Container(
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(0),
//                                     color: AppColors.datecontainer),
//                                 width: MediaQuery.of(context).size.width/2.6,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue,
//                                     hint:Text(" ",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
//                                     icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                                       color: Colors.white,),
//                                     elevation: 16,
//                                     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                     underline: Container(
//                                       // height: 2,
//                                       color: Colors.black54,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         dropdownValue = value!;
//                                       });
//                                     },
//                                     items: items
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                           SizedBox(height: 10,),
//                           Row(
//                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(0),
//                                     color: AppColors.datecontainer),
//                                 width: MediaQuery.of(context).size.width/2.1,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue,
//                                     hint:Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
//                                     icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                                       color: Colors.white,),
//                                     elevation: 16,
//                                     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                     underline: Container(
//                                       // height: 2,
//                                       color: Colors.black54,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         dropdownValue = value!;
//                                       });
//                                     },
//                                     items: items
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 5,),
//                               Container(
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(0),
//                                     color: AppColors.datecontainer),
//                                 width: MediaQuery.of(context).size.width/2.6,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue,
//                                     hint:Text(" ",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
//                                     icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                                       color: Colors.white,),
//                                     elevation: 16,
//                                     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                     underline: Container(
//                                       // height: 2,
//                                       color: Colors.black54,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         dropdownValue = value!;
//                                       });
//                                     },
//                                     items: items
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                           SizedBox(height: 10,),
//                           Row(
//                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(0),
//                                     color: AppColors.datecontainer),
//                                 width: MediaQuery.of(context).size.width/2.1,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue,
//                                     hint:Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
//                                     icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                                       color: Colors.white,),
//                                     elevation: 16,
//                                     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                     underline: Container(
//                                       // height: 2,
//                                       color: Colors.black54,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         dropdownValue = value!;
//                                       });
//                                     },
//                                     items: items
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 5,),
//                               Container(
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(0),
//                                     color: AppColors.datecontainer),
//                                 width: MediaQuery.of(context).size.width/2.6,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue,
//                                     hint:Text(" ",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
//                                     icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                                       color: Colors.white,),
//                                     elevation: 16,
//                                     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                     underline: Container(
//                                       // height: 2,
//                                       color: Colors.black54,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         dropdownValue = value!;
//                                       });
//                                     },
//                                     items: items
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                           SizedBox(height: 10,),
//                           Row(
//                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(0),
//                                     color: AppColors.datecontainer),
//                                 width: MediaQuery.of(context).size.width/2.1,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue,
//                                     hint:Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
//                                     icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                                       color: Colors.white,),
//                                     elevation: 16,
//                                     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                     underline: Container(
//                                       // height: 2,
//                                       color: Colors.black54,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         dropdownValue = value!;
//                                       });
//                                     },
//                                     items: items
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 5,),
//                               Container(
//                                 height: 30,
//                                 padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(0),
//                                     color: AppColors.datecontainer),
//                                 width: MediaQuery.of(context).size.width/2.6,
//                                 child: DropdownButtonHideUnderline(
//                                   child: DropdownButton<String>(
//                                     value: dropdownValue,
//                                     hint:Text(" ",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
//                                     icon: const Icon(Icons.keyboard_arrow_down_rounded,
//                                       color: Colors.white,),
//                                     elevation: 16,
//                                     style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
//                                     underline: Container(
//                                       // height: 2,
//                                       color: Colors.black54,
//                                     ),
//                                     onChanged: (String? value) {
//                                       // This is called when the user selects an item.
//                                       setState(() {
//                                         dropdownValue = value!;
//                                       });
//                                     },
//                                     items: items
//                                         .map<DropdownMenuItem<String>>((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(value),
//                                       );
//                                     }).toList(),
//                                   ),
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//
//                       child: Text("(For Developer User Can Hold/Or To Delete This Row)",style: TextStyle(fontStyle: FontStyle.italic,color: AppColors.textclr,fontSize: 13),),
//                     ),
//                     SizedBox(height: 10,),
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Icon(Icons.add_circle_outline,color: AppColors.temtextclr,size: 30,),
//                     ),
//                     Text("Add Type Of Photographer",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
//                     SizedBox(height: 20,),
//
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20,),
//
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Output",style: TextStyle(color: AppColors.textclr,fontSize: 19,fontWeight: FontWeight.bold),),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: AppColors.editfield,
//
//                           borderRadius: BorderRadius.circular(10)),
//                       height: 35,
//                       width: MediaQuery.of(context).size.width/1.7,
//                     )
//                   ],),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text("Amount",style: TextStyle(color: AppColors.textclr,fontSize: 19,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
//                     Container(
//                       decoration: BoxDecoration(
//                           color: AppColors.editfield,
//
//                           borderRadius: BorderRadius.circular(10)),
//                       height: 35,
//                       width: MediaQuery.of(context).size.width/1.7,
//                     )
//                   ],),
//               ),
//               SizedBox(height: 20,),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   GestureDetector(
//                     onTap: (){
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>JobsScreen()));
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 150,
//                       decoration: BoxDecoration(
//                           color: AppColors.AppbtnColor,
//                           borderRadius: BorderRadius.circular(5)),
//                       child: Center(child: Text("Update",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.textclr,fontSize: 18),)),
//                     ),
//                   ),
//                   Image.asset("assets/images/pdf.png", scale: 1.6,),
//                   Container(
//                     height: 50,
//                     width: 100,
//                     decoration: BoxDecoration(
//                         color: AppColors.contaccontainerred,
//                         borderRadius: BorderRadius.circular(5)),
//                     child: Center(child: Text("Delete",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.textclr,fontSize: 18),)),
//                   ),
//
//                 ],),
//
//
//
//               SizedBox(height: 20,),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
