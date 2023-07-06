import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:kolazz_book/Utils/colors.dart';

import '../../Controller/getallsetting_controller.dart';

class TermandConidion extends StatefulWidget {
  const TermandConidion({Key? key}) : super(key: key);

  @override
  State<TermandConidion> createState() => _TermandConidionState();
}

class _TermandConidionState extends State<TermandConidion> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TermsAndConditionsController(),
      builder: (controller) {
        return Scaffold(
            // backgroundColor: AppColors.primary,
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
                  child: Center(child: Text("Terms And Condition",
                      style: TextStyle(fontSize: 16, color:AppColors.AppbtnColor, fontWeight: FontWeight.bold)
                  )),
                ),
              ],
            ),
            body: ListView(
              children: [
                controller.getprivacypolicy1 == null || controller.getprivacypolicy1.isEmpty ? Center(child: CircularProgressIndicator()) :
                    // Text('${controller.getprivacypolicy.first.html }')
                Html(
                    data:"${controller.getprivacypolicy1.first.html }",
                )
              ],
            )
        );
      },);

  }
}
