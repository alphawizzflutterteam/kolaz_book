// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:kolazz_book/Utils/colors.dart';
//
// class BottomBar extends StatefulWidget {
//   const BottomBar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomBar> createState() => _BottomBarState();
// }
//
// class _BottomBarState extends State<BottomBar> {
//   @override
//   Widget build(BuildContext context) {
    // return GetBuilder(builder: (controller) {
    //   return Material(
    //       color:AppColors.primary,
    //       child: Container(
    //         decoration: BoxDecoration(
    //           color:AppColors.primary,
    //           boxShadow: [
    //             BoxShadow(
    //                 color: Theme.of(context).colorScheme.black26, blurRadius: 10)
    //           ],
    //         ),
    //         child: TabBar(
    //           onTap: (_) {
    //             if (_tabController.index == 3) {
    //               if (CUR_USERID == null) {
    //                 Navigator.push(
    //                   context,
    //                   MaterialPageRoute(
    //                     builder: (context) => Login(),
    //                   ),
    //                 );
    //                 _tabController.animateTo(0);
    //               }
    //             }
    //           },
    //           controller: _tabController,
    //           tabs: [
    //             Tab(
    //               icon: _selBottom == 0
    //                   ? SvgPicture.asset(
    //                 imagePath + "sel_home.svg",
    //                 color: colors.primary,
    //               )
    //                   : SvgPicture.asset(
    //                 imagePath + "desel_home.svg",
    //                 color: colors.primary,
    //               ),
    //               text:
    //               _selBottom == 0 ? getTranslated(context, 'HOME_LBL') : null,
    //             ),
    //             Tab(
    //               icon: _selBottom == 1
    //                   ? SvgPicture.asset(
    //                 imagePath + "category01.svg",
    //                 color: colors.primary,
    //               )
    //                   : SvgPicture.asset(
    //                 imagePath + "category.svg",
    //                 color: colors.primary,
    //               ),
    //               text:
    //               _selBottom == 1 ? getTranslated(context, 'category') : null,
    //             ),
    //             Tab(
    //               icon: _selBottom == 2
    //                   ? SvgPicture.asset(
    //                 imagePath + "sale02.svg",
    //                 color: colors.primary,
    //               )
    //                   : SvgPicture.asset(
    //                 imagePath + "sale.svg",
    //                 color: colors.primary,
    //               ),
    //               text: _selBottom == 2 ? getTranslated(context, 'SALE') : null,
    //             ),
    //             Tab(
    //               icon: Selector<UserProvider, String>(
    //                 builder: (context, data, child) {
    //                   return Stack(
    //                     children: [
    //                       Center(
    //                         child: _selBottom == 3
    //                             ? SvgPicture.asset(
    //                           imagePath + "cart01.svg",
    //                           color: colors.primary,
    //                         )
    //                             : SvgPicture.asset(
    //                           imagePath + "cart.svg",
    //                           color: colors.primary,
    //                         ),
    //                       ),
    //                       (data != null && data.isNotEmpty && data != "0")
    //                           ? Positioned.directional(
    //                         bottom: _selBottom == 3 ? 6 : 20,
    //                         textDirection: Directionality.of(context),
    //                         end: 0,
    //                         child: Container(
    //                           decoration: BoxDecoration(
    //                               shape: BoxShape.circle,
    //                               color: colors.primary),
    //                           child: Center(
    //                             child: Padding(
    //                               padding: EdgeInsets.all(3),
    //                               child: Text(
    //                                 data,
    //                                 style: TextStyle(
    //                                     fontSize: 7,
    //                                     fontWeight: FontWeight.bold,
    //                                     color: Theme.of(context)
    //                                         .colorScheme
    //                                         .white),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       )
    //                           : Container()
    //                     ],
    //                   );
    //                 },
    //                 selector: (_, homeProvider) => homeProvider.curCartCount,
    //               ),
    //               text: _selBottom == 3 ? getTranslated(context, 'CART') : null,
    //             ),
    //             // Tab(
    //             //   icon: _selBottom == 4
    //             //       ? SvgPicture.asset(
    //             //           imagePath + "profile01.svg",
    //             //           color: colors.primary,
    //             //         )
    //             //       : SvgPicture.asset(
    //             //           imagePath + "profile.svg",
    //             //           color: colors.primary,
    //             //         ),
    //             //   text:
    //             //       _selBottom == 4 ? getTranslated(context, 'ACCOUNT') : null,
    //             // ),
    //           ],
    //           indicator: UnderlineTabIndicator(
    //             borderSide: BorderSide(color: colors.primary, width: 5.0),
    //             insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 70.0),
    //           ),
    //           labelColor: colors.primary,
    //           labelStyle: TextStyle(fontSize: 8 , fontWeight: FontWeight.w600),
    //         ),
    //       ))
    // },);
//   }
// }
