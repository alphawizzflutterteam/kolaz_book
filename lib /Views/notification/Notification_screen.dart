import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kolazz_book/Models/notification_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../Utils/colors.dart';

class Notification_screen extends StatefulWidget {
  const Notification_screen({Key? key}) : super(key: key);

  @override
  State<Notification_screen> createState() => _Notification_screenState();
}

class _Notification_screenState extends State<Notification_screen> {
  bool _isToggled = false;
  String? userId;
  List<Data> notificationList = [];

  getNotifications() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    var uri = Uri.parse(getNotificationsApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = userId.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    var finalResult = NotificationModel.fromJson(userData);

    setState(() {
      notificationList = finalResult.data!;
    });
  }

  clearAllNotifications(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('id');
    var headers = {
      'Cookie': 'ci_session=b222ee2ce87968a446feacdb861ad51c821bdf6d'
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse(clearAllNotificationsApi.toString()));
    request.fields.addAll({
      'user_id': userId.toString()

    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseData =
      await response.stream.transform(utf8.decoder).join();
      var userData = json.decode(responseData);
      if (userData['error'] == false) {
        Navigator.pop(context, true);
        Fluttertoast.showToast(msg: userData['message']);
        // getBroadCastData();

      } else {
        Fluttertoast.showToast(msg: userData['message']);
        // getBroadCastData();
        // Fluttertoast.showToast(msg: userData['msg']);
      }
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();

  }
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      
      child: Scaffold(backgroundColor: AppColors.backgruond,
        appBar: AppBar(
          leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios, color: AppColors.AppbtnColor)),
          backgroundColor: Color(0xff303030),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10.0,right: 10),
                  child: Text("Notification", style: TextStyle(fontSize: 18, color:AppColors.AppbtnColor, fontWeight: FontWeight.bold)
                  ),
                ),
                // Expanded(
                //   child:Padding(
                //     padding: const EdgeInsets.only(right: 12.0),
                //     child: FlutterSwitch(
                //       height: 20.0,
                //       width: 40.0,
                //       padding: 4.0,
                //       toggleSize: 15.0,
                //       borderRadius: 10.0,
                //       activeColor: AppColors.AppbtnColor,
                //       value: _isToggled,
                //       onToggle: (value) {
                //         setState(() {
                //           _isToggled = value;
                //         });
                //       },
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20,15,20,10),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Align(alignment: Alignment.topRight,
                  child: SizedBox(height: 30,
                    child: TextButton(onPressed: (){
                      clearAllNotifications(context);
                    },
                        child: const Text("Clear all",style: TextStyle(decoration: TextDecoration.underline,),)),
                  ),
                ),
                SizedBox(height: 10,),
                notificationList.isNotEmpty ?
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: notificationList.length,
                    itemBuilder: (context, index){
                  return Container(
                    padding: EdgeInsets.all(8),
                    height: 70,
                    decoration: BoxDecoration(
                        color: Color(0xff6D6A6A),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notificationList[index].title.toString(),
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color(0xffEEB80A)),),
                        Text(
                          notificationList[index].message.toString(),
                          style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xffEEB80A)),),

                      ],
                    ),
                  );
                })
               :  Container(
                  height: MediaQuery.of(context).size.height /1.4,
                  width: MediaQuery.of(context).size.width /1.0,
                  child: const Center(
                    child: Text("No Notifications found!", style: TextStyle(
                      color: AppColors.whit
                    ),),

                  ),
                ),
                SizedBox(height: 20,),

              ],
            ),
          ),
        ),
      ),),
    );
  }
}
