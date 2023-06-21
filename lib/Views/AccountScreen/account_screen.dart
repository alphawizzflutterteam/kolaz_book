import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kolazz_book/Models/accounts_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/colors.dart';
import '../freelencing_jobpost/account.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  var selectedTime1;
  GlobalKey keyList = GlobalKey();

  _selectStartTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        useRootNavigator: true,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(primary: Colors.black),
                buttonTheme: const ButtonThemeData(
                    colorScheme: ColorScheme.light(primary: Colors.black))),
            child: MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: false),
                child: child!),
          );
        });
    if (timeOfDay != null && timeOfDay != selectedTime1) {
      setState(() {
        selectedTime1 = timeOfDay.replacing(hour: timeOfDay.hourOfPeriod);
        startTimeController.text = selectedTime1!.format(context);
      });
    }
    var per = selectedTime1!.period.toString().split(".");
    print(
        "selected time here ${selectedTime1!.format(context).toString()} and ${per[1]}");
  }

  TextEditingController dateinput = TextEditingController();

  AccountData? data;
  int currentIndex = 0;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    getAccountsData();
  }

  getAccountsData() async {
    print("account initiated!");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(getAccountsDataApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = "4";
    //id!;
    request.fields[RequestKeys.userType] = 'client';
    print("this is account request ${request.fields.toString()} and $getAccountsDataApi");
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      data = AccountsModel.fromJson(userData).data!;
    });
    print("this is =====>>>>> ${data!.all!.length}");
  }

  TextEditingController startTimeController = TextEditingController();

  String? dropdownvalue;
  bool isSelected = false;
  var items = [
    '2wheeler',
    '3wheeler',
    '4wheeler',
  ];

  var item = ['Select Category'];

  Widget _clients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          width: MediaQuery.of(context).size.width / 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                  getAccountsData();
                },
                child: Container(
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex == 0
                            ? const Color(0xff668D3F)
                            : Colors.transparent,
                        border: Border.all(
                            color: currentIndex == 0
                                ? Colors.transparent
                                : const Color(0xff668D3F))),
                    child: const Center(
                      child: Text(
                        "All",
                        style: TextStyle(
                            color: AppColors.whit,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
              SizedBox(
                width: 15,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    // width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: currentIndex == 1
                            ? const Color(0xff668D3F)
                            : Colors.transparent,
                        border: Border.all(
                            color: currentIndex == 1
                                ? Colors.transparent
                                : const Color(0xff668D3F))),
                    child: const  Center(
                      child: Text(
                        "Outstanding",
                        style: TextStyle(
                            color: AppColors.whit,
                            // currentIndex == 1
                            //     ? AppColors.whit
                            //     : Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    )),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(context).size.width ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Photographer name",
                style: TextStyle(color: AppColors.whit),
              ),
              Text("City Name", style: TextStyle(color: AppColors.whit)),
              Text("Remaining", style: TextStyle(color: AppColors.whit)),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        data != null
            ? currentIndex == 0
            ? Container(
          // color: Colors.red,
          height: MediaQuery.of(context).size.height / 1.8,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data!.all!.length,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var result = data!.all![index];
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8,  top: 10),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff68913F),
                            Color(0xff424242)
                          ])),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${result.name}',
                          style:
                          const TextStyle(color: AppColors.textclr),
                        ),
                        Text('${result.city}',
                            style: const TextStyle(
                                color: AppColors.textclr)),
                        Text('₹ ${result.debit}',
                            style: const TextStyle(
                                color: AppColors.textclr)),
                        // Image.asset("assets/calling.png", scale: 1.4,)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
            : Container(
          height: MediaQuery.of(context).size.height / 1.8,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: data!.outstanting!.length,
            physics: const ScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var result = data!.outstanting![index];
              return Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8,  top: 10),
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff68913F),
                            Color(0xff424242)
                          ])),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${result.name}',
                          style:
                          const TextStyle(color: AppColors.textclr),
                        ),
                        Text('${result.city}',
                            style: const TextStyle(
                                color: AppColors.textclr)),
                        Text('₹ ${result.debit}',
                            style: const TextStyle(
                                color: AppColors.textclr)),
                        // Image.asset("assets/calling.png", scale: 1.4,)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
            : Container(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: const Center(
                child: Text(
                  "No Data to show",
                  style: TextStyle(color: AppColors.whit),
                )))
      ],
    );
  }

  Widget _phptographers() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: 80,
                child: ElevatedButton(onPressed: () {}, child: Text("All"))),
            SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red, // Background color
                  ),
                  child: Text("Payout"),
                )),
            SizedBox(
                width: 120,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff668D3F),
                    ),
                    child: Text("Outstanding"))),
          ],
        ),
      ),
      SizedBox(
        height: 4,
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Photographer name",
              style: TextStyle(color: AppColors.whit),
            ),
            Text("City Name", style: TextStyle(color: AppColors.whit)),
            Text("Remaining", style: TextStyle(color: AppColors.whit)),
          ],
        ),
      ),
      SizedBox(
        height: 4,
      ),
      InkWell(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => AccountScreen()));
        },
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff68913F), Color(0xff424242)])),
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Jigar Patel",
                  style: TextStyle(color: AppColors.textclr),
                ),
                Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
                Text("1000", style: TextStyle(color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
      Container(
        // padding: EdgeInsets.symmetric(horizontal: 20,),
        height: 45,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff68913F), Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Jigar Patel",
                style: TextStyle(color: AppColors.textclr),
              ),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff68913F), Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kinjal Patel",
                style: TextStyle(color: AppColors.textclr),
              ),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff68913F), Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dhaval Patel",
                style: TextStyle(color: AppColors.textclr),
              ),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff68913F), Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dhaval Patel",
                style: TextStyle(color: AppColors.textclr),
              ),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff68913F), Color(0xff424242)])),
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dhaval Patel",
                style: TextStyle(color: AppColors.textclr),
              ),
              Text("Mumbai", style: TextStyle(color: AppColors.textclr)),
              Text("1000", style: TextStyle(color: AppColors.textclr)),
              // Image.asset("assets/calling.png", scale: 1.4,)
            ],
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgruond,
      appBar: isSelected
          ? AppBar(
        backgroundColor: Color(0xff303030),
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text("Client Account",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(0xff1E90FF),
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      )
          : AppBar(
        backgroundColor: Color(0xff303030),
        automaticallyImplyLeading: false,
        actions: const [
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Text("Freelancing Account",
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
          child: FloatingActionButton(
            child: Image.asset("assets/images/pdf.png"),
            onPressed: () {},
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
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
                            setState(() {
                              isSelected = true;
                            });
                          },
                          child: Container(
                              height: 50,
                              width: 120,
                              child: Center(
                                child: Text(
                                  'Client',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Color(0xffffffff)
                                        : Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.AppbtnColor
                                    : AppColors.containerclr,
                                // border: Border.all(color: AppColors.AppbtnColor),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => NextPage(),
                              // ));
                              isSelected = false;
                            });
                          },
                          child: Container(
                              height: 50,
                              width: 130,
                              child: Center(
                                child: Text(
                                  'Freelancing',
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.whit
                                        : Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.containerclr
                                      : AppColors.AppbtnColor,
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 4,
              ),
              isSelected ? _clients() : _phptographers(),
            ],
          ),
        ),
      ),
    );
  }
}
