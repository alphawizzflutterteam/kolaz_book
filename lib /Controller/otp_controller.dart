
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kolazz_book/Controller/signup_controller.dart';
import 'package:kolazz_book/Models/first_veryfy_otp_response.dart';
import 'package:kolazz_book/Models/resister_user_response.dart';
import 'package:kolazz_book/Route_managements/routes.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/verify_otp.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class OtpController extends AppBaseController{

   String? otp;
   String? mobile;
   String? name;
   String ? pin;
OtpFieldController otpController = OtpFieldController();
   TextEditingController firstnameController = TextEditingController();
   TextEditingController lastnameController = TextEditingController();
   TextEditingController emailController = TextEditingController();
   TextEditingController mobileController = TextEditingController();
   TextEditingController nameController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   TextEditingController cPasswordController = TextEditingController();
   final formkey = GlobalKey<FormState>();

final registerUserController = Get.put(SignupController());


   ResendOtpResponse? verifyOtpResponse;
   VerifyOtpResponse? otpResponse;
@override
  Future<void> onInit() async {
    // TODO: implement onInit
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  otp = prefs.getString('otp');
  mobile = prefs.getString('mobile');
  super.onInit();
  }


   RegisterUserData? registerData;

   Future<void> registerUser(fName, lName, mobile, email, pass) async {
     // mobileFocus.unfocus();
     //passwordFocus.unfocus();
     //String? deviceID = await getDeviceIdentifier();
     setBusy(true);
     try {

       Map<String, String> body = {};
       body[RequestKeys.fname] = fName.toString();
       body[RequestKeys.lname] = lName.toString();
       body[RequestKeys.mobile] = mobile.toString();
       body[RequestKeys.password] = pass.toString();
       body[RequestKeys.Cpassword] = pass.toString();
       body[RequestKeys.email] =   email.toString();
       RegisterUserResponse res = await api.registerUpi(body);
       if (!(res.error ?? true)) {

         registerData = res.data;
         // otp = registerData?.otp.toString();
         Fluttertoast.showToast(msg: res.message.toString());
         String? mobile = registerData?.mobile;
         SharedPreferences prefs = await SharedPreferences.getInstance();
         prefs.setString('otp', otp ?? '');
         prefs.setString('mobile', mobile!);
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
       }else{
         Fluttertoast.showToast(msg: res.message!);
       }

     } catch (e) {
       ShowMessage.showSnackBar('Server Res', '$e');

     } finally {
       setBusy(false);
       update();
     }
   }
  
  Future<void>onTapBottombar()async {
  Get.toNamed(dashbord);
  }




void onTapResend() async{

  setBusy(true);
  try {
    Map<String, String> body = {};
    body[RequestKeys.mobile] = mobile ?? "";
    body[RequestKeys.name] = name ?? "";

    ResendOtpResponse res = await api.resendOTPApi(body);
    if (!(res.error ?? true)) {
      verifyOtpResponse = res;

      setBusy(false);
      otp = verifyOtpResponse?.otp.toString();

      update();
    }
  } catch (e) {
    ShowMessage.showSnackBar('Server Res', '$e');
  } finally {
    setBusy(false);
    update();
  }
}

void verifyOtp() async{

if(pin == null){
  ShowMessage.showSnackBar('msg', 'Please enter otp');
}else {
      setBusy(true);
      try {
        Map<String, String> body = {};
        body[RequestKeys.mobile] = mobile ?? "";
        body[RequestKeys.Otp] = pin ?? '';

        VerifyOtpResponse res = await api.verifyOTPApi(body);
        if (!(res.error ?? true)) {
          Get.offAllNamed(loginScreen);
          ShowMessage.showSnackBar('Server Res', '${res.message}');

          setBusy(false);
          update();
        }
      } catch (e) {
        ShowMessage.showSnackBar('Server Res', '$e');
      } finally {
        setBusy(false);
        update();
      }
    }
  }





}

