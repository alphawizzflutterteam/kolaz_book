import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Controller/home_controller.dart';
import '../../Utils/colors.dart';
import '../brodcast/Broadcast_screen.dart';
import '../edit_profile/edit_profile.dart';
import '../notification/Notification_screen.dart';
import '../profile/Profile.dart';


class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:HomeController(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor:AppColors.secondary ,
          toolbarHeight: 79,
          leading:  Padding(
            padding: const EdgeInsets.only(left: 5, right: 0),
            child: InkWell(
              onTap: () {

              },
              child:GestureDetector(
                onTap: (){
                  Get.to(EditProfileScreen());
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfilePage()));
                },
                child: CircleAvatar(

                    radius: 20,
                    child:Icon(Icons.person)
                ),
              ),
            ),
          ),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              controller.profiledata != null || controller.profiledata == "" ? Text("${controller.profiledata!.fname} ${controller.profiledata!.lname}",style: TextStyle(color: AppColors.AppbtnColor,fontSize: 15),): CircularProgressIndicator(),
              Text("15 Days Free Trial ",style: TextStyle(fontSize: 12),),
            ],
          ),
          actions: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Notification_screen()));
                    },
                    child: Container(
                        height: 37,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primary

                        ),
                        child: Icon(Icons.notifications)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>Broadcast_screen()));
                    },
                    child: Container(
                        height: 37,
                        width: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.primary

                        ),
                        child: Icon(Icons.message)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: (){
                      Get.to(MyProfilePage());
                    },
                    child: Container(
                        height: 37,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.primary,
                        ),
                        child: Icon(Icons.settings)),
                  ),
                ),

              ],)
          ],

          centerTitle: false,
        ),
        body:  SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.primary3,AppColors.grd1,AppColors.grd2],
                  stops: [0, 1,1]),
            ),
            child: Column(children: [
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,top: 20),
                      child: Text("Upcoming Client Jobs", style: TextStyle(fontSize: 17, color: AppColors.whit, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),

              _clientCard(context),
              SizedBox(height: 30,),
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(width: 5,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Upcoming Freelencing jobs", style: TextStyle(fontSize: 17, color: AppColors.whit, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              _clientCard2(context),
              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    width: double.infinity,
                    child: Text("Photographer Yet To Be Allotment Clients Jobs ", style: TextStyle(fontSize: 17, color:AppColors.whit, fontWeight: FontWeight.w700,overflow: TextOverflow.ellipsis))),
              ),

              _clientCard3(context),
              SizedBox(height: 50,),
              _homeLogo(),

            ],),
          ),
        ),
      );
    },);
  }
  Widget _clientCard(BuildContext context){
    return
    Container(
      height: 150,
      // height: MediaQuery.of(context).size.height/6.22,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio:0.5/1.2,
          crossAxisCount: 1,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {

            },
            child: Padding(
                padding: EdgeInsets.all(5),
                child:  Container(
                  width: 340,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Colors.black12,
                    elevation: 2,
                    child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Shubham",style: TextStyle(color: AppColors.textclr,fontSize: 16,fontWeight: FontWeight.bold),),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                                decoration: BoxDecoration(
                                    color: AppColors.lightwhite,

                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Text("KB003",style: TextStyle(color: AppColors.whit,),)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Indore",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.bold,fontSize: 16),),
                            Text("",style: TextStyle(color: AppColors.whit),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 15.0,left: 10,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Wedding",style: TextStyle(color: AppColors.textclr,fontSize: 16,fontWeight: FontWeight.bold),),
                            Text("28/April/2023",style: TextStyle(color: AppColors.AppbtnColor),),
                          ],
                        ),
                      ),
                    ],
                  ),),
                ),
            ),
          );
        },

      ),
    );
  }
  Widget _clientCard2(BuildContext context){
    return
      Container(
        height: 150,
        // height: MediaQuery.of(context).size.height/6.22,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio:0.5/1.2,
            crossAxisCount: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {

              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child:  Container(
                  width: 340,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: AppColors.cardclr,
                    elevation: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Shubham",style: TextStyle(color: AppColors.textclr,fontSize: 16,fontWeight: FontWeight.bold),),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightwhite,

                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text("KB003",style: TextStyle(color: AppColors.whit,),)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Indore",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.bold,fontSize: 16),),
                              Text("",style: TextStyle(color: AppColors.whit),),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 15.0,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Pree Wedding",style: TextStyle(color: AppColors.textclr,fontSize: 16,fontWeight: FontWeight.bold),),
                              Text("28/April/2023",style: TextStyle(color: AppColors.AppbtnColor),),
                            ],
                          ),
                        ),
                      ],
                    ),),
                ),
              ),
            );
          },

        ),
      );
  }
  Widget _clientCard3(BuildContext context){
    return
      Container(
        height: 150,
        // height: MediaQuery.of(context).size.height/6.22,
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio:0.5/1.2,
            crossAxisCount: 1,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {

              },
              child: Padding(
                padding: EdgeInsets.all(5),
                child:  Container(
                  width: 340,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Colors.black12,
                    elevation: 2,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Jhanvi Singh",style: TextStyle(color: AppColors.textclr,fontSize: 16,fontWeight: FontWeight.bold),),
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 14,vertical: 10),
                                  decoration: BoxDecoration(
                                      color: AppColors.lightwhite,

                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Text("KB003",style: TextStyle(color: AppColors.whit,),)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("",style: TextStyle(color: AppColors.textclr,fontWeight: FontWeight.bold,fontSize: 16),),
                              Text("",style: TextStyle(color: AppColors.whit),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0,left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Mumbai",style: TextStyle(color: AppColors.textclr,fontSize: 16,fontWeight: FontWeight.bold),),
                              Text("",style: TextStyle(color: AppColors.whit),),
                            ],
                          ),
                        ),
                      ],
                    ),),
                ),
              ),
            );
          },

        ),
      );
  }
  Widget _homeLogo(){
    return Container(
      child: Image.asset("assets/images/loginlogo.png",height: 50,),
    );
  }
}
