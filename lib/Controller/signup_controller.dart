import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/resister_user_response.dart';
import '../Route_managements/routes.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class SignupController extends AppBaseController{
  bool isCheck =false;
  String? Otp;
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool isVisible = true;
  bool isVisible2 = true;


  RegisterUserData? registerData;

   Future<void> registerUser() async {
    // mobileFocus.unfocus();
    //passwordFocus.unfocus();
     //String? deviceID = await getDeviceIdentifier();
     setBusy(true);
     try {

         Map<String, String> body = {};
         body[RequestKeys.fname] = firstnameController.text.trim();
         body[RequestKeys.lname] = lastnameController.text.trim();
         body[RequestKeys.mobile] = mobileController.text.trim();
         body[RequestKeys.password] = passwordController.text.trim();
         body[RequestKeys.Cpassword] = cPasswordController.text.trim();
         body[RequestKeys.email] =   emailController.text.trim();
         RegisterUserResponse res = await api.registerUpi(body);
         if (!(res.error ?? true)) {

           registerData = res.data;
            Otp = registerData?.otp.toString();
           String? mobile = registerData?.mobile;
           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setString('otp',Otp ?? '');
           prefs.setString('mobile',mobile!);
           print('__________${res.message}_____________');

           ShowMessage.showSnackBar('Server Res', res.message ?? '');
           setBusy(false);
           Get.toNamed(otpScreen);


           update();
           //UserData? userData = UserData();
           //userData = res.data;
           //SharedPre.setValue(SharedPre.userData, userData?.toJson());
         //  SharedPre.setValue(SharedPre.isLogin, true);
           /*if (userData?.mobileVerifyStatus == 0) {
             Get.toNamed(AppRoutes.otp,
                 arguments: [mobileCtrl.text.trim(), passwordCtrl.text.trim()]);
           } else if (userData?.profileStatus == 0) {
             Get.offAndToNamed(AppRoutes.setupProfile);
           } else {
             mobileCtrl.clear();
             passwordCtrl.clear();
             Get.offAndToNamed(AppRoutes.home);*/
           }

     } catch (e) {
       ShowMessage.showSnackBar('Server Res', '$e');

     } finally {
       setBusy(false);
       update();
     }
   }

   void tapOnLoginButton(){
     Get.toNamed(loginScreen);
   }

   void onTapSignUp(){
     Get.toNamed(loginScreen);
   }
}