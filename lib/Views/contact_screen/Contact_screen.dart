import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Controller/contact_screen_controller.dart';
import 'package:kolazz_book/Utils/strings.dart';
// import 'package:kolazz_book/Views/AccountScreen/client_amt.dart';
// import 'package:kolazz_book/Views/AccountScreen/account_details_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Models/Type_of_photography_model.dart';
import '../../Utils/colors.dart';
import '../../Widgets/show_message.dart';
import '../Accounts/client_amt.dart';
import '../freelencing_jobpost/allotment.dart';
import '../freelencing_jobpost/client_Jobs_screen.dart';
import '../freelencing_jobpost/frelencing_post.dart';
import '../freelencing_jobpost/team allotment.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);


  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {



  @override

  int selected = -1;
  // Future.delayed(duration : Duration(milliseconds: 200))
  _phptographers() {
    return GetBuilder(
      init: addPhotographerController(),
      builder: (controller) {
        // print("_________________________${controller.getphotographetClient.first.firstName}");

        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              color: AppColors.darkblakcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: controller.searchController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textclr,
                    ),
                    hintText: 'Name, City Type of Photographers Company Name',
                    hintStyle: TextStyle(color: AppColors.textclr)),
                onChanged: (value) {
                  controller.getClientPhotographer();
                  // searchTypes(value);
                },
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView.builder(
                itemCount: controller.getphotographetClient.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 2),
                    child: Container(
                      // height: 45,
                      width: MediaQuery.of(context).size.width / 1,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lightwhite),
                      child: InkWell(
                        onTap: () {},
                        child: ExpansionTile(
                          initiallyExpanded: false,
                          //index == selected,
                          key: Key(selected.toString()),
                          onExpansionChanged: (newState) {
                            setState(() {
                              selected = index;
                            });
                          },
                          trailing: Image.asset(
                            "assets/calling.png",
                            scale: 1.1,
                          ),

                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${controller.getphotographetClient[index].firstName} ${controller.getphotographetClient[index].lastName}",
                                style: TextStyle(
                                    color: AppColors.textclr, fontSize: 13),
                              ),
                              // Text(
                              //     "${controller.getphotographetClient[index].type}",
                              //     style: TextStyle(
                              //         color: AppColors.textclr, fontSize: 13)),
                              Text(
                                  "${controller.getphotographetClient[index].city}",
                                  style: TextStyle(
                                      color: AppColors.textclr, fontSize: 13)),
                            ],
                          ),
                          children: [
                            InkWell(
                              onTap: () {
                                // setState(() {
                                //   if(off==true){
                                //     _isExpanded =false;
                                //   }
                                // }
                                // );
                              },
                              child: ListTile(
                                  title: Container(
                                padding: EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    color: AppColors.contaccontainer,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        freelencingPost()));
                                          },
                                          child: Container(
                                            height: 40,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.9,
                                            decoration: BoxDecoration(
                                              color: AppColors.AppbtnColor,
                                              // border: Border.all(color: AppColors.AppbtnColor),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'Freelancing',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        AllotmentScreen()));
                                          },
                                          child: Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.9,
                                              child: Center(
                                                child: Text(
                                                  'Allotment',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              decoration: BoxDecoration(
                                                color: AppColors
                                                    .contaccontainerblack,
                                                // border: Border.all(color: AppColors.AppbtnColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             AccountScreen()));
                                      },
                                      child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: AppColors.pdfbtn),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const  Center(
                                              child: Text("Account",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          AppColors.textclr)))),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print("this is type ${controller
                                                .getphotographetClient[
                                            index].photographerType}");
                                            controller
                                                .firstnameController.text =
                                                controller
                                                    .getphotographetClient[
                                                index]
                                                    .firstName
                                                    .toString();
                                            //TextEditingController(text: controller.getphotographetClient[index].firstName.toString());
                                            controller.lastnameController.text =
                                                controller
                                                    .getphotographetClient[
                                                index]
                                                    .lastName
                                                    .toString();
                                            //TextEditingController(text: controller.getphotographetClient[index].lastName.toString());
                                            controller.cityController.text =
                                                controller
                                                    .getphotographetClient[
                                                index]
                                                    .city
                                                    .toString();
                                            // controller.categoryValue =  controller
                                            //     .getphotographetClient[
                                            // index].photographerType;
                                            // TextEditingController(text: controller.getphotographetClient[index].city.toString());
                                            controller.mobileController.text =
                                                controller
                                                    .getphotographetClient[index]
                                                    .mobile
                                                    .toString();
                                            controller.categoryValue =
                                                controller
                                                    .getphotographetClient[
                                                index].photographerType;

                                            controller.perdayController.text =
                                                controller
                                                    .getphotographetClient[
                                                index]
                                                    .perDayCharges
                                                    .toString();
                                            controller.companyController.text =
                                                controller
                                                    .getphotographetClient[
                                                index]
                                                    .compnyName
                                                    .toString();

                                            //TextEditingController(text: controller.getphotographetClient[index].mobile.toString());
                                            editPhotographer(index);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: AppColors.lightwhite,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: AppColors.textclr,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  deleteConfirmation(
                                                      controller
                                                          .getphotographetClient[
                                                              index]
                                                          .id
                                                          .toString(),
                                                      controller),
                                            );
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .contaccontainerred,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: AppColors.textclr,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ))
        ]);
      },
    );
  }

  _clients() {
    return GetBuilder(
      init: addPhotographerController(),
      builder: (controller) {
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              color: AppColors.darkblakcolor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: controller.searchController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.textclr,
                    ),
                    hintText: 'Name, City.....',
                    hintStyle: TextStyle(color: AppColors.textclr)),
                onChanged: (value) {
                  controller.getClienttlist();
                },
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: ListView.builder(
              itemCount: controller.gettClient.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
                  child: controller.gettClient == null ||
                          controller.gettClient == ""
                      ? Center(child: Text("No Data Found"))
                      : Container(
                          // height: 45,
                          width: MediaQuery.of(context).size.width / 1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.lightwhite),
                          child: ExpansionTile(
                            initiallyExpanded: false,
                            //index == selected,
                            key: Key(selected.toString()),
                            onExpansionChanged: (newState) {
                              setState(() {
                                selected = index;
                              });
                            },
                            trailing: Image.asset(
                              "assets/calling.png",
                              scale: 1.1,
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controller.gettClient[index].firstName} ${controller.gettClient[index].lastName}",
                                  style: const TextStyle(
                                      color: AppColors.textclr, fontSize: 13),
                                ),
                                Text(
                                    "${controller.gettClient[index].city}",
                                    style: const TextStyle(
                                        color: AppColors.textclr,
                                        fontSize: 13)),
                              ],
                            ),
                            children: [
                              ListTile(
                                  title: Container(
                                padding: EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                    color: AppColors.contaccontainer,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FinalJobsScreen()));
                                          },
                                          child: Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.9,
                                              decoration: BoxDecoration(
                                                color: AppColors.AppbtnColor,
                                                // border: Border.all(color: AppColors.AppbtnColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Final Jobs',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                     ),
                                                ),
                                              )),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        TeamAllotment()));
                                          },
                                          child: Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.9,
                                              decoration: BoxDecoration(
                                                color: AppColors
                                                    .contaccontainerblack,
                                                // border: Border.all(color: AppColors.AppbtnColor),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Team Allotment',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                     ),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ClientDetails()));
                                      },
                                      child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: AppColors.pdfbtn),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: const Center(
                                              child: Text("Account",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          AppColors.textclr)))),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            controller
                                                    .firstnameController.text =
                                                controller
                                                    .gettClient[
                                                        index]
                                                    .firstName
                                                    .toString();
                                            //TextEditingController(text: controller.getphotographetClient[index].firstName.toString());
                                            controller.lastnameController.text =
                                                controller
                                                    .gettClient[
                                                        index]
                                                    .lastName
                                                    .toString();
                                            //TextEditingController(text: controller.getphotographetClient[index].lastName.toString());
                                            controller.cityController.text =
                                                controller
                                                    .gettClient[
                                                        index]
                                                    .city
                                                    .toString();
                                            // TextEditingController(text: controller.getphotographetClient[index].city.toString());
                                            controller.mobileController.text =
                                                controller
                                                    .gettClient[
                                                        index]
                                                    .mobile
                                                    .toString();
                                            //TextEditingController(text: controller.getphotographetClient[index].mobile.toString());
                                            editClient(index);
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: AppColors.lightwhite,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                "Edit",
                                                style: TextStyle(
                                                    color: AppColors.textclr,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (context) =>

                                              deleteConfirmation(
                                                  controller
                                                      .gettClient[
                                                          index]
                                                      .id
                                                      .toString(),
                                                  controller),
                                                  // deleteConfirmation(
                                                  //     controller
                                                  //         .getphotographetClient[
                                                  //             index]
                                                  //         .id
                                                  //         .toString(),
                                                  //     controller),
                                            );
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 80,
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .contaccontainerred,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: const Center(
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: AppColors.textclr,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                );
              },
            ),
          )
        ]);
      },
    );
  }

  deleteConfirmation(String id, controller) {
    return AlertDialog(
      backgroundColor: AppColors.primary,
      title: const Text(
        'Delete!',
        style: TextStyle(color: AppColors.textclr),
      ),
      content: const Text(
        'Are you sure you want to delete?',
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
              child: Center(
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
              child: Center(
                  child: Text(
                'Yes',
                style: TextStyle(color: AppColors.textclr),
              ))),
          onPressed: () {
            deleteQuotation(id, controller);
            Navigator.of(context).pop(true);

          },
        ),
      ],
    );
  }

  deleteQuotation(String id, controller) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(deleteClientPhotoApi.toString()));
    request.fields.addAll({'id': id.toString()});
    print("this is delete client request ${request.fields.toString()} and $deleteClientPhotoApi");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseData =
          await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (userData['status'] == "1") {
        Fluttertoast.showToast(msg: userData['msg']);
        controller.getClientPhotographer();
        controller.getClienttlist();
      } else {
        Fluttertoast.showToast(msg: userData['msg']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  editPhotographer(int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, Function(Function()) setState) {
            return Padding(
                padding: MediaQuery.of(context).viewInsets,
                // padding: const EdgeInsets.all(8.0),
                child: GetBuilder(
                    init: addPhotographerController(),
                    builder: (controller) {
                      return SingleChildScrollView(
                        child: Form(
                          key: controller.formKey,
                          child: Container(
                            // height: MediaQuery.of(context).size.height,
                            color: AppColors.teamcard2,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 15),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.AppbtnColor),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.9,
                                        child: Center(
                                            child: Text("Photographer",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        AppColors.textclr)))),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            // height: 40,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: AppColors.cardclr),
                                            child: TextFormField(
                                              style: TextStyle(
                                                  color: AppColors.textclr),
                                              controller: controller
                                                  .firstnameController,
                                              keyboardType: TextInputType.name,
                                              validator: (val) {
                                                if (val!.isEmpty) {
                                                  return 'Please Enter Firstname';
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  hintText: 'First Name',
                                                  hintStyle: TextStyle(
                                                      color: AppColors.textclr,
                                                      fontSize: 14),
                                                  border: InputBorder.none,
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          left: 10,
                                                          bottom: 16)),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            // height: 40,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: AppColors.cardclr),
                                            child: Center(
                                              child: TextFormField(
                                                style: TextStyle(
                                                    color: AppColors.textclr),
                                                controller: controller
                                                    .lastnameController,
                                                keyboardType:
                                                    TextInputType.name,
                                                validator: (value) => value!
                                                        .isEmpty
                                                    ? 'Lastname cannot be blank'
                                                    : null,
                                                decoration: InputDecoration(
                                                    hintText:
                                                        'Last Name(Surname)',
                                                    hintStyle: TextStyle(
                                                        color:
                                                            AppColors.textclr,
                                                        fontSize: 14),
                                                    border: InputBorder.none,
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 9,
                                                            bottom: 17)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 40,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.cardclr),
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: AppColors.textclr),
                                          controller:
                                              controller.mobileController,
                                          keyboardType: TextInputType.number,
                                          maxLength: 10,
                                          validator: (text) {
                                            if (text == null || text.isEmpty) {
                                              return 'Can\'t be empty';
                                            }
                                            if (text.length < 10) {
                                              return 'Too short';
                                            }
                                            return null;
                                          },
                                          decoration: const InputDecoration(
                                              counterText: "",
                                              hintText: 'Phone Number',
                                              hintStyle: TextStyle(
                                                  color: AppColors.textclr,
                                                  fontSize: 14),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, bottom: 16)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 34,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.cardclr),
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: AppColors.textclr),
                                          controller: controller.cityController,
                                          keyboardType: TextInputType.name,
                                          validator: (value) => value!.isEmpty
                                              ? 'City cannot be blank'
                                              : null,
                                          decoration: const InputDecoration(
                                              hintText: 'City',
                                              hintStyle: TextStyle(
                                                  color: AppColors.textclr,
                                                  fontSize: 14),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, bottom: 16)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 34,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.cardclr),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            dropdownColor: AppColors.cardclr,
                                            // Initial Value
                                            value: controller.categoryValue,
                                            isExpanded: true,
                                            hint: const Text(
                                              "Type Of Photography",
                                              style: TextStyle(
                                                  color: AppColors.textclr),
                                            ),
                                            icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: AppColors.textclr,
                                            ),
                                            // Array list of items
                                            items: controller
                                                .typeofPhotographyEvent
                                                .map((Categories items) {
                                              return DropdownMenuItem(
                                                value: items.resId,
                                                child: Text(
                                                  items.resName.toString(),
                                                  style: TextStyle(
                                                      color: AppColors.textclr),
                                                ),
                                              );
                                            }).toList(),
                                            // After selecting the desired option,it will
                                            // change button value to selected value
                                            onChanged: (newValue) {
                                              setState(() {
                                                controller.categoryValue =
                                                    newValue ;
                                              });
                                              print("this is my selected value ${controller.categoryValue}");
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 9,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 34,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.cardclr),
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: AppColors.textclr),
                                          controller:
                                              controller.companyController,
                                          keyboardType: TextInputType.name,
                                          validator: (value) => value!.isEmpty
                                              ? 'City cannot be blank'
                                              : null,
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Company Name (Optional)',
                                              hintStyle: TextStyle(
                                                  color: AppColors.textclr,
                                                  fontSize: 14),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, bottom: 16)),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 9,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 34,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: AppColors.cardclr),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: AppColors.textclr),
                                          controller:
                                              controller.perdayController,
                                          keyboardType: TextInputType.name,
                                          validator: (value) => value!.isEmpty
                                              ? 'Per day charges cannot be blank'
                                              : null,
                                          decoration: const InputDecoration(
                                              hintText: 'Add Per Day Charges',
                                              hintStyle: TextStyle(
                                                  color: AppColors.textclr,
                                                  fontSize: 14),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, bottom: 16)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        print(
                                            "plese_enterrrrrrrrrrrr__________");
                                        if (controller.formKey.currentState!
                                            .validate()) {
                                          controller.editPhotographer(controller
                                              .getphotographetClient[index].id
                                              .toString());
                                          Get.back();
                                        }
                                      },
                                      child: Container(
                                          height: 55,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: AppColors.pdfbtn),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          child: Center(
                                              child: Text("Edit",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color:
                                                          AppColors.textclr)))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }));
          },
        );
      },
    );
  }

  editClient(int index) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GetBuilder(
            init: addPhotographerController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  // padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: controller.formKey,
                    child: Container(
                      // height: MediaQuery.of(context).size.height,
                      color: AppColors.teamcard2,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 15),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.AppbtnColor),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Center(
                                      child: Text("Client",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.textclr)))),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      // height: 34,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.cardclr),
                                      child: TextFormField(
                                        style:
                                            TextStyle(color: AppColors.textclr),
                                        controller:
                                            controller.firstnameController,
                                        keyboardType: TextInputType.name,
                                        validator: (value) => value!.isEmpty
                                            ? 'Firstname cannot be blank'
                                            : null,
                                        decoration: const InputDecoration(
                                            hintText: 'First Name',
                                            hintStyle: TextStyle(
                                                color: AppColors.textclr,
                                                fontSize: 14),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                left: 10, bottom: 16)),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      // height: 34,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.cardclr),
                                      child: Center(
                                        child: TextFormField(
                                          style: TextStyle(
                                              color: AppColors.textclr),
                                          controller:
                                              controller.lastnameController,
                                          keyboardType: TextInputType.name,
                                          validator: (value) => value!.isEmpty
                                              ? 'Lastname cannot be blank'
                                              : null,
                                          decoration: const InputDecoration(
                                              hintText: 'Last Name(Surname)',
                                              hintStyle: TextStyle(
                                                  color: AppColors.textclr,
                                                  fontSize: 14),
                                              border: InputBorder.none,
                                              contentPadding: EdgeInsets.only(
                                                  left: 9, bottom: 17)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  // height: 34,
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.cardclr),
                                  child: TextFormField(
                                    style: const TextStyle(
                                        color: AppColors.textclr),
                                    controller: controller.mobileController,
                                    keyboardType: TextInputType.number,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return 'Can\'t be empty';
                                      }
                                      if (text.length < 10) {
                                        return 'Too short';
                                      }
                                      return null;
                                    },
                                    maxLength: 10,
                                    decoration: const InputDecoration(
                                        counterText: "",
                                        hintText: 'Phone Number',
                                        hintStyle: TextStyle(
                                            color: AppColors.textclr,
                                            fontSize: 14),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, bottom: 16)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 9,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  // height: 34,
                                  padding: EdgeInsets.symmetric(vertical: 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColors.cardclr),
                                  child: TextFormField(
                                    style: const TextStyle(
                                        color: AppColors.textclr),
                                    controller: controller.cityController,
                                    keyboardType: TextInputType.name,
                                    validator: (value) => value!.isEmpty
                                        ? 'City cannot be blank'
                                        : null,
                                    decoration: const InputDecoration(
                                        hintText: 'City',
                                        hintStyle: TextStyle(
                                            color: AppColors.textclr,
                                            fontSize: 14),
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                            left: 10, bottom: 16)),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              InkWell(
                                onTap: () {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.editClient(controller
                                        .gettClient[index].id
                                        .toString());
                                    Get.back();
                                  }
                                },
                                child: Container(
                                    height: 55,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.pdfbtn),
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: const Center(
                                        child: Text("Edit",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppColors.textclr)))),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: addPhotographerController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgruond,
          // bottomNavigationBar: bottomBar(),
          appBar: controller.isSelected
              ? AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0xff303030),
                  actions: const [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: Text("Photographers Contacts",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1E90FF),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              : AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Color(0xff303030),
                  actions: const [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: Text("Clients Contacts",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff1E90FF),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
          floatingActionButton: Container(
            // padding: EdgeInsets.only(bottom: 100.0),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: controller.isSelected
                    ? FloatingActionButton(
                        child: const Icon(
                          Icons.add,
                          size: 40,
                        ),
                        onPressed: () {
                          controller.firstnameController.clear();
                          controller.lastnameController.clear();
                          controller.mobileController.clear();
                          controller.cityController.clear();
                          controller.photogreaphertypeController.clear();
                          controller.companyController.clear();
                          controller.perdayController.clear();
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context,
                                    Function(Function()) setState) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    // padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      child: Form(
                                        key: controller.formKey,
                                        child: Container(
                                          // height: MediaQuery.of(context).size.height,
                                          color: AppColors.teamcard2,
                                          child: Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 15),
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: AppColors
                                                              .AppbtnColor),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.9,
                                                      child: const Center(
                                                          child: Text(
                                                              "Photographer",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: AppColors
                                                                      .textclr)))),
                                                 const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          // height: 40,
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                                  vertical: 0),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: AppColors
                                                                  .cardclr),
                                                          child: TextFormField(
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .textclr),
                                                            controller: controller
                                                                .firstnameController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .name,
                                                            validator: (val) {
                                                              if (val!
                                                                  .isEmpty) {
                                                                return 'Please Enter Firstname';
                                                              }
                                                            },
                                                            decoration: const InputDecoration(
                                                                hintText:
                                                                    'First Name',
                                                                hintStyle: TextStyle(
                                                                    color: AppColors
                                                                        .textclr,
                                                                    fontSize:
                                                                        14),
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                contentPadding:
                                                                    EdgeInsets.only(
                                                                        left:
                                                                            10,
                                                                        bottom:
                                                                            16)),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                          // height: 40,
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                                  vertical: 0),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: AppColors
                                                                  .cardclr),
                                                          child: Center(
                                                            child:
                                                                TextFormField(
                                                              style: const TextStyle(
                                                                  color: AppColors
                                                                      .textclr),
                                                              controller: controller
                                                                  .lastnameController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              validator: (value) =>
                                                                  value!.isEmpty
                                                                      ? 'Lastname cannot be blank'
                                                                      : null,
                                                              decoration: const InputDecoration(
                                                                  hintText:
                                                                      'Last Name(Surname)',
                                                                  hintStyle: TextStyle(
                                                                      color: AppColors
                                                                          .textclr,
                                                                      fontSize:
                                                                          14),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  contentPadding:
                                                                      EdgeInsets.only(
                                                                          left:
                                                                              9,
                                                                          bottom:
                                                                              17)),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      // height: 40,
                                                      padding:
                                                         const EdgeInsets.symmetric(
                                                              vertical: 0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: AppColors
                                                              .cardclr),
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .textclr),
                                                        controller: controller
                                                            .mobileController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        maxLength: 10,
                                                        validator: (text) {
                                                          if (text == null ||
                                                              text.isEmpty) {
                                                            return 'Can\'t be empty';
                                                          }
                                                          if (text.length <
                                                              10) {
                                                            return 'Too short';
                                                          }
                                                          return null;
                                                        },
                                                        decoration: const InputDecoration(
                                                            counterText: "",
                                                            hintText:
                                                                'Phone Number',
                                                            hintStyle: TextStyle(
                                                                color: AppColors
                                                                    .textclr,
                                                                fontSize: 14),
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom:
                                                                        16)),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      // height: 34,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: AppColors
                                                              .cardclr),
                                                      child: TextFormField(
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .textclr),
                                                        controller: controller
                                                            .cityController,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'City cannot be blank'
                                                                : null,
                                                        decoration: const InputDecoration(
                                                            hintText: 'City',
                                                            hintStyle: TextStyle(
                                                                color: AppColors
                                                                    .textclr,
                                                                fontSize: 14),
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom:
                                                                        16)),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      // height: 34,
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 8),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: AppColors
                                                              .cardclr),
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton(
                                                          dropdownColor:
                                                              AppColors.cardclr,
                                                          // Initial Value
                                                          value: controller
                                                              .categoryValue,
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
                                                            color: AppColors
                                                                .textclr,
                                                          ),
                                                          // Array list of items
                                                          items: controller
                                                              .typeofPhotographyEvent
                                                              .map((Categories
                                                                  items) {
                                                            return DropdownMenuItem(
                                                              value: items.resId,
                                                              child: Text(
                                                                items.resName
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: AppColors
                                                                        .textclr),
                                                              ),
                                                            );
                                                          }).toList(),
                                                          // After selecting the desired option,it will
                                                          // change button value to selected value
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              controller
                                                                      .categoryValue =
                                                                  newValue;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 9,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      // height: 34,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: AppColors
                                                              .cardclr),
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .textclr),
                                                        controller: controller
                                                            .companyController,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'City cannot be blank'
                                                                : null,
                                                        decoration: InputDecoration(
                                                            hintText:
                                                                'Company Name (Optional)',
                                                            hintStyle: TextStyle(
                                                                color: AppColors
                                                                    .textclr,
                                                                fontSize: 14),
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom:
                                                                        16)),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 9,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5.0),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      // height: 34,
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: AppColors
                                                              .cardclr),
                                                      child: TextFormField(
                                                        style: const TextStyle(
                                                            color: AppColors
                                                                .textclr),
                                                        controller: controller
                                                            .perdayController,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'City cannot be blank'
                                                                : null,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                'Add Per Day Charges',
                                                            hintStyle: TextStyle(
                                                                color: AppColors
                                                                    .textclr,
                                                                fontSize: 14),
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom:
                                                                        16)),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 40,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      print(
                                                          "plese_enterrrrrrrrrrrr__________");
                                                      if (controller
                                                          .formKey.currentState!
                                                          .validate()) {
                                                        controller
                                                            .AddPhotographerr();
                                                        Get.back();
                                                      }
                                                    },
                                                    child: Container(
                                                        height: 55,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color: AppColors
                                                                .pdfbtn),
                                                        width: MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                        child: Center(
                                                            child: Text("Add",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18,
                                                                    color: AppColors
                                                                        .textclr)))),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      )
                    : FloatingActionButton(
                        child: const Icon(
                          Icons.add,
                          size: 40,
                        ),
                        onPressed: () {
                          controller.firstnameController.clear();
                          controller.lastnameController.clear();
                          controller.mobileController.clear();
                          controller.cityController.clear();
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  // padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: controller.formKey,
                                    child: Container(
                                      // height: MediaQuery.of(context).size.height,
                                      color: AppColors.teamcard2,
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 15),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: AppColors
                                                          .AppbtnColor),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: Center(
                                                      child: Text("Client",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color: AppColors
                                                                  .textclr)))),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      // height: 34,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: AppColors
                                                              .cardclr),
                                                      child: TextFormField(
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .textclr),
                                                        controller: controller
                                                            .firstnameController,
                                                        keyboardType:
                                                            TextInputType.name,
                                                        validator: (value) =>
                                                            value!.isEmpty
                                                                ? 'Firstname cannot be blank'
                                                                : null,
                                                        decoration: const InputDecoration(
                                                            hintText:
                                                                'First Name',
                                                            hintStyle: TextStyle(
                                                                color: AppColors
                                                                    .textclr,
                                                                fontSize: 14),
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom:
                                                                        16)),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2.2,
                                                      // height: 34,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 0),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          color: AppColors
                                                              .cardclr),
                                                      child: Center(
                                                        child: TextFormField(
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .textclr),
                                                          controller: controller
                                                              .lastnameController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .name,
                                                          validator: (value) =>
                                                              value!.isEmpty
                                                                  ? 'Lastname cannot be blank'
                                                                  : null,
                                                          decoration: const InputDecoration(
                                                              hintText:
                                                                  'Last Name(Surname)',
                                                              hintStyle: TextStyle(
                                                                  color: AppColors
                                                                      .textclr,
                                                                  fontSize: 14),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      left: 9,
                                                                      bottom:
                                                                          17)),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 9,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  // height: 34,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: AppColors.cardclr),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.textclr),
                                                    controller: controller
                                                        .mobileController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (text) {
                                                      if (text == null ||
                                                          text.isEmpty) {
                                                        return 'Can\'t be empty';
                                                      }
                                                      if (text.length < 10) {
                                                        return 'Too short';
                                                      }
                                                      return null;
                                                    },
                                                    maxLength: 10,
                                                    decoration:
                                                        const InputDecoration(
                                                            counterText: "",
                                                            hintText:
                                                                'Phone Number',
                                                            hintStyle: TextStyle(
                                                                color: AppColors
                                                                    .textclr,
                                                                fontSize: 14),
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom:
                                                                        16)),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 9,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  // height: 34,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 0),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: AppColors.cardclr),
                                                  child: TextFormField(
                                                    style: const TextStyle(
                                                        color:
                                                            AppColors.textclr),
                                                    controller: controller
                                                        .cityController,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    validator: (value) => value!
                                                            .isEmpty
                                                        ? 'City cannot be blank'
                                                        : null,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText: 'City',
                                                            hintStyle: TextStyle(
                                                                color: AppColors
                                                                    .textclr,
                                                                fontSize: 14),
                                                            border: InputBorder
                                                                .none,
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    bottom:
                                                                        16)),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 40,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  if (controller
                                                      .formKey.currentState!
                                                      .validate()) {
                                                    controller.AddClient();
                                                    Get.back();
                                                  }
                                                },
                                                child: Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color:
                                                            AppColors.pdfbtn),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    child: const Center(
                                                        child: Text("Add",
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: AppColors
                                                                    .textclr)))),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )),
          ),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,

          body: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.containerclr,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.getClientPhotographer();

                                setState(() {
                                  controller.isSelected = true;
                                });
                                controller.searchController.clear();
                              },
                              child: Container(
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Text(
                                      'Photographers',
                                      style: TextStyle(
                                        color: controller.isSelected
                                            ? Color(0xffffffff)
                                            : Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.isSelected
                                        ? AppColors.AppbtnColor
                                        : AppColors.containerclr,
                                    // border: Border.all(color: AppColors.AppbtnColor),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                //controller.getClientPhotographer();
                                controller.getClienttlist();

                                setState(() {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => NextPage(),
                                  // ));
                                  controller.isSelected = false;
                                });
                                controller.searchController.clear();
                              },
                              child: Container(
                                  height: 40,
                                  width: 90,
                                  child: Center(
                                    child: Text(
                                      'Clients',
                                      style: TextStyle(
                                        color: controller.isSelected
                                            ? AppColors.whit
                                            : Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: controller.isSelected
                                          ? AppColors.containerclr
                                          : AppColors.AppbtnColor,
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  controller.isSelected ?
                  _phptographers()
                       : _clients(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
