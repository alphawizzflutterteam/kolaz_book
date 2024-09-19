import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'Route_managements/all_pages.dart';
import 'Route_managements/routes.dart';
import 'Route_managements/screen_bindings.dart';

void main() {

  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreen,
      getPages: AllPages.getPages(),
      initialBinding: ScreenBindings(),
      title: 'Kolaz Book',
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff595858)),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),

    );
  }
}


