// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../Models/forgot_password.dart';
// import '../Route_managements/routes.dart';
// import '../Services/request_keys.dart';
// import '../Widgets/show_message.dart';
// import 'appbased_controller/appbase_controller.dart';
//
// class ForGotPasswordController extends AppBaseController {
//
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passController = TextEditingController();
//   final formkey = GlobalKey<FormState>();
//
//   int value1 = 0;
//
//   ForgotPassword? userData;
//
//   Future<void>Resetpassword() async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.email] = emailController.text.trim();
//
//       ForgotPassword res = await api.resetPasswordApi(body);
//       if (!(res.status == 1)) {
//         String?   userData =res.msg ;
//         print('this is message------>${userData}');
//
//         ShowMessage.showSnackBar('Server Res', res.msg ?? '');
//         setBusy(false);
//         Get.toNamed(loginScreen);
//         update();
//       }
//
//     } catch (e) {
//       ShowMessage.showSnackBar('Server Res', '$e');
//     } finally {
//       setBusy(false);
//       update();
//     }
//   }
//
//
// }