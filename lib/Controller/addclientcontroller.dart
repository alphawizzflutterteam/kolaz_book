// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import '../Models/add_clientmodel.dart';
// import '../Models/add_photographermodel.dart';
// import '../Services/request_keys.dart';
// import '../Widgets/show_message.dart';
// import 'appbased_controller/appbase_controller.dart';
//
// class addClientController extends AppBaseController {
//
//
//   TextEditingController firstnameController = TextEditingController();
//   TextEditingController lastnameController = TextEditingController();
//   TextEditingController mobileController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//
//   final formkey = GlobalKey<FormState>();
//
//   int value1 = 0;
//
//   String? clientdata;
//   Addclientmodel? addClient;
//
//   Future<void>AddClient() async {
//     setBusy(true);
//     try {
//       Map<String, String> body = {};
//       body[RequestKeys.firstname] = firstnameController.text.trim();
//       body[RequestKeys.lastname] = lastnameController.text.trim();
//       body[RequestKeys.city] = cityController.text.trim();
//       body[RequestKeys.mobile] = mobileController.text.trim();
//
//
//       AddPhotographer res = await api.addPhotographeApi(body);
//       if (!(res.error ?? true)) {
//         clientdata =res.message ;
//         print('this is message------>${res.message}');
//         Fluttertoast.showToast(msg:res.message ?? '' );
//         ShowMessage.showSnackBar('Server Res', res.message ?? '');
//         setBusy(false);
//         Get.back();
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
//   void onTapClear(){
//     firstnameController.clear();
//     lastnameController.clear();
//     mobileController.clear();
//     cityController.clear();
//
//   }
//
// }