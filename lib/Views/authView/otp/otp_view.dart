import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Models/resister_user_response.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:kolazz_book/Widgets/show_message.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../../Controller/otp_controller.dart';
import '../../../Route_managements/routes.dart';
import '../../../Services/api.dart';
import '../../../Utils/colors.dart';
import '../login/login_view.dart';


class OtpScreen extends StatefulWidget {
  final int? otp;
  final String? fName, lName, email, password, mobile;
  const OtpScreen({Key? key, this.otp, this.fName, this.lName, this.email, this.password, this.mobile}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  OtpFieldController otpController = OtpFieldController();
  String pin = '';
  Api api = Api() ;
  RegisterUserData? registerData;

  int? newOtp;
  sendOtpSignUp(BuildContext context) async {

    var uri = Uri.parse(forgotSendOtpApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.mobile] = widget.mobile.toString();
    request.fields[RequestKeys.name] = widget.fName.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if(userData['error'] == false){
      Fluttertoast.showToast(msg: "${userData['message']}");
      setState(() {
        newOtp = userData['otp'];
      });

    }else{
      Fluttertoast.showToast(msg: "${userData['message']}");
    }


    // var finalResult = BroadcastListModel.fromJson(userData);
    //
    // setState(() {
    //   message = finalResult.leftMessage.toString();
    //   broadCastList = BroadcastListModel.fromJson(userData).data!;
    // });
    // print("this is my message ${finalResult.leftMessage}");
  }


  Future<void> registerUser(BuildContext context, fName, lName, mobile, email, pass) async {

    var uri = Uri.parse(userRegisterApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.fields[RequestKeys.fname] = fName.toString();
    request.fields[RequestKeys.lname] = lName.toString();
    request.fields[RequestKeys.mobile] = mobile.toString();
    request.fields[RequestKeys.password] = pass.toString();
    request.fields[RequestKeys.Cpassword] = pass.toString();
    request.fields[RequestKeys.email] =   email.toString();
    request.headers.addAll(headers);

    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    if(userData['error'] == false){
      ShowMessage.showSnackBar('Server Res', userData['message'] ?? '');
      Get.toNamed(loginScreen);

    }else{
      ShowMessage.showSnackBar('Server Res', userData['message'] ?? '');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.otp != null || widget.otp != 0){
      newOtp = widget.otp!;
    }
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: OtpController(),
      builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.secondary,
          leading: InkWell(
              onTap: () {
                controller.back();
              },
              child: Icon(Icons.arrow_back_ios,color:AppColors.AppbtnColor,)),
        ),
        backgroundColor: AppColors.secondary,
        body: Column(
            children: [
              SizedBox(height: 30,),
              const Text('Verification',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColors.AppbtnColor),),
              const SizedBox(height:50,),
              const Text('OTP has been Send to ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.whit),),
              const SizedBox(height: 5,),
              Text('+91 ${widget.mobile}',style: const TextStyle(fontSize: 21,fontWeight: FontWeight.w500,color: AppColors.whit),),
              const SizedBox(height: 5,),
               Text('OTP - ${newOtp.toString()}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.whit),),
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left:40.0,right:40),
                child: OTPTextField(
                  controller:controller.otpController,
                  otpFieldStyle: OtpFieldStyle(backgroundColor:AppColors.primary,borderColor:AppColors.primary),
                  length: 4,
                  keyboardType: TextInputType.number,
                  width: MediaQuery.of(context).size.width,
                  fieldWidth: 60,
                  style: const TextStyle(fontSize: 17,color: AppColors.whit),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (val) {
                    print("Completed: " + val);
                    setState(() {
                      pin = val ;
                    });
                  },
                ),
              ),
              const SizedBox(height: 40,),
              const Text('Have not Received the varification code?',style: TextStyle(fontSize:18,fontWeight: FontWeight.w400,color: AppColors.whit),),
              TextButton(
                  onPressed:(){
                   sendOtpSignUp(context);

                 },
                  child:const Text('Resend',style: TextStyle(color: AppColors.AppbtnColor,fontWeight: FontWeight.w500,fontSize: 18,decoration: TextDecoration.underline),)),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:40.0,right:40),
                child: InkWell(
                  onTap: () {
                    print("this is my ${widget.otp} qnad ${pin}");
                    if(widget.otp.toString() == pin){
                     registerUser(context, widget.fName, widget.lName, widget.mobile, widget.email, widget.password);
                    }else{
                      Fluttertoast.showToast(msg: "Please enter valid OTP!");
                    }
                   // controller.verifyOtp();
                    //Navigator.push(context,MaterialPageRoute(builder: (context)=>BottomBar()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.AppbtnColor,
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child:const Center(
                          child: Text("Verify Authentication Code",style: TextStyle(
                              color: AppColors.whit
                          )
                          ),
                        )
                    ),
                  ),
                ),
              )
            ]),
      );
    },);
  }
}
