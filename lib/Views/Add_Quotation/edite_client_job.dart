import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kolazz_book/Views/Add_Quotation/MoreQuatations.dart';

import '../../Utils/colors.dart';
import '../../Widgets/custom_appbutton.dart';
import '../Jobs/jobs_screen.dart';
import 'Add_new_quotations.dart';

class EditClientJob extends StatefulWidget {
  const EditClientJob({Key? key}) : super(key: key);

  @override
  State<EditClientJob> createState() => _AddQuotationState();
}

class _AddQuotationState extends State<EditClientJob> {
  String? _chosenValue;
  var item = ['Kaushik Prajapati', ' Prajapati', 'Kaushik Prajapati',];
  String? _cityValue;
  var item2 = ['Wedding ', ' Party', '  ',];
  String? _photography;
  var item3 = ['Mumbai', ' indore', 'delhi ',];

  var items = [
    'Drone',
    'Candid Photography',

  ];


  String? SelectedGender;
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.back,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color:AppColors.AppbtnColor,)),
        backgroundColor:AppColors.secondary ,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("Edit Client Job",
                style: TextStyle(fontSize: 16, color:AppColors.AppbtnColor, fontWeight: FontWeight.bold)
            ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              // Container(
              //   decoration: BoxDecoration(
              //       color: AppColors.teamcard2,
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 0),
              //     child: Column(
              //       children: [
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //
              //             const Text("Auto Q ID",style: TextStyle(color: AppColors.pdfbtn),),
              //             Padding(
              //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
              //               child: Container(
              //
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     color: AppColors.containerclr2),
              //                 padding: EdgeInsets.symmetric(vertical: 5),
              //                 width: MediaQuery.of(context).size.width/2.1,
              //                 child: const Padding(
              //                   padding: EdgeInsets.all(10.0),
              //                   child: Text("Q001",style: TextStyle(color: AppColors.textclr),),
              //                 ),),
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             const Text("Client Name",style: TextStyle(color: AppColors.pdfbtn),),
              //             Padding(
              //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
              //               child: Container(
              //
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     color: AppColors.containerclr2),
              //                 padding: EdgeInsets.symmetric(vertical: 5),
              //                 width: MediaQuery.of(context).size.width/2.1,
              //                 child: const Padding(
              //                   padding: EdgeInsets.all(10.0),
              //                   child: Text("Kinjal Patel",style: TextStyle(color: AppColors.textclr),),
              //                 ),),
              //             )
              //
              //           ],
              //         ) ,
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text("City/Venue",style: TextStyle(color: AppColors.pdfbtn),),
              //             Padding(
              //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
              //               child: Container(
              //
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     color: AppColors.containerclr2),
              //                 padding: EdgeInsets.symmetric(vertical: 5),
              //                 width: MediaQuery.of(context).size.width/2.1,
              //                 child: const Padding(
              //                   padding: EdgeInsets.all(10.0),
              //                   child: Text("Kanpur",style: TextStyle(color: AppColors.textclr),),
              //                 ),),
              //             )
              //
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Text("Event",style: TextStyle(color: AppColors.pdfbtn),),
              //             Padding(
              //               padding:  EdgeInsets.symmetric(vertical: 8.0,horizontal:0 ),
              //               child: Container(
              //
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.circular(10),
              //                     color: AppColors.containerclr2),
              //                 padding: EdgeInsets.symmetric(vertical: 5),
              //                 width: MediaQuery.of(context).size.width/2.1,
              //                 child: const Padding(
              //                   padding: EdgeInsets.all(10.0),
              //                   child: Text("Wedding",style: TextStyle(color: AppColors.textclr),),
              //                 ),),
              //             )
              //
              //           ],
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff3B3B3B),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Auto CF ID",
                            style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
                          Container(width:180,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.backgruond,
                            ),

                            child: Align(alignment: Alignment.centerLeft, child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("FJ001",style: TextStyle(color: AppColors.whit),),
                            )),)
                        ],
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Client Name",
                            style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
                          Container(
                            width:180,
                            height: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.backgruond,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 0,
                                underline: Container(),
                                isExpanded: true,
                                value: _chosenValue,
                                icon: Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
                                hint: Align(alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Kaushik Prajapati", style: TextStyle(
                                        color:AppColors.whit
                                    ),),
                                  ),
                                ),
                                items:item.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items)
                                  );
                                }
                                ).toList(),
                                onChanged: (String? newValue){
                                  setState(() {
                                    _chosenValue = newValue!;
                                  });
                                },

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("City/Venue",
                            style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
                          Container(width:180,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.backgruond,
                            ),

                            child: Align(alignment: Alignment.centerLeft, child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Mumbai",style: TextStyle(color: AppColors.whit),),
                            )),)
                        ],
                      ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Events",
                            style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
                          Container(
                            width:180,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.backgruond,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                elevation: 0,
                                underline: Container(),
                                isExpanded: true,
                                value: _cityValue,
                                icon: Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
                                hint: Align(alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Wedding", style: TextStyle(
                                        color:AppColors.whit
                                    ),),
                                  ),
                                ),
                                items:item2.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(items)
                                  );
                                }
                                ).toList(),
                                onChanged: (String? newValue){
                                  setState(() {
                                    _cityValue = newValue!;
                                  });
                                },

                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 20,),

              Row(
                children: [
                Container(decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                  color: AppColors.teamcard2,
                ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                      decoration: BoxDecoration(
                        color:AppColors.datecontainer,

                      ),
                      child: Text("22/2/2023",style: TextStyle(color: AppColors.textclr),),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.zero,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
                    color: AppColors.teamcard2,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                      decoration: BoxDecoration(
                        color:AppColors.datecontainer,

                      ),
                      child: Text("22/2/2023",style: TextStyle(color: AppColors.textclr),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(Icons.add_circle_outline,color: AppColors.temtextclr,size: 30,),
                ),
                Text("Add Date",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),)

              ],),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.teamcard2,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10))
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,

                      child: Text("(For Developer User Can Hold/Or To Delete This Row)",style: TextStyle(fontStyle: FontStyle.italic,color: AppColors.textclr,fontSize: 12),),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Text("Type Of Photographer",style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.textclr,fontSize: 15),),
                                SizedBox(width: 65,),
                                Text("Select Photographer",style: TextStyle(fontWeight: FontWeight.w500,color: AppColors.textclr,fontSize: 15),),
                              ],
                            ),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: AppColors.datecontainer),
                                width: MediaQuery.of(context).size.width/2.1,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint:Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,),
                                    elevation: 16,
                                    style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      // height: 2,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: items
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: AppColors.datecontainer),
                                width: MediaQuery.of(context).size.width/2.6,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint:Text(" ",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,),
                                    elevation: 16,
                                    style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      // height: 2,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: items
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),


                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: AppColors.datecontainer),
                                width: MediaQuery.of(context).size.width/2.1,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint:Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,),
                                    elevation: 16,
                                    style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      // height: 2,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: items
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: AppColors.datecontainer),
                                width: MediaQuery.of(context).size.width/2.6,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint:Text(" ",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,),
                                    elevation: 16,
                                    style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      // height: 2,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: items
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),


                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: AppColors.datecontainer),
                                width: MediaQuery.of(context).size.width/2.1,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint:Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,),
                                    elevation: 16,
                                    style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      // height: 2,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: items
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: AppColors.datecontainer),
                                width: MediaQuery.of(context).size.width/2.6,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint:Text(" ",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,),
                                    elevation: 16,
                                    style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      // height: 2,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: items
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),


                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 8,vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: AppColors.datecontainer),
                                width: MediaQuery.of(context).size.width/2.1,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint:Text("Candid Photography",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,),
                                    elevation: 16,
                                    style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      // height: 2,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: items
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5,),
                              Container(
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 2,vertical: 0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    color: AppColors.datecontainer),
                                width: MediaQuery.of(context).size.width/2.6,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue,
                                    hint:Text(" ",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.w400),),
                                    icon: const Icon(Icons.keyboard_arrow_down_rounded,
                                      color: Colors.white,),
                                    elevation: 16,
                                    style:  TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                                    underline: Container(
                                      // height: 2,
                                      color: Colors.black54,
                                    ),
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        dropdownValue = value!;
                                      });
                                    },
                                    items: items
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),


                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,

                      child: Text("(For Developer User Can Hold/Or To Delete This Row)",style: TextStyle(fontStyle: FontStyle.italic,color: AppColors.textclr,fontSize: 13),),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(Icons.add_circle_outline,color: AppColors.temtextclr,size: 30,),
                    ),
                    Text("Add Type Of Photographer",style: TextStyle(color: AppColors.temtextclr,fontSize: 16,fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),

                  ],
                ),
              ),
              SizedBox(height: 20,),

              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Output",style: TextStyle(color: AppColors.textclr,fontSize: 19,fontWeight: FontWeight.bold),),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.editfield,

                          borderRadius: BorderRadius.circular(10)),
                      height: 35,
                      width: MediaQuery.of(context).size.width/1.7,
                    )
                  ],),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Amount",style: TextStyle(color: AppColors.textclr,fontSize: 19,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.editfield,

                          borderRadius: BorderRadius.circular(10)),
                      height: 35,
                      width: MediaQuery.of(context).size.width/1.7,
                    )
                  ],),
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>JobsScreen()));
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: AppColors.AppbtnColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text("Update",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.textclr,fontSize: 18),)),
                    ),
                  ),
                  Image.asset("assets/images/pdf.png", scale: 1.6,),
                  Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        color: AppColors.contaccontainerred,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(child: Text("Delete",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.textclr,fontSize: 18),)),
                  ),

                ],),



              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
    );
  }
}
