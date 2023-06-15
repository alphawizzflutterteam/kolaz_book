import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kolazz_book/Utils/colors.dart';

import '../../Controller/faq_controller.dart';


class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FaqController(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.primary,
          appBar: AppBar(
            leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
            backgroundColor: Color(0xff303030),
            actions: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Center(child: Text("FAQ's",
                    style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
                )),
              ),
            ],
          ),
          body: Container(
            child: ListView.builder(
              itemCount: controller.getfaq.length ,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                  child: Card(
                    color: AppColors.cardclr,
                    child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("${controller.getfaq[index].id} " ?? '',style: TextStyle(color: AppColors.textclr),),
                            Text("QUE : ${controller.getfaq[index].title}",style: TextStyle(color: AppColors.textclr),),
                            Text("Answer : ${controller.getfaq[index].description}",style: TextStyle(color: AppColors.textclr),)
                          ]
                      ),
                    ),),
                );
              },
              ),
          )
      );
    },);
  }
}
