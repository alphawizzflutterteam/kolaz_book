import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kolazz_book/Models/login_response_model.dart';
import 'package:kolazz_book/Route_managements/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/login_response_model.dart';
import '../Models/login_response_model.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';
import 'package:device_info/device_info.dart';

class LoginController extends AppBaseController {



  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  int value1 = 0;
  bool isVisible = true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDeviceId();
    printIps();
  }
 clear(){
    mobileController.clear();
    passwordController.clear();


 }


  void onTapSingup() {
    Get.toNamed(signupScreen);
  }

  void onTapOtp() {
    Get.toNamed(otpScreen);
  }



  // void onTapForgotpass() {
  //   Get.toNamed(forgotPasswordScreen);
  // }


   List<Data> loginData = [];
  String? id;
  String? deviceid;
  String? address;


  Future<void> loginUser() async {

    // mobileFocus.unfocus();
    //passwordFocus.unfocus();
    //String? deviceID = await getDeviceIdentifier();
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.mobile] = mobileController.text.trim();
      body[RequestKeys.password] = passwordController.text.trim();
      // body[RequestKeys.deviceid] = '${deviceid}';
      // body[RequestKeys.ipaddress] = "${address}";

      LoginResponseModel res = await api.loginUserApi(body);
      if (!(res.error ?? true)) {
        loginData = res.data! ;
        id =loginData[0].id;
        print('_device id is here____________${deviceid}');
        print('_________address id is here____________${address}');
        print("_________thisis iddddddddddd${id}");
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('id',id!);
        preferences.setString('deviceId', deviceid!);
        Get.toNamed(dashbord);
        setBusy(false);
        clear();
        update();
        ShowMessage.showSnackBar('Server Res', '${res.message}');
      }else {
        Fluttertoast.showToast(msg: "${res.message}");
        //ShowMessage.showSnackBar('Server Res', '${res.message}');
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  void getDeviceId() async  {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceid = androidInfo.androidId;

      print('Device ID____for android: $deviceid');
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceid = iosInfo.identifierForVendor;
      print('Device ID: $deviceid');
    }
  }
   Future printIps() async {
     for (var interface in await NetworkInterface.list()) {
       print('== Interface: ${interface.name} ==');
       for (var addr in interface.addresses) {
         address = addr.address;
         print(
             '__________________${addr.address} ______________${addr.host} ${addr.isLoopback} ${addr.rawAddress} ${addr.type.name} ');
       }
     }
   }
}
