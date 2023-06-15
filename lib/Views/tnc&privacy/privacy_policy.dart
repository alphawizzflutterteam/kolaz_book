
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:get/get_state_manager/get_state_manager.dart';


import '../../Controller/getallsetting_controller.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}
class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: TermsAndConditionsController(),
      builder: (controller) {
      return Scaffold(
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
                child: Center(child: Text("Privacy Policy",
                    style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
                )),
              ),
            ],
          ),
          body: ListView(
            children: [
            controller.getprivacypolicy == null ||controller.getprivacypolicy.isEmpty ? Center(child: CircularProgressIndicator()) :Html(
                  data:"${controller.getprivacypolicy.first.html}"
              )
            ],
          )
      );
    },);

  }
}
