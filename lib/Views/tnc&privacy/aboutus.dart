import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../Controller/getallsetting_controller.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<AboutUsScreen> {
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
                  child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
              backgroundColor: Color(0xff303030),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Center(child: Text("About Us",
                      style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
                  )),
                ),
              ],
            ),
            body: ListView(
              children: [
                controller.getprivacypolicy2 == null|| controller.getprivacypolicy2.isEmpty ? Center(child: CircularProgressIndicator()) :
                // Text('${controller.getprivacypolicy.first.html }')
                Html(
                  data:"${controller.getprivacypolicy2.first.html }",
                )
              ],
            )
        );
      },);

  }
}
