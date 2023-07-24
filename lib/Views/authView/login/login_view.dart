import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Models/forgot_password.dart';
import 'package:kolazz_book/Views/authView/forgot_password/forgot_password_view.dart';

import '../../../Controller/login_controller.dart';
import '../../../Route_managements/routes.dart';
import '../../../Utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    // final setHeight = MediaQuery
    //     .of(context)
    //     .size
    //     .height;
    final setWidth = MediaQuery
        .of(context)
        .size
        .width;
    return GetBuilder(
      init: LoginController(),

      builder: (controller) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.secondary,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/images/loginlogo.png',
                                  height: 70,
                                  width: 70,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              const Text(
                                "Login",
                                style: TextStyle(
                                    color: AppColors.whit,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: setWidth / 1,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please enter valid number';
                                      }
                                    },
                                    style: const TextStyle(
                                        color: AppColors.whit),
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
                                    controller: controller.mobileController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusColor: Colors.white,

                                      counterText: '',
                                      hintText: "Mobile",
                                      hintStyle:
                                      TextStyle(color: AppColors.whit),
                                      //add prefix icon
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: setWidth / 1,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please enter valid password';
                                      }
                                    },
                                    style: TextStyle(color: AppColors.whit),
                                    keyboardType: TextInputType.text,
                                    obscureText: controller.isVisible,
                                    controller: controller.passwordController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusColor: Colors.white,
                                        hintText: "Password",
                                        hintStyle:
                                        TextStyle(color: AppColors.whit),
                                        prefixIcon: Icon(
                                          Icons.lock_open_outlined,
                                          color: Colors.grey,
                                        ),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            controller.isVisible =
                                            !controller.isVisible;
                                            controller.update();
                                          },
                                          child: controller.isVisible ? Icon(
                                            Icons.visibility,
                                            color: AppColors.whit,
                                          ) : Icon(
                                            Icons.visibility_off,
                                            color: AppColors.whit,
                                          ),
                                        ))),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     controller.onTapForgotpass();
                              //   },
                              //   child: const Align(
                              //       alignment: Alignment.topRight,
                              //       child: Text(
                              //         "Forget Password?",
                              //         style: TextStyle(
                              //             color: AppColors.whit,
                              //             fontWeight: FontWeight.normal,
                              //             fontSize: 15),
                              //       )),
                              // ),
                              // const SizedBox(
                              //   height: 40,
                              // ),
                              InkWell(
                                onTap: () {

                                  if (_formKey.currentState!.validate()) {
                                     //Get.toNamed(dashbord);
                                     controller.loginUser();
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: AppColors.AppbtnColor,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Center(
                                        child: controller.isBusy
                                            ? const Center(
                                          child:
                                          CircularProgressIndicator(
                                            color: AppColors.whit,
                                          ),
                                        )
                                            : const Text("Log In",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors.whit)),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));

                        }, child: const Text("Forget Password?",
                          style: TextStyle(color: AppColors.whit, fontWeight: FontWeight.w600, decoration: TextDecoration.underline),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 150,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?",
                            style: TextStyle(color: AppColors.whit)),
                        InkWell(
                          onTap: () {
                            controller.onTapSingup();
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => SignupScreen()));
                          },
                          child: const Text(
                            " Sign Up",
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.AppbtnColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }
}
