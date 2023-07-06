

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Controller/edit_profile_controller.dart';
import 'package:kolazz_book/Controller/profile_controller.dart';
import 'package:kolazz_book/Views/authView/login/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Route_managements/routes.dart';
import '../../Utils/colors.dart';
import '../../Widgets/customerDrawer/customdrawer.dart';
import '../edit_profile/edit_profile.dart';



class MyProfilePage extends StatefulWidget {
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {



  void initState(){
    super.initState();
  }
  Widget _homeLogo(){
    return Container(
      height: 100,
      child: Center(child: Image.asset("assets/images/applogo.png",height: 50,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ProfileController(),
      builder: (controller) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        bottomSheet: _homeLogo(),
        appBar: AppBar(
          backgroundColor:AppColors.secondary ,
          leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios,color: AppColors.AppbtnColor,)),
          actions: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Setting",
                  style: TextStyle(
                      color: AppColors.AppbtnColor,fontSize: 16,
                      fontWeight: FontWeight.w600),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child:
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (c)=>EditProfileScreen()));
                      },
                      child: Stack(
                        children: [
                          GetBuilder(
                              init: EditProfileController(),
                              builder: (controller) {
                                return GestureDetector(
                                  onTap: (){
                                    // Get.to(EditProfileScreen());
                                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfilePage()));
                                  },
                                  child:  Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        borderRadius: BorderRadius.circular(40)),
                                    child:   ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: controller.profilePic == null || controller.profilePic == '' ?
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(40),
                                            child: controller.imageFile != null
                                                ? Image.file(controller.imageFile!, fit: BoxFit.cover, height: 70,width: 70,)
                                                : Image.asset("assets/images/loginlogo.png",fit: BoxFit.fill,height: 70,width: 70,)
                                        )
                                            : ClipRRect(
                                            borderRadius: BorderRadius.circular(40),
                                            child:
                                            // rcImage != null ?
                                            Image.network(controller.profilePic.toString(), fit: BoxFit.cover, height: 70,width: 70,)
                                        )
                                    ),
                                  ),
                                );}
                          ),
                          Positioned(
                              top: 40,
                              left: 40,
                              child: Container(

                                  decoration: BoxDecoration(
                                      color: Colors.white,

                                      borderRadius: BorderRadius.circular(13)),
                                  height: 25,width: 25,
                                  child: Icon(Icons.edit)))
                        ],),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Hello!",style: TextStyle(color: Colors.white,fontSize: 20),),
                               controller.firstname != null ?Text('${controller.firstname} ${controller.lastname}',style: TextStyle(color: AppColors.AppbtnColor,fontSize: 20),): CircularProgressIndicator()
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomDrawerTile(tileName: 'About Us  ', tileIcon:Icon(Icons.add_box_outlined,color: AppColors.textclr,),
                  onTap: (){
                  Get.toNamed(abutusscreen);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomDrawerTile(tileName: 'Subscription ', tileIcon:Icon(Icons.subscriptions,color: AppColors.textclr,),
                  onTap: (){
                  Get.toNamed(subscriptionScreen);
                  },),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomDrawerTile(tileName: 'Privacy Policy ', tileIcon:Icon(Icons.privacy_tip_rounded,color: AppColors.textclr,),
                  onTap: (){
                    Get.toNamed(privacypolicyScreen);
                  },),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomDrawerTile(tileName: 'Terms of Use ', tileIcon:Icon(Icons.terminal_sharp,color: AppColors.textclr,),
                  onTap: (){
                  Get.toNamed(tncscreen);
                  },),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomDrawerTile(tileName: 'FAQ ', tileIcon:Icon(Icons.privacy_tip,color: AppColors.textclr,),
                  onTap: (){
                    Get.toNamed(faqscreen);
                  },),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomDrawerTile(tileName: 'Help Support ', tileIcon:Icon(Icons.help,color: AppColors.textclr,),
                  onTap: (){
                  Get.toNamed(helpScreen);
                  },),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomDrawerTile(tileName: 'Logout', tileIcon:Icon(Icons.logout,color: AppColors.textclr,),
                  onTap: (){
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Sign out"),
                            content: Text("Are you sure to sign out from app now?"),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: AppColors.primary),
                                child: Text("YES"),
                                onPressed: () async {
                                  Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
                                  // controller.logOut();
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Logout")));
                                  // SharedPreferences prefs = await SharedPreferences.getInstance();
                                  setState(() {
                                    controller.logOut();
                                  });
                                  // Get.toNamed(loginScreen);
                                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) =>LoginPage()),
                                  // );
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(primary:AppColors.primary),
                                child: Text("NO"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(5.0),
              //   child: CustomDrawerTile(tileName: 'Login Device -1', tileIcon:Icon(Icons.login,color: AppColors.textclr,),
              //     // tileIcon:Image.asset("assets/imgs/Privacy Policy.png",scale: 1.7,),
              //     // onTap: (){
              //     //   showDialog(
              //     //       context: context,
              //     //       barrierDismissible: false,
              //     //       builder: (BuildContext context) {
              //     //         return AlertDialog(
              //     //           title: Text("Confirm Sign out"),
              //     //           content: Text("Are you sure to sign out from app now?"),
              //     //           actions: <Widget>[
              //     //             ElevatedButton(
              //     //               style: ElevatedButton.styleFrom(primary: AppColors.primary),
              //     //               child: Text("YES"),
              //     //               onPressed: () async {
              //     //                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Logout")));
              //     //                 SharedPreferences prefs = await SharedPreferences.getInstance();
              //     //                 setState(() {
              //     //                   prefs.clear();
              //     //                 });
              //     //                 // Get.toNamed(loginScreen);
              //     //                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
              //     //                 // Navigator.pushNamedAndRemoveUntil(
              //     //                 //   context,
              //     //                 //   MaterialPageRoute(builder: (context) =>LoginPage()),
              //     //                 // );
              //     //               },
              //     //             ),
              //     //             ElevatedButton(
              //     //               style: ElevatedButton.styleFrom(primary:AppColors.primary),
              //     //               child: Text("NO"),
              //     //               onPressed: () {
              //     //                 Navigator.of(context).pop();
              //     //               },
              //     //             )
              //     //           ],
              //     //         );
              //     //       });
              //     // },
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: CustomDrawerTile(tileName: 'Logout All Device', tileIcon:Icon(Icons.logout,color: AppColors.textclr,),
                  // tileIcon:Image.asset("assets/imgs/Privacy Policy.png",scale: 1.7,),
                  onTap: (){
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Confirm Sign out"),
                            content: Text("Are You Sure To Sign Out All Device?"),
                            actions: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: AppColors.primary),
                                child: Text("YES"),
                                onPressed: () async {
                                  controller.logOutAll();
                                  Navigator.pushNamedAndRemoveUntil(context, loginScreen, (route) => false);
                                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User Logout")));
                                  // SharedPreferences prefs = await SharedPreferences.getInstance();

                                  // Get.toNamed(loginScreen);
                                  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
                                  // Navigator.pushNamedAndRemoveUntil(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) =>LoginPage()),
                                  // );
                                },
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(primary:AppColors.primary),
                                child: Text("NO"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        });
                  },
                ),
              ),
              SizedBox(height: 17,),
            ],
          ),
        ),
      );
    },);
  }
}

