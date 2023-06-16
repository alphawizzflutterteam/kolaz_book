
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
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
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
               child: Center(child: Text('yes',style: TextStyle(color: AppColors.textclr),))),
           onPressed: () => Navigator.of(context).pop(true),
         ),
       ],
     );
   }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:DashBoardController(),
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
          child: Scaffold(
            backgroundColor: AppColors.secondary,
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children:  <Widget>[
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
                borderSide: BorderSide(color: Colors.black54, width: 0.0),
                insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
              ),
              //For Indicator Show and Customization
              indicatorColor: Colors.black54,
              tabs: const <Widget>[
                Tab(
                  text: "Home",
                  icon: ImageIcon(AssetImage('assets/icons/home icon.png')),
                ),
                Tab(
                  text: "Contacts",
                  icon: ImageIcon(AssetImage('assets/icons/contact.png')),
                ),
                Tab(
                  text: "Jobs",

                  icon: ImageIcon(AssetImage('assets/icons/jobs.png')),
                ),
                Tab(
                  text: "Calendar",

                  icon: ImageIcon(AssetImage('assets/icons/calendar.png')),
                ),
                Tab(
                  text: "Team",
                  icon: ImageIcon(AssetImage('assets/icons/team.png')),
                ),
                Tab(
                  text: "Account",

                  icon: ImageIcon(AssetImage('assets/icons/account.png')),
                ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      );
    },);
  }
}
// import 'package:flutter/material.dart';
//
// import '../../Utils/colors.dart';
// import '../Amount_screen/photographer_outstanding.dart';
// import '../Jobs/jobs_screen.dart';
// import '../calender_screen/calender.dart';
// import '../contact_screen/Contact_screen.dart';
// import '../home_screen/New_home1.dart';
// import '../team_screen/team_screen.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({super.key});
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Homepage(),
//     ContactScreen(),
//     JobsScreen(),
//     TableBasicsExample(),
//     TeamScreen(),
//     photographer_outstanding(),
//
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: AppColors.secondary,
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             backgroundColor: AppColors.secondary,
//             icon: ImageIcon(AssetImage('assets/icons/home icon.png')),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: AppColors.secondary,
//             icon: ImageIcon(AssetImage('assets/icons/contact.png')),
//             label: 'Contacts',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: AppColors.secondary,
//             icon: ImageIcon(AssetImage('assets/icons/jobs.png')),
//             label: 'Jobs',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: AppColors.secondary,
//             icon: ImageIcon(AssetImage('assets/icons/calendar.png')),
//             label: 'Calendar',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: AppColors.secondary,
//             icon:ImageIcon(AssetImage('assets/icons/team.png')),
//             label: 'Team',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: AppColors.secondary,
//             icon:ImageIcon(AssetImage('assets/icons/account.png')),
//             label: 'Account',
//
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedLabelStyle: TextStyle(color: Colors.black),
//         unselectedLabelStyle: const TextStyle(color: AppColors.textclr),
//
//         // selectedItemColor:  Colors.black54,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
//
// import '../../Utils/colors.dart';
// import '../Amount_screen/photographer_outstanding.dart';
// import '../Jobs/jobs_screen.dart';
// import '../calender_screen/calender.dart';
// import '../contact_screen/Contact_screen.dart';
// import '../home_screen/New_home1.dart';
// import '../team_screen/team_screen.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({super.key});
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//   TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//         Homepage(),
//         ContactScreen(),
//         JobsScreen(),
//         TableBasicsExample(),
//         TeamScreen(),
//         photographer_outstanding(),
//
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.secondary,
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: AppColors.secondary,
//
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             backgroundColor: AppColors.secondary,
//             icon:ImageIcon(AssetImage('assets/icons/home icon.png')),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(AssetImage('assets/icons/contact.png')),
//             label: 'Business',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.school),
//             label: 'School',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
