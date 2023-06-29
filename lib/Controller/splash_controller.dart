
import 'dart:async';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Route_managements/routes.dart';
import 'appbased_controller/appbase_controller.dart';

class SplashController extends AppBaseController {

  String? id;
  Future<void> onInit() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');

    // TODO: implement onInit
      Timer( const Duration(seconds: 3),(){
        print("_______>>>>__________${id}");

        if(id == null || id == ''){
          Get.offNamed(loginScreen);
        }else{
          Get.offNamed(introScreen);
         // Get.offNamed(dashbord);
        }
      });
      super.onInit();
    // TODO: implement initState

  }
}