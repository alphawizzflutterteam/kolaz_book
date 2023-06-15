import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/colors.dart';

class ClientAccount extends StatefulWidget {


  const ClientAccount({Key? key}) : super(key: key);



  @override
  State<ClientAccount> createState() => _AddAmountScreenState();
}

class _AddAmountScreenState extends State<ClientAccount> {

  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios, color: Color(0xff1E90FF))),
        backgroundColor: Color(0xff303030),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Center(child: Text("(Clients Name)Account",
                style: TextStyle(fontSize: 16, color:Color(0xff1E90FF), fontWeight: FontWeight.bold)
            )),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.containerclr,
                        borderRadius: BorderRadius.circular(10)),

                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSelected = true;
                            });
                          },
                          child: Container(
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 14, left: 10, right: 10),
                                child: Text(
                                  'Payment Received',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Color(0xffffffff)
                                        : Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.greenbtn
                                    : AppColors.containerclr,
                                // border: Border.all(color: AppColors.AppbtnColor),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => NextPage(),
                              // ));
                              isSelected = false;
                            });
                          },
                          child: Container(
                              height: 50,
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 10, right: 10),
                                child: Text(
                                  'Add Extra Charges',
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.whit
                                        : Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.containerclr
                                      : AppColors.AppbtnColor,
                                  borderRadius: BorderRadius.circular(10))),
                        ),
                      ],
                    ),)

                ],
              ),
              SizedBox(height: 10),

              isSelected ? _PaymentReceived() : _addExtraCharges(),
            ],
          ),
        ),
      ),

    );
  }
  Widget _PaymentReceived() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("Enter Received Amount",style: TextStyle(color: AppColors.textclr,fontSize: 15,fontWeight: FontWeight.w400),),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child:TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("Enter Short Description(Optional)",style: TextStyle(color: AppColors.textclr,fontSize: 15,fontWeight: FontWeight.w400),),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child:TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )
          ),
        ),
        SizedBox(height: 40,),

        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
              height: 55,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  AppColors.greenbtn),
              width: MediaQuery.of(context).size.width/1.5,
              child: Center(child: Text("Add Payment", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.textclr)))
          ),
        ),


      ],
    );
  }

  Widget _addExtraCharges() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("Add Extra Charges Amount",style: TextStyle(color: AppColors.textclr,fontSize: 15,fontWeight: FontWeight.w400),),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child:TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )
          ),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text("Enter Short Description(Optional)",style: TextStyle(color: AppColors.textclr,fontSize: 15,fontWeight: FontWeight.w400),),
              )),
        ),
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width/1.1,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.lightwhite),
          child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 5),
              child:TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,

                  // border: OutlineInputBorder()
                ),
              )
          ),
        ),
        SizedBox(height: 40,),

        InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
              height: 55,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color:  AppColors.pdfbtn),
              width: MediaQuery.of(context).size.width/1.5,
              child: Center(child: Text("Add Extra Charges", style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: AppColors.textclr)))
          ),
        ),


      ],
    );
  }
}
