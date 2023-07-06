import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Controller/customer_drawer_controller.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import '../../../Utils/colors.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  OtpFieldController otpController = OtpFieldController();

  int? otp;
  bool pass = false;
  bool confirmPass = false;
  bool show = false;

  sendOtp() async {
    var uri = Uri.parse(forgotSendOtpApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
     request.fields['mobile'] = mobileController.text.toString();

    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    bool? error = userData['error'];
    String? message = userData['message'];

    if(error == false){
      setState(() {
        otp = userData['otp'];
        show = true;
      });
      Fluttertoast.showToast(msg: message.toString());
    }else{
      Fluttertoast.showToast(msg: message.toString());
    }

    // setState(() {
    //   eventList = EventTypeModel.fromJson(userData).categories!;
    // });
  }

  changePassword() async {
    var uri = Uri.parse(updatePasswordApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['mobile'] = mobileController.text.toString();
    request.fields['otp'] = otp.toString();
    request.fields['password'] = passwordController.text.toString();
    request.fields['confirm_password'] = confirmPassController.text.toString();

    print("this is reuest $updatePasswordApi ${request.fields}");
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    bool? error = userData['error'];
    String? message = userData['message'];

    if(error == false){
      Fluttertoast.showToast(msg: message.toString());
      Navigator.pop(context);
    }else{
      Fluttertoast.showToast(msg: message.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ForGotPasswordController(),
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.AppbtnColor,
                  )),
              backgroundColor: AppColors.secondary,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text("Forgot Password",
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.AppbtnColor,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.secondary,
            body: SingleChildScrollView(
              child: Form(
                // key: controller.formkey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 40,),

                      show ? SizedBox.shrink()
                      :
                          Column(
                            children: [
                              Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width ,
                                  decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    maxLength: 10,
                                    validator: (password) {
                                      if (mobileController.text.isEmpty){
                                        return 'Enter a valid Mobile Number';
                                      }
                                    },
                                    controller:
                                    mobileController,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 8),
                                        counterText: '',
                                        border: InputBorder.none,
                                        // prefixIcon: Icon(
                                        //   Icons.call,
                                        //   color: AppColors.greyColor,
                                        // ),
                                        hintText: 'Enter Mobile Number',hintStyle: TextStyle(color: AppColors.whit)
                                    ),
                                  )),

                              Padding(
                                padding: const EdgeInsets.only(left:70.0,right: 70, top: 40),
                                child: GestureDetector(
                                  onTap: () {
                                    if(mobileController.text.isNotEmpty && mobileController.text.length > 9){
                                      sendOtp();
                                    }else{
                                      Fluttertoast.showToast(msg: "Enter valid mobile number!");
                                    }
                                  },
                                  child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width /1.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: AppColors.AppbtnColor,
                                      ),
                                      child: const Center(
                                        child: Text("Submit",
                                            style: TextStyle(color: AppColors.whit)),
                                      )),
                                ),
                              ),
                            ],
                          ),
                      show ?
                      Column(
                        children: [
                          Text(otp.toString(), style: TextStyle(color: AppColors.whit, fontSize: 16, fontWeight: FontWeight.w600),),
                          Padding(
                            padding: const EdgeInsets.only(left:40.0,right:40, top: 20),
                            child: OTPTextField(
                              controller: otpController,
                              otpFieldStyle: OtpFieldStyle(backgroundColor:AppColors.primary,borderColor:AppColors.primary),
                              length: 4,
                              keyboardType: TextInputType.number,
                              width: MediaQuery.of(context).size.width,
                              fieldWidth: 60,
                              style: const TextStyle(fontSize: 17,color: AppColors.whit),
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              fieldStyle: FieldStyle.box,
                              onCompleted: (pin) {
                                print("Completed: " + pin);
                                pin = pin ;
                              },
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            width: MediaQuery.of(context).size.width,
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
                                obscureText: pass,
                                controller: passwordController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusColor: Colors.white,
                                    hintText: "Password",
                                    hintStyle:
                                    const   TextStyle(color: AppColors.whit),
                                    // prefixIcon: const Icon(
                                    //   Icons.lock_open_outlined,
                                    //   color: Colors.grey,
                                    // ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          pass = !pass;
                                        });
                                        // controller.update();
                                      },
                                      child: pass ? const Icon(
                                        Icons.visibility,
                                        color: AppColors.whit,
                                      ) : const Icon(
                                        Icons.visibility_off,
                                        color: AppColors.whit,
                                      ),
                                    ))),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            padding: const EdgeInsets.only(left: 8),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return 'Please enter valid password';
                                  }
                                },
                                style: const TextStyle(color: AppColors.whit),
                                keyboardType: TextInputType.text,
                                obscureText: confirmPass,
                                controller: confirmPassController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusColor: Colors.white,
                                    hintText: "Confirm Password",
                                    hintStyle:
                                    const   TextStyle(color: AppColors.whit),

                                    // prefixIcon: const Icon(
                                    //   Icons.lock_open_outlined,
                                    //   color: Colors.grey,
                                    // ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          confirmPass =
                                          !confirmPass;
                                        });
                                        // controller.update();
                                      },
                                      child: confirmPass ? const Icon(
                                        Icons.visibility,
                                        color: AppColors.whit,
                                      ) : const Icon(
                                        Icons.visibility_off,
                                        color: AppColors.whit,
                                      ),
                                    ))),
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left:70.0,right: 70),
                            child: GestureDetector(
                              onTap: () {
                                if(passwordController.text == confirmPassController.text){
                                  changePassword();
                                }else{
                                  Fluttertoast.showToast(msg: "Password and confirm password must be same!");
                                }
                              },
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width /1.5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: AppColors.AppbtnColor,
                                  ),
                                  child: const Center(
                                    child: Text("Change Password",
                                        style: TextStyle(color: AppColors.whit)),
                                  )),
                            ),
                          ),
                        ],
                      )
                          : SizedBox.shrink()
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
