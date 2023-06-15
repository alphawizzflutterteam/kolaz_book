import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/edit_profile_controller.dart';
import '../../Utils/colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EditProfileController(),
      builder: (controller) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.backgruond,
          // appBar: AppBar(
          //   leading: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF ),),
          //   backgroundColor: Color(0xff303030),
          //   actions: const [
          //     Padding(
          //       padding: EdgeInsets.all(15),
          //       child: Center(child: Text("Profile Setting", style: TextStyle(fontSize: 15, color:Color(0xff1E90FF ), fontWeight: FontWeight.bold), )),
          //     ),
          //   ],
          // ),
          body:
          controller.profiledata != null || controller.profiledata == "" ?  SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    height: 130,
                    child: Stack(children: [
                      Container(
                        color: AppColors.secondary,
                        height: 80,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 18.0,right: 10,left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.arrow_back_ios,size: 30, color: Color(0xff1E90FF ),)),
                              Text("Profile Setting",style: TextStyle(color: AppColors.AppbtnColor,fontSize: 16),)
                            ],),
                        ),
                      ),
                      Positioned(
                        top: 40 ,
                        left: 0,
                        right: 0,
                        child: Column(children: [
                          GestureDetector(
                            onTap: (){
                              controller.requestPermission(context,1);
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child:controller.imageFile != null || controller.imageFile == "" ? Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                      child: Image.file(controller.imageFile!,fit: BoxFit.fill,height: 90,width: 95,)):Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(50)),
                                      child: Image.asset("assets/images/loginlogo.png",fit: BoxFit.fill,height: 90,width: 95,))
                                ),
                                Positioned(
                                    top: 65,
                                    left: 60,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(13)),
                                        height: 25,width: 25,
                                        child: Icon(Icons.edit)))

                              ],),
                          ),
                          // SizedBox(height: 10,),

                        ],),)
                    ],),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    child: Column(
                      children: [
                        Text("${controller.firstname} ${controller.lastname}", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xff1E90FF)),),
                        SizedBox(height: 5,),
                        Text("ID-001", style: TextStyle(fontSize: 15, color: Colors.white),),
                        Padding(
                          padding: const EdgeInsets.only(left: 80),
                          child: Row(
                            children: [
                              Text("Subscripation 14 Days Free Trial", style: TextStyle(fontSize: 15, color: Colors.white),),
                              SizedBox(width: 6,),
                              Text("Buy", style: TextStyle(fontSize: 15, color: Color(0xff1E90FF), decoration: TextDecoration.underline,),)
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff303030)),
                            height: 50,
                            width: MediaQuery.of(context).size.width/1.1,
                            child: Center(child: Text("Your Details", style: TextStyle(fontSize: 18, color: Color(0xff1E90FF))))
                        ),
                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.only(left: 13, right: 55),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("First Name", style: TextStyle(color: Color(0xffCCCCCC)),),
                              // SizedBox(width: 15),
                              Text("Last Name(Surname)", style: TextStyle(color: Color(0xffCCCCCC)),)
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/2.2,
                                    child: Card(
                                      color:  Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.firstnameController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: '',
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                // SizedBox(width: 0.5,),
                                Container(
                                  width: MediaQuery.of(context).size.width/2.2,
                                  child: Card(
                                    color: Color(0xff6D6A6A),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 5,
                                    child: TextFormField(
                                      controller: controller.lastnameController,
                                      keyboardType: TextInputType.name,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter first name';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: '',
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(left: 10)
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 9,),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Phone Number(Not Editable)", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC))),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.mobileController,
                                        keyboardType: TextInputType.number,
                                        readOnly: true,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text("Email Id", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.emailController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xff303030)),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Center(
                                      child: Text("Company Details", style: TextStyle(fontSize: 14, color:  Color(0xff1E90FF), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  SizedBox(width: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.companynameController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Company Name',
                                            hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.companyphoneController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Company Phone Number',
                                            hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.companyaddressController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Company Address',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.countryController,
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            hintText: 'Country',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5,),

                                  InkWell(
                                    onTap: (){
                                      controller.requestPermission(context,2);
                                    },
                                    child: Container(
                                      height: 100,
                                      width: MediaQuery.of(context).size.width/1.1,
                                      child: Card(
                                        color: Color(0xff6D6A6A),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        elevation: 5,
                                        child: controller.imageFile2 != null || controller.imageFile2 == "" ? Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                            child: Image.file(controller.imageFile2!,fit: BoxFit.fill,height: 80,)) : Center(child: const Text("Upload Company Logo",style: TextStyle(fontSize: 18),))
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Company Website Link/ Email Id", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.companyEmailController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Enter Link / Email Id',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("FaceBook Page Link", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.facebookController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Paste here facebook page link',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text("Instagram Page Link", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.instagramController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Paste here instagram page link',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Youtube Channel Link", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.youtubeController,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Paste here Youtube Channel link',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Terms & Condition For Quotation PDF", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.1,
                                    child: Card(
                                      color: Color(0xff6D6A6A),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      elevation: 5,
                                      child: TextFormField(
                                        controller: controller.termsconditionControlletr,
                                        keyboardType: TextInputType.name,
                                        decoration: InputDecoration(
                                            hintText: 'Paste here from Notepad/ Text File',hintStyle: TextStyle(color: AppColors.whit),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(left: 10)
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                    onTap: (){
                      if (_formKey.currentState!.validate()) {
                        controller.updateProfile();
                      } else {
                        // Form is invalid, display error message
                      }

                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width/2.2,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xff1E90FF)),
                      child: Center(child: Text("Edit / Update",
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
                      ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ),
          ): Center(child: CircularProgressIndicator())
        ),
      );
    },);
  }
}
