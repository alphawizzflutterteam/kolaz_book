import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Models/get_quotation_model.dart';
import 'package:kolazz_book/Services/request_keys.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Controller/addQuatation_controller.dart';
import '../../Utils/colors.dart';
import 'Add_new_quotations.dart';
import 'editequotation.dart';

class MoreQuatations extends StatefulWidget {
  const MoreQuatations({Key? key}) : super(key: key);

  @override
  State<MoreQuatations> createState() => _MoreQuatationsState();
}

class _MoreQuatationsState extends State<MoreQuatations> {

  List<Setting> getQuotation = [];

  getQuotations() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri =
    Uri.parse(getQuotationApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields[RequestKeys.userId] = id!;
    request.fields[RequestKeys.type] = 'client';
    print("this is quotation list ${request.fields.toString()}");
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);

    setState(() {
      getQuotation = GetQuotationModel.fromJson(userData).setting!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuotations();
  }

  @override
  Widget build(BuildContext context) {
   return
     GetBuilder(
     init: AddQuatationController(),
     builder: (controller) {
     return
     Scaffold(
       backgroundColor: AppColors.backgruond,
       appBar: AppBar(
         leading: GestureDetector(
             onTap: (){
               Navigator.pop(context);
             },
             child: Icon(Icons.arrow_back_ios, color:AppColors.AppbtnColor,)),
         backgroundColor: Color(0xff303030),
         actions: [
           Padding(
             padding: const EdgeInsets.all(15),
             child: Center(child: Text("Quotations",
                 style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
             ),
             ),
           ),
         ],
       ),
       bottomSheet:  InkWell(
         onTap: () async{
          var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuotation()));
          print("this is result $result");
          if(result != null){
            getQuotations();
          }
         },
         child: Padding(
           padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 5, top: 5),
           child: Container(
             padding: const EdgeInsets.only(left: 15, right: 15),
             height: 50,
             width: MediaQuery.of(context).size.width/1 ,
             decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), color: Color(0xff40ACFF)
             ),
             child: const Center(
               child: Text("Add New Quotations",
                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.whit)),
             ),
           ),
         ),
       ),
       body: SingleChildScrollView(
       child: Column(
         children: [
           // controller.getQuotation.isNotEmpty ?
           ListView.builder(
             shrinkWrap: true,
             scrollDirection: Axis.vertical,
             itemCount:getQuotation.length ,
             physics: NeverScrollableScrollPhysics(),
             itemBuilder: (BuildContext context, int index) {
               print("this is ${getQuotation.length}");
               return Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                 child: InkWell(
                   onTap: ()async {
                     var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditQuotation(
                       qid: getQuotation[index].id.toString(),
                     )));
                     if(result != null){
                       setState(() {
                         getQuotations();
                       });
                     }
                   },
                   child: Card(
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                     color: Colors.black12,
                     elevation: 2,
                     child: Column(
                       children: [
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               const Text("QID",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
                               Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                                   decoration: BoxDecoration(
                                       color: AppColors.lightwhite,

                                       borderRadius: BorderRadius.circular(10)
                                   ),
                                   child: Text("${getQuotation[index].qid}",style: TextStyle(color: AppColors.whit,),)),
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               const Text("Client Name",style: TextStyle(color: AppColors.pdfbtn,fontWeight: FontWeight.bold,fontSize: 16),),
                               Text("${getQuotation[index].clientName}",style: TextStyle(color: AppColors.whit),),
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               const Text("City",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
                               Text("${getQuotation[index].cityName}",style: const TextStyle(color: AppColors.whit),),
                             ],
                           ),
                         ),
                       ],
                     ),),
                 ),
               );
             },

           ),
           // _quotationCard(context, controller)
           //     : const Center(child: Text(" No Data To Show")),
          const SizedBox(height: 70,)
         ],
       )

       )

     );
   },);
  }

  Widget _quotationCard(BuildContext context, controller){
    return
      // GetBuilder(
      // init: AddQuatationController(),
      // builder: (controller) {
      // return
        ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount:controller.getQuotation.length ,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
              child: InkWell(
                onTap: ()async {
                 var result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>EditQuotation(
                    qid: controller.getQuotation[index].qid.toString(),
                  )));
                 if(result != null){
                   controller.getQuotations();
                 }
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.black12,
                  elevation: 2,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("qid",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
                            Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.lightwhite,

                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text("${controller.getQuotation[index].qid}",style: TextStyle(color: AppColors.whit,),)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Client Name",style: TextStyle(color: AppColors.pdfbtn,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text("${controller.getQuotation[index].clientName}",style: TextStyle(color: AppColors.whit),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("City",style: TextStyle(color: AppColors.pdfbtn,fontSize: 16,fontWeight: FontWeight.bold),),
                            Text("${controller.getQuotation[index].city}",style: TextStyle(color: AppColors.whit),),
                          ],
                        ),
                      ),
                    ],
                  ),),
              ),
            );
          },

        );
    // },);

  }
}
