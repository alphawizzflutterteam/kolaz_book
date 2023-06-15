import 'package:get/get.dart';

import '../Controller/splash_controller.dart';
import '../Views/authView/login/login_view.dart';
import '../Views/authView/otp/otp_view.dart';
import '../Views/authView/signup/signup_view.dart';

class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => SplashController());
     Get.lazyPut(() => const LoginScreen());
     Get.lazyPut(() =>  SignupScreen() );
    // Get.lazyPut(() =>  const BottomBar() );
     Get.lazyPut(() =>  const OtpScreen());
     //Get.lazyPut(() =>  const ForgotPasswordScreen() );
    // Get.lazyPut(() =>  const PortfolioScreen() );
    // Get.lazyPut(() =>  const IntroScreen() );

  }


}