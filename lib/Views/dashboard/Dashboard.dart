
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Views/Jobs/jobs_screen.dart';
import 'package:kolazz_book/Views/contact_screen/Contact_screen.dart';
import 'package:kolazz_book/Views/team_screen/team_screen.dart';

import '../../Controller/dashboard_controller.dart';
import '../../Utils/colors.dart';
import '../Amount_screen/photographer_outstanding.dart';

import '../calender_screen/calender.dart';
import '../home_screen/New_home1.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {

   late TabController _tabController;
   bool isInternet = false;

   // checkInternetConnection() async{
   //   var connectivityResult = await (Connectivity().checkConnectivity());
   //   print("this is connectivity result $isInternet");
   //   if (connectivityResult == ConnectivityResult.mobile) {
   //    setState(() {
   //      isInternet = true;
   //    });
   //     // I am connected to a mobile network.
   //   } else if (connectivityResult == ConnectivityResult.wifi) {
   //   setState(() {
   //     isInternet = true;
   //   });
   //     // I am connected to a wifi network.
   //   }
   // }
   late ConnectivityResult _connectivityResult;

   @override
   void initState() {
     super.initState();
     _tabController = TabController(length: 6, vsync: this);
     checkInternetConnection();
     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
       setState(() {
         _connectivityResult = result;
       });
     });
   }

   Future<void> checkInternetConnection() async {
     final connectivityResult = await Connectivity().checkConnectivity();
     setState(() {
       _connectivityResult = connectivityResult;
     });
   }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
   exitConfirmationDialog(){
     return AlertDialog(
       backgroundColor: AppColors.primary,
       title: const Text('Exit App',style: TextStyle(color: AppColors.textclr),),
       content: const Text('Are you sure you want to exit?',style: TextStyle(color: AppColors.textclr),),
       actions: [
         TextButton(
           child: Container(
             height: 25,width: 50,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(5),
               color: AppColors.AppbtnColor
             ),
               child: Center(child: Text('No',style: TextStyle(color: AppColors.textclr),))),
           onPressed: () => Navigator.of(context).pop(false),
         ),
         TextButton(
           child: Container(
               height: 25,width: 50,
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(5),
                   color: AppColors.AppbtnColor
               ),
               child: Center(child: Text('Yes',style: TextStyle(color: AppColors.textclr),))),
           onPressed: () => Navigator.of(context).pop(true),
         ),
       ],
     );
   }

  @override
  Widget build(BuildContext context) {
    if (_connectivityResult == ConnectivityResult.none) {
      return Scaffold(
          backgroundColor: AppColors.secondary,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: Text("NO INTERNET!", style: TextStyle(
                    color: AppColors.AppbtnColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600
                ),),
              ),
              Center(
                child: Text("Internet connection required!"
                  , style: TextStyle(
                      color: AppColors.AppbtnColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500
                  ),),
              )
            ],
          )
      );
    } else {
      return
        GetBuilder(
          init: DashBoardController(),
          builder: (controller) {
            return SafeArea(
              child: WillPopScope(
                  onWillPop: () async {
                    final shouldExit = await showDialog(
                      context: context,
                      builder: (context) => exitConfirmationDialog(),
                    );
                    return shouldExit ?? false;
                  },
                  child:
                  // isInternet ?
                  Scaffold(
                    backgroundColor: AppColors.secondary,
                    body: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: <Widget>[
                        Homepage(),
                        ContactScreen(),
                        JobsScreen(),
                        CalendarScreen(),
                        // TableBasicsExample(),
                        // DemoApp(),
                        TeamScreen(),
                        photographer_outstanding(),
                      ],
                    ),
                    bottomNavigationBar: TabBar(
                      labelColor: AppColors.whit,
                      // unselectedLabelColor: Colors.black,
                      labelStyle: const TextStyle(fontSize: 8.5),
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                            color: Colors.black54, width: 0.0),
                        insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                      ),
                      //For Indicator Show and Customization
                      indicatorColor: Colors.black54,
                      tabs: const <Widget>[
                        Tab(
                          text: "Home",
                          icon: ImageIcon(
                              AssetImage('assets/icons/home icon.png')),
                        ),
                        Tab(
                          text: "Contacts",
                          icon: ImageIcon(
                              AssetImage('assets/icons/contact.png')),
                        ),
                        Tab(
                          text: "Jobs",

                          icon: ImageIcon(AssetImage('assets/icons/jobs.png')),
                        ),
                        Tab(
                          text: "Calendar",

                          icon: ImageIcon(
                              AssetImage('assets/icons/calendar.png')),
                        ),
                        Tab(
                          text: "Team",
                          icon: ImageIcon(AssetImage('assets/icons/team.png')),
                        ),
                        Tab(
                          text: "Account",

                          icon: ImageIcon(
                              AssetImage('assets/icons/account.png')),
                        ),
                      ],
                      controller: _tabController,
                    ),
                  )
                // : Scaffold(
                //   backgroundColor: AppColors.secondary,
                //   body: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: const [
                //       Center(
                //         child: Text("NO INTERNET!", style: TextStyle(
                //           color: AppColors.AppbtnColor,
                //           fontSize: 22,
                //           fontWeight: FontWeight.w600
                //         ),),
                //       ),
                //       Center(
                //         child: Text("Internet connection required!"
                //             , style: TextStyle(
                //             color: AppColors.AppbtnColor,
                //             fontSize: 13,
                //             fontWeight: FontWeight.w500
                //         ),),
                //       )
                //     ],
                //   ),
                // ),
              ),
            );
          },);
    }
  }
}

