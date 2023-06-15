// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import '../../../Controller/forgot_password_controller.dart';
// import '../../../Utils/colors.dart';
//
//
// class ForgotPasswordScreen extends StatelessWidget {
//   const ForgotPasswordScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: ForGotPasswordController(),
//       builder: (controller) {
//         return SafeArea(
//           child: Scaffold(
//             backgroundColor: AppColors.secondary,
//             body: SingleChildScrollView(
//               child: Form(
//                 key: controller.formkey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 40,),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 50.0,right: 50),
//                       child: Text(
//                         'Forgot Password',
//                         style: TextStyle(
//                             color: AppColors.whit, fontWeight: FontWeight.w500,fontSize: 20),
//                       ),
//                     ),
//                      const Padding(
//                        padding: EdgeInsets.only(left: 30.0,right: 30,top:50),
//                        child: Text(
//                         'Email id',
//                         style: TextStyle(
//                             color: AppColors.whit, fontWeight: FontWeight.w500),
//                     ),
//                      ),
//                     Padding(
//                       padding: const EdgeInsets.only(left:30.0,top:10),
//                       child: Container(
//                           height: 50,
//                           width: MediaQuery.of(context).size.width / 1.2,
//                           decoration: BoxDecoration(
//                               color: AppColors.primary,
//                               borderRadius: BorderRadius.circular(5)),
//                           child: TextFormField(
//                             validator: (password) {
//                               if (controller.emailController.text.isEmpty){
//                                 return 'Enter a valid Email';
//                               }
//                             },
//                             controller:
//                             controller.emailController,
//                             decoration: const InputDecoration(
//                               border: InputBorder.none,
//                               prefixIcon: Icon(
//                                 Icons.person,
//                                 color: AppColors.greyColor,
//                               ),
//                               hintText: 'Enter Email',hintStyle: TextStyle(color: AppColors.whit)
//                             ),
//                           )),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//
//
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left:70.0,right: 70),
//                       child: GestureDetector(
//                         onTap: () {
//                           if(controller.formkey.currentState!.validate()){
//                             if(controller.emailController.text.isEmpty){
//                                const SnackBar(content: Text('Enter valid credential'));
//                             }else{
//                               //controller.
//                             }
//
//                           }
//                           const SnackBar(content: Text('Password Changed'));
//                          controller.Resetpassword();
//
//                         },
//                         child: Container(
//                             height: 50,
//                             width: MediaQuery.of(context).size.width /1.5,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: AppColors.AppbtnColor,
//                             ),
//                             child: const Center(
//                               child: Text("Submit",
//                                   style: TextStyle(color: AppColors.whit)),
//                             )),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
