import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kolazz_book/Models/accounts_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:kolazz_book/Views/Accounts/account_details_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/colors.dart';
import 'add_amount.dart';

class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {
  var selectedTime1;
  GlobalKey keyList = GlobalKey();

  TextEditingController dateinput = TextEditingController();

  AccountData? data;
  int currentIndex = 0;
  int photographerIndex = 0;

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
    getAccountsData();
  }


  accountCard(result){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8,  top: 10),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AccountDetailsScreen(
            photographerName: result.name,
            pid: result.id,
            type: isSelected? 'client' : 'photographer',
          )));
        },
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width / 1.1,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient:  LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    double.parse(result.amount.toString()) < 0 ?
                    Colors.red :
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
                Text('₹ ${result.amount}',
                    style: const TextStyle(
                        color: AppColors.textclr)),
                // Image.asset("assets/calling.png", scale: 1.4,)
              ],
            ),
          ),
        ),
      ),
    );
  }


  takeScreenShot() async {
    // iconVisible = true ;
    var status =  await Permission.photos.request();
    //Permission.manageExternalStorage.request();

    //PermissionStatus storagePermission = await Permission.storage.request();
    if ( status.isGranted/*storagePermission == PermissionStatus.denied*/) {
      final directory = (await getApplicationDocumentsDirectory()).path;

      RenderRepaintBoundary bound = keyList.currentContext!.findRenderObject() as RenderRepaintBoundary;
      /*if(bound.debugNeedsPaint){
        Timer(const Duration(seconds: 2),()=>_shareQrCode());
        return null;
      }*/
      ui.Image image = await bound.toImage(pixelRatio: 10);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      print('${byteData?.buffer.lengthInBytes}___________');
      // this will save image screenshot in gallery
      if(byteData != null ){
        Uint8List pngBytes = byteData.buffer.asUint8List();
        String fileName = DateTime
            .now()
            .microsecondsSinceEpoch
            .toString();
        final imagePath = await File('$directory/$fileName.png').create();
        await imagePath.writeAsBytes(pngBytes);
        Share.shareFiles([imagePath.path],text: '');
        // final resultsave = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes),quality: 90,name: 'screenshot-${DateTime.now()}.png');
        //print(resultsave);
      }
      /*_screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          try {
            String fileName = DateTime
                .now()
                .microsecondsSinceEpoch
                .toString();

            final imagePath = await File('$directory/$fileName.png').create();
            if (imagePath != null) {
              await imagePath.writeAsBytes(image);
              Share.shareFiles([imagePath.path],text: text);
            }
          } catch (error) {}
        }
      }).catchError((onError) {
        print('Error --->> $onError');
      });*/
    } else if (await status.isDenied/*storagePermission == PermissionStatus.denied*/) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('This Permission is recommended')));
    } else if (await status.isPermanentlyDenied/*storagePermission == PermissionStatus.permanentlyDenied*/) {
      openAppSettings().then((value) {

      });
    }
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
    request.fields[RequestKeys.userId] = id!;
    request.fields[RequestKeys.userType] = isSelected ? 'client' : 'photographer';

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
  bool isSelected = true;

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
                    getAccountsData();
                  });
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
                "Client name",
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
              return accountCard(result);
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
              return accountCard(result);
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
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 80,
                child: ElevatedButton(onPressed: () {
                  setState(() {
                    photographerIndex = 0 ;
                  });
                  // getAccountsData();
                }, child: Text("All"))),
            const SizedBox(width: 10,),
            SizedBox(
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      photographerIndex = 0 ;
                    });
                    // getAccountsData();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red, // Background color
                  ),
                  child: Text("Payout"),
                )),
            const SizedBox(width: 10,),
            SizedBox(
                width: 120,
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        photographerIndex = 0 ;
                      });
                      // getAccountsData();
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AddAmountScreen()));
                    },
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
      Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Container(
          height: 45,
          width: MediaQuery.of(context).size.width / 1.1,
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
      ),
      SizedBox(
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
            return accountCard(result);
          },
        ),
      )
      // :
      // currentIndex == 1
      //     ? Container(
      //   // color: Colors.red,
      //   height: MediaQuery.of(context).size.height / 1.8,
      //   width: MediaQuery.of(context).size.width,
      //   child: ListView.builder(
      //     shrinkWrap: true,
      //     scrollDirection: Axis.vertical,
      //     itemCount: data!.payout!.length,
      //     physics: const ScrollPhysics(),
      //     itemBuilder: (BuildContext context, int index) {
      //       var result = data!.payout![index];
      //       return accountCard(result);
      //     },
      //   ),
      // )
      : Container(
        // color: Colors.red,
        height: MediaQuery.of(context).size.height / 1.8,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: data!.outstanting!.length,
          physics: const ScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            var result = data!.outstanting![index];
            return accountCard(result);
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
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              child: Text("Photographer Account",
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
            onPressed: () {
              takeScreenShot();
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: RepaintBoundary(
        key: keyList,
        child: Container(
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
                              getAccountsData();
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
                              getAccountsData();
                            },
                            child: Container(
                                height: 50,
                                width: 130,
                                child: Center(
                                  child: Text(
                                    'Photographer',
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
                const SizedBox(height: 10),
                const SizedBox(
                  height: 4,
                ),
                isSelected ? _clients() : _phptographers(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
