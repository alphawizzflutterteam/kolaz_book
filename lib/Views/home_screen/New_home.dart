// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kolazz_book/Controller/home_controller.dart';
// import 'package:kolazz_book/Views/edit_profile/edit_profile.dart';
// import 'package:kolazz_book/Views/profile/Profile.dart';
//
// import '../../Utils/colors.dart';
//
// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);
//
//   @override
//   State<Homepage> createState() => _HomepageState();
// }
//
// class _HomepageState extends State<Homepage> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: HomeController(),
//       builder: (controller) {
//       return Scaffold(
//         backgroundColor: AppColors.primary,
//         appBar: AppBar(
//           backgroundColor:AppColors.secondary ,
//           toolbarHeight: 79,
//           leading:  Padding(
//             padding: const EdgeInsets.only(left: 5, right: 0),
//             child: InkWell(
//               onTap: () {
//
//
//
//               },
//               child:GestureDetector(
//                 onTap: (){
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => MyProfilePage(),));
//                   Get.to(MyProfilePage());
//                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfilePage()));
//                 },
//                 child: const CircleAvatar(
//                     radius: 20,
//                     child:Icon(Icons.person)
//                 ),
//               ),
//             ),
//           ),
//           title: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text("Gayatri Chouhan",style: TextStyle(color: AppColors.AppbtnColor,fontSize: 15),),
//               Text("15 Days Free Trial ",style: TextStyle(fontSize: 12),),
//             ],
//           ),
//
//
//           actions: [
//             Row(
//
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Container(
//                       height: 37,
//                       width: 40,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: AppColors.primary
//
//
//                       ),
//                       child: const Icon(Icons.notifications)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Container(
//                       height: 37,
//                       width: 40,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: AppColors.primary
//
//
//                       ),
//                       child: const Icon(Icons.message)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Container(
//                       height: 37,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(8),
//                         color: AppColors.primary,
//
//
//                       ),
//                       child: Icon(Icons.settings)),
//                 ),
//
//
//               ],)
//           ],
//           elevation: 0,
//
//           centerTitle: false,
//         ),
//
//         body: Container(
//           child: Column(children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Row(
//                 children: const [
//                   SizedBox(width: 5,),
//                   Padding(
//                     padding: EdgeInsets.only(left: 10.0,top: 20),
//                     child: Text("Upcoming Client Jobs", style: TextStyle(fontSize: 17, color: AppColors.whit, fontWeight: FontWeight.w700)),
//                   ),
//                 ],
//               ),
//             ),
//
//             _clientCard(context),
//             SizedBox(height: 20,),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Row(
//                 children: const [
//                   SizedBox(width: 5,),
//                   Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Text("Upcoming Freelencing jobs", style: TextStyle(fontSize: 17, color: AppColors.whit, fontWeight: FontWeight.w700)),
//                   ),
//                 ],
//               ),
//             ),
//             _clientCard2(context),
//             const SizedBox(height: 20,),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Row(
//                 children: const [
//                   SizedBox(width: 5,),
//                   Padding(
//                     padding: EdgeInsets.all(10.0),
//                     child: Text("Photographer Yet To Be Allotment Clients Jobs ", style: TextStyle(fontSize: 17, color:AppColors.whit, fontWeight: FontWeight.w700)),
//                   ),
//                 ],
//               ),
//             ),
//             _clientCard3(context),
//
//           ],),
//
//         ),
//       );
//     },);
//   }
//
//   Widget _clientCard(BuildContext context){
//     return
//     Container(
//       height: MediaQuery.of(context).size.height/5.8,
//       child: GridView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio:5.7 / 9.0,
//           crossAxisCount: 1,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             onTap: () {
//             },
//             child: Padding(
//                 padding: const EdgeInsets.all(4),
//                 child:  Card(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   color: Colors.black12,
//                   elevation: 2,
//                   child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("Order Id",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("KB003",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("Client Name",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("Shubham",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//
//
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("City:",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("Ujjain",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("Event  ",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("Wedding",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Date",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("28/April/2023",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),),
//             ),
//           );
//         },
//       ),
//     );
//   }
//   Widget _clientCard2(BuildContext context){
//     return
//     Container(
//       height: MediaQuery.of(context).size.height/5.6,
//       child: GridView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio:4.7 / 7.0,
//           crossAxisCount: 1,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             onTap: () {
//               // Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails(id: foodCategoryModel!.product![index].id)));
//             },
//             child: Padding(
//                 padding: EdgeInsets.all(5),
//                 child:  Card(
//
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   color: Colors.black12,
//                   elevation: 2,
//                   child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Order Id",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("KB003",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Photographer Name",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("Shubham",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//
//
//
//
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("City:",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("Ujjain",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Event  ",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("Wedding",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Date",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("28/April/2023",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),),
//             ),
//           );
//         },
//       ),
//     );
//   }
//   Widget _clientCard3(BuildContext context){
//     return
//     Container(
//       height: MediaQuery.of(context).size.height/8.3,
//
//       child: GridView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 10,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           childAspectRatio:4.7 / 10.3,
//           crossAxisCount: 1,
//         ),
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             onTap: () {
//               // Navigator.push(context, MaterialPageRoute(builder: (context) => GroceryDetails(id: foodCategoryModel!.product![index].id)));
//             },
//             child: Padding(
//                 padding: EdgeInsets.all(5),
//                 child:  Card(
//
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   color: Colors.black12,
//                   elevation: 2,
//                   child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text("Order Id",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("KB003",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Client Name",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("Jhani Shah",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//
//
//                     Padding(
//                       padding: const EdgeInsets.only(top: 10.0,left: 10,right: 10),
//
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("City:",style: TextStyle(color: AppColors.AppbtnColor),),
//                           Text("Mumbai",style: TextStyle(color: AppColors.whit),),
//                         ],
//                       ),
//                     ),
//
//
//                   ],
//                 ),),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
