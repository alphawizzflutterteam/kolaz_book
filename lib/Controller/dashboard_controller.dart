import 'package:flutter/cupertino.dart';

import 'appbased_controller/appbase_controller.dart';

class DashBoardController extends AppBaseController {




  final List<Widget> handlePages = [


  ];

  int currentIndex = 0;
  bool isLoading = false;



  void setPageIndex(int i ){
    currentIndex = i;
    update();
  }


}