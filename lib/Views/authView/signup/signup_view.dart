import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/signup_controller.dart';
import '../../../Utils/colors.dart';

class SignupScreen extends StatelessWidget {
   SignupScreen({Key? key}) : super(key: key);



  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final setHeight = MediaQuery.of(context).size.height;
    final setWidth = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: SignupController(),
      builder: (controller) {
      return Scaffold(
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
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:130.0,top:50),
                            child: Image.asset('assets/images/loginlogo.png',height:70,width:70,),
                          ),
                          const SizedBox(
                            height:20,
                          ),
                          const Text(
                            "Create Account",
                            style: TextStyle(
                                color: AppColors.whit,
                                fontWeight:
                                FontWeight.w400,
                                fontSize: 22),
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width:setWidth/2.3,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                    validator: (val){
                                      if(val!.isEmpty){
                                        return 'Please enter your name';
                                      }
                                    },
                                    style: TextStyle(color: AppColors.whit),
                                    keyboardType:
                                    TextInputType.text,
                                    controller:
                                    controller.firstnameController,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusColor: Colors.white,
                                      counterText: '',
                                      hintText: "Name",hintStyle: TextStyle(color: AppColors.whit),
                                      //add prefix icon
                                      prefixIcon: Icon(
                                        Icons.person,size:30,
                                        color: Colors.grey,
                                      ),
                                    )),
                              ),
                              // const SizedBox(width:15,),
                              Container(
                                width:setWidth/2.3,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:15.0),
                                  child: TextFormField(
                                      validator: (val){
                                        if(val!.isEmpty){
                                          return 'Please enter last name';
                                        }
                                      },
                                      style: TextStyle(color: AppColors.whit),
                                      keyboardType:
                                      TextInputType.text,
                                      controller:
                                      controller.lastnameController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        focusColor: Colors.white,
                                        counterText: '',
                                        hintText: "Last Name",hintStyle: TextStyle(color: AppColors.whit,),
                                        //add prefix icon
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: setWidth/1,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty){
                                    return 'Please enter valid password';
                                  }
                                },
                                style: const TextStyle(color: AppColors.whit),
                                keyboardType: TextInputType.text,
                                controller:
                                controller.emailController,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    focusColor: Colors.white,
                                    hintText: "Email Id",hintStyle: TextStyle(color: AppColors.whit),
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.grey,
                                    ),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: setWidth/1,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                                validator: (val){
                                  if(val!.isEmpty){
                                    return 'Please enter valid password';
                                  }
                                },
                                style: const TextStyle(color: AppColors.whit),
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                controller:
                                controller.mobileController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  focusColor: Colors.white,
                                  counterText: '',
                                  hintText: "Mobile No.",hintStyle: TextStyle(color: AppColors.whit),
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.grey,
                                  ),
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: setWidth/1,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(

                                validator: (val){
                                  if(val!.isEmpty){
                                    return 'Please enter valid password';
                                  }
                                },
                                style: TextStyle(color: AppColors.whit),
                                obscureText: controller.isVisible,
                                keyboardType: TextInputType.text,
                                controller:
                                controller.passwordController,
                                decoration:  InputDecoration(
                                  border: InputBorder.none,
                                  focusColor: Colors.white,
                                  hintText: "Password",hintStyle: TextStyle(color: AppColors.whit),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      controller.isVisible = !controller.isVisible ;
                                      controller.update() ;
                                    },
                                    child:controller.isVisible ? Icon(Icons.visibility,color: AppColors.whit,)
                                        : const Icon(Icons.visibility_off,color: AppColors.whit,) ,)
                                )),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: setWidth/1,
                            decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(5)),
                            child: TextFormField(
                                validator: (val){
                                  if(controller.passwordController.text != val){
                                    return 'Password does not match';
                                  }
                                },
                                style: const TextStyle(color: AppColors.whit),
                                keyboardType: TextInputType.text,
                                obscureText: controller.isVisible2,
                                controller:
                                controller.cPasswordController,
                                decoration:  InputDecoration(
                                  border: InputBorder.none,
                                  focusColor: Colors.white,
                                  hintText: "Confirm Password",hintStyle: TextStyle(color: AppColors.whit),
                                  prefixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.grey,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      controller.isVisible2 = !controller.isVisible2 ;
                                      controller.update() ;
                                    },
                                    child:controller.isVisible2 ? Icon(Icons.visibility,color: AppColors.whit,)
                                        : const Icon(Icons.visibility_off,color: AppColors.whit,) ,)
                                )),
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Transform.scale(
                                scale: 1.1,
                                child: Checkbox(
                                  activeColor: AppColors.whit,
                                  checkColor: AppColors.AppbtnColor,
                                   fillColor: MaterialStateColor.resolveWith((states) =>AppColors.whit),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
                                  value:controller.isCheck,onChanged: (value) {
                                      controller.isCheck=!controller.isCheck;
                                      controller.update();
                                },),
                              ),
                              const Text('I Agree To All',style:TextStyle(color: AppColors.whit,fontSize: 13,),),
                              const SizedBox(width: 2,),
                              const Text('Term & Condition',style:TextStyle(color: AppColors.AppbtnColor,fontSize: 13,fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),),
                              const Text(' And',style:TextStyle(color: AppColors.whit,fontSize: 13,),),
                              const Text(' Privacy',style:TextStyle(color: AppColors.AppbtnColor,fontSize: 13,fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () {
                              if(_formKey.currentState!.validate()) {
                                  controller.registerUser();
                                }
                              },
                            child: Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Container(
                                  height: 50,
                                  decoration:
                                  BoxDecoration(
                                    color: AppColors.AppbtnColor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child:  Center(
                                    child: controller.isBusy ? const Center(child: CircularProgressIndicator(
                                      color: AppColors.whit,),) : const Text("Sign Up",
                                        style: TextStyle(
                                            color: AppColors
                                                .whit)),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height:40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(color: AppColors.whit)),
                    InkWell(
                      onTap: () {
                       controller.tapOnLoginButton();
                      },
                      child: const Text(
                        " Log In",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColors.AppbtnColor,fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:20,),
              ],
            ),
          ));
    },);
  }
}
