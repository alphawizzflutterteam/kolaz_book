import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Controller/edit_profile_controller.dart';
import '../../Controller/helpController.dart';
import '../../Utils/colors.dart';

class HelpandSupport extends StatefulWidget {
  const HelpandSupport({Key? key}) : super(key: key);

  @override
  State<HelpandSupport> createState() => _HelpandSupportState();
}

class _HelpandSupportState extends State<HelpandSupport> {


  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: EditProfileController(),
      builder: (controller) {
        return Scaffold(
          bottomSheet: InkWell(
            onTap: (){
              controller.sendHelpSupportMessage(context);
            },
            child: Container(
              padding: EdgeInsets.all(15),
              height: 70,
              width: MediaQuery.of(context).size.width / 1,
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 1.3,
                decoration: BoxDecoration(boxShadow: const [
                  BoxShadow(
                    offset: Offset(1, 2),
                    blurRadius: 1,
                    color: AppColors.greyColor,
                  )
                ],
                    borderRadius: BorderRadius.circular(40),
                    color: AppColors.pdfbtn),
                child: const Center(
                  child: Text("Send",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whit)),
                ),
              ),
            ),
          ),
            backgroundColor: AppColors.primary,
            appBar: AppBar(
              leading: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios, color: AppColors.AppbtnColor)),
              backgroundColor: Color(0xff303030),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(child: Text("Help & Support",
                      style: TextStyle(fontSize: 16, color:AppColors.AppbtnColor, fontWeight: FontWeight.bold)
                  )),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("First Name", style: TextStyle(color: Color(0xffCCCCCC)),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2.4,
                              child: Card(
                                color:  Color(0xff6D6A6A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: controller.firstnameController,
                                  keyboardType: TextInputType.name,
                                  decoration: const InputDecoration(
                                      hintText: '',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 10)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:  EdgeInsets.only(left: 8.0),
                              child: Text("Last Name(Surname)", style: TextStyle(color: Color(0xffCCCCCC)),),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2.3,
                              child: Card(
                                color: Color(0xff6D6A6A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: TextFormField(
                                  readOnly: true,
                                  controller: controller.lastnameController,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter first name';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: '',
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(left: 10)
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("Email Id", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width/1.0,
                    child: Card(
                      color: Color(0xff6D6A6A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: TextFormField(
                        readOnly: true,
                        controller: controller.emailController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            hintStyle: TextStyle(color: AppColors.whit),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10)
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text("Message", style: TextStyle(fontSize: 14, color: Color(0xffCCCCCC)),),
                  ),

                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width/1.0,
                    child: Card(
                      color: Color(0xff6D6A6A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: TextFormField(
                        controller: controller.messageController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          // hintText: 'Message',
                            hintStyle: TextStyle(color: AppColors.whit),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 10)
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // body: Container(
            //   child: ListView.builder(
            //     itemCount: controller.getPlan.length ,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
            //         child: Card(
            //           color: AppColors.cardclr,
            //           child:
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            //             child: Column(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   // Text("${controller.getfaq[index].id} " ?? '',style: TextStyle(color: AppColors.textclr),),
            //                   Text("${controller.getPlan[index].title}",style: TextStyle(color: AppColors.textclr),),
            //                   Text("${controller.getPlan[index].description}",style: TextStyle(color: AppColors.textclr),),
            //                   Text("${controller.getPlan[index].price}",style: TextStyle(color: AppColors.textclr),)
            //                 ]
            //             ),
            //           ),),
            //       );
            //     },
            //   ),
            // )
        );
      },);
  }
}
