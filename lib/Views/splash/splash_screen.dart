import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Utils/colors.dart';
import '../../Controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    final heightSize = MediaQuery.of(context).size.height;
    final widthSize = MediaQuery.of(context).size.width;
    return GetBuilder(
      init: SplashController(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColors.primary3,
              AppColors.primary5,
            ], begin: Alignment.topCenter),

          ),
          child: Image.asset(
            'assets/images/loginlogo.png',
            scale: 15,
          ),
        );
      },
    );
  }
}
