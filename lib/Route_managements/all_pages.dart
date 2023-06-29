import 'package:get/get.dart';
import 'package:kolazz_book/Route_managements/routes.dart';
import 'package:kolazz_book/Route_managements/screen_bindings.dart';
import 'package:kolazz_book/Views/Subscription/Subscription_screen.dart';
import 'package:kolazz_book/Views/authView/forgot_password/forgot_password_view.dart';
import 'package:kolazz_book/Views/authView/otp/otp_view.dart';
import 'package:kolazz_book/Views/dashboard/Dashboard.dart';
import 'package:kolazz_book/Views/intro_sliders.dart';
import 'package:kolazz_book/Views/tnc&privacy/faq_screen.dart';
import 'package:kolazz_book/Views/tnc&privacy/tnc.dart';

import '../Views/Add_Quotation/MoreQuatations.dart';
import '../Views/authView/login/login_view.dart';
import '../Views/authView/signup/signup_view.dart';
import '../Views/help/help&support.dart';
import '../Views/splash/splash_screen.dart';
import '../Views/tnc&privacy/aboutus.dart';
import '../Views/tnc&privacy/privacy_policy.dart';

class AllPages {
  static List<GetPage> getPages() {
    return [
      GetPage(
          name: splashScreen,
          page: () => const SplashScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: loginScreen,
          page: () => const LoginScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: signupScreen,
          page: () =>  SignupScreen(),
          binding: ScreenBindings()),
      GetPage(
          name: otpScreen,
          page: () => OtpScreen(),
          binding: ScreenBindings()),
      // GetPage(
      //     name:forgotPasswordScreen,
      //     page: () =>ForgotPasswordScreen(),
      //     binding: ScreenBindings()),

      GetPage(
          name:dashbord,
          page: ()=>DashBoard(),
          binding: ScreenBindings()),
      GetPage(
          name:introScreen,
          page: ()=>IntroSlider(),
          binding: ScreenBindings()),

      GetPage(
          name:privacypolicyScreen,
          page: ()=>PrivacyPolicy()),
      GetPage(
          name:tncscreen,
          page: ()=>TermandConidion()),
      GetPage(
          name:abutusscreen,
          page: ()=>AboutUsScreen()),
      GetPage(
          name:faqscreen,
          page: ()=>FaqScreen()),
      GetPage(
          name:helpScreen,
          page: ()=>HelpandSupport()),
      GetPage(
          name:subscriptionScreen,
          page: ()=>SubscriptionScreen()),
      GetPage(
          name:moreQuotations,
          page: ()=>MoreQuatations()),

    ];
  }
}
