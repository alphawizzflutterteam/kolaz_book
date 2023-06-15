import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../Controller/otp_controller.dart';
import '../../../Utils/colors.dart';
import '../login/login_view.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

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
              Text('+91 ${controller.Mobile}',style: const TextStyle(fontSize: 21,fontWeight: FontWeight.w500,color: AppColors.whit),),
              const SizedBox(height: 5,),
              Text('OTP - ${controller.Otp}',style: const TextStyle(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.whit),),
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
                  onCompleted: (pin) {
                    print("Completed: " + pin);
                    controller.pin = pin ;
                  },
                ),
              ),
              const SizedBox(height: 40,),
              const Text('Have not Received the varification code?',style: TextStyle(fontSize:18,fontWeight: FontWeight.w400,color: AppColors.whit),),
              TextButton(
                  onPressed:(){
                    controller.onTapResend();
                 },
                  child:const Text('Resend',style: TextStyle(color: AppColors.AppbtnColor,fontWeight: FontWeight.w500,fontSize: 18,decoration: TextDecoration.underline),)),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left:40.0,right:40),
                child: InkWell(
                  onTap: () {
                   controller.verifyOtp();
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
