

import 'package:flutter/material.dart';

import '../../Utils/colors.dart';

class freelancing_job_update extends StatefulWidget {
  const freelancing_job_update({Key? key}) : super(key: key);

  @override
  State<freelancing_job_update> createState() => _freelancing_job_updateState();
}

class _freelancing_job_updateState extends State<freelancing_job_update> {
  String? _chosenValue;
  var item = ['Kaushik Prajapati', ' Prajapati', 'Kaushik Prajapati',];
  String? _cityValue;
  var item2 = ['Mumbai', ' indore', 'delhi ',];
  String? _photography;
  var item3 = ['Mumbai', ' indore', 'delhi ',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.backgruond,
      appBar: AppBar(
        backgroundColor: Color(0xff303030),
        leading: const BackButton(
          color: Color(0xff1E90FF), // <-- SEE HERE
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right:14),
              child: Text("Edit Freelancing Job", style: TextStyle(fontSize: 14, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
              ),
            ),
          ),
        ],
      ),
    body: SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 15),
          child: Column(
            children: [
                 Container(
                   padding: EdgeInsets.symmetric(vertical: 10),
                   // height: 250,
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
                            Text("Auto Job ID",
                              style: TextStyle(color: Color(0xff42ACFE),fontWeight: FontWeight.bold),),
                            Container(width:180,
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
                            Text("Photograher",
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
                                  value: _cityValue,
                                  icon: Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
                                  hint: Align(alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("Mumbai", style: TextStyle(
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
              SizedBox(height: 12,),
              Container(

                height: 90,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:Color(0xff8B8B8B),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Align(alignment: Alignment.topCenter, child: Text("Type Of Photography",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whit,fontSize: 14),)),
                 SizedBox(height: 8,),
                  Container(height: 35,
                    width:200 ,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xffbfbfbf),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        elevation: 0,
                        underline: Container(),
                        isExpanded: true,
                        value: _photography,
                        icon: Icon(Icons.keyboard_arrow_down,size: 40,color: Color(0xff3B3B3B),),
                        hint: Align(alignment: Alignment.centerLeft,
                          child: Center(
                            child: Text("candid Photography", style: TextStyle(
                                color:AppColors.whit
                            ),),
                          ),
                        ),
                        items:item3.map((String items) {
                          return DropdownMenuItem(
                              value: items,
                              child: Text(items)
                          );
                        }
                        ).toList(),
                        onChanged: (String? newValue){
                          setState(() {
                            _photography = newValue!;
                          });
                        },

                      ),
                    ),
                  )
                  ],
                ),

              ),


              ),
              SizedBox(height: 12,),
              Container(height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color(0xff42ACFE),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0,left: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Date",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whit),),
                      Text("Time",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whit),),
                      Text("Amount",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whit),),
                    ],
                  ),
                ),
              ),
              Container(height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color(0xff8B8B8B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("22-02-2023",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                      Text("6:00 am to 8:00 pm",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("15000",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.delete))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color(0xff8B8B8B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("22-02-2023",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                      Text("6:00 am to 8:00 pm",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("15000",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.delete))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color(0xff8B8B8B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("22-02-2023",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                      Text("6:00 am to 8:00 pm",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("15000",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.delete))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color(0xff8B8B8B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("22-02-2023",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                      Text("6:00 am to 8:00 pm",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("15000",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.delete))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color(0xff8B8B8B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("22-02-2023",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                      Text("6:00 am to 8:00 pm",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("15000",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit),),
                          IconButton(onPressed: (){},
                              icon: Icon(Icons.delete))
                        ],
                      ),

                    ],
                  ),
                ),
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color(0xff8B8B8B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("(MM-DD-YYYY)",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
                      Text("Enter Time Optional",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),
                      Text("Enter Amount",style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: AppColors.whit,fontStyle: FontStyle.italic),),

                    ],
                  ),
                ),
              ),

              Container(height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color:Color(0xff8B8B8B),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(onTap: (){},
                        child: Row(
                          children: const [
                            Icon(Icons.add,color:Color(0xff42ACFE) ,),
                            Text("Add More",style: TextStyle(color:Color(0xff42ACFE),fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(alignment: Alignment.centerLeft, child: Text("Total",style: TextStyle(fontWeight: FontWeight.bold,color:AppColors.whit),)),
                      Container(height: 30,width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffbfbfbf),

                      ),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text("=Sum(Amount)",style: TextStyle(color: AppColors.whit,fontStyle: FontStyle.italic),)),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 140,height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Update'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff40ACFF),

                            ),
                          ),
                        ),
                        Image.asset("assets/images/pdf.png", scale: 2.1,),

                        SizedBox(width: 140,height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Delete'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.red,

                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
