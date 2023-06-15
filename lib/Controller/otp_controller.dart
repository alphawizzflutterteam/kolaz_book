
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kolazz_book/Controller/signup_controller.dart';
import 'package:kolazz_book/Models/first_veryfy_otp_response.dart';
import 'package:kolazz_book/Route_managements/routes.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/verify_otp.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class OtpController extends AppBaseController{

   String? Otp;
   String? Mobile;
   String ? pin;
OtpFieldController otpController = OtpFieldController();

final registerUserController = Get.put(SignupController());


   ResendOtpResponse? verifyOtpResponse;
   VerifyOtpResponse? otpResponse;
@override
  Future<void> onInit() async {
    // TODO: implement onInit
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Otp = prefs.getString('otp');
  Mobile = prefs.getString('mobile');
  super.onInit();
  }
  
  
  
  
  Future<void>onTapBottombar()async {
  Get.toNamed(dashbord);
  }




void onTapResend() async{

  setBusy(true);
  try {
    Map<String, String> body = {};
    body[RequestKeys.mobile] = Mobile ?? "";

    ResendOtpResponse res = await api.resendOTPApi(body);
    if (!(res.error ?? true)) {
      verifyOtpResponse = res;

      setBusy(false);
      Otp = verifyOtpResponse?.otp.toString();

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
        body[RequestKeys.mobile] = Mobile ?? "";
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

