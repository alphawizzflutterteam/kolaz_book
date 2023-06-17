import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:kolazz_book/Models/logout_model.dart';
import 'package:kolazz_book/Route_managements/routes.dart';
import 'package:kolazz_book/Utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/get_profile_model.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class ProfileController extends AppBaseController {


  TextEditingController firstnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  ProfileData? profiledata;
  // String? logout;

  String? id;
  String? deviceid;
  String? firstname;
  String? lastname;
  String? updatedata;

  String?logout;



  @override
  void onInit() {
    // TODO: implement onInit
    getProfile();
    //update();
    super.onInit();
  }



  Future<void>getProfile() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[
      RequestKeys.userId] = id!;
      GetProfileModel res = await api.getProfile(body);
      if (!(res.error ?? true)) {
        profiledata = res.data  ;
        firstname = profiledata?.fname;
        lastname = profiledata?.lname;
        firstnameController.text = profiledata?.fname ?? "";
        usernameController.text = profiledata?.username ?? "";

        // Fluttertoast.showToast(msg:res.message ?? '' );
        // ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        update();
      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();

    }
  }

  Future<void>logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    deviceid = preferences.getString('deviceId');
    print('___________${deviceid}');
    print('useridishere________${id}');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[
      RequestKeys.userId] = id!;
      body[RequestKeys.deviceid] = deviceid!;
      LogoutModel res = await api.logoutApi(body);
      if(res.status == '1' ) {
        print("logout_successssss____________");
        logout = res.status;
        preferences.setString('id', '');
        preferences.setString('deviceId', '');
        Fluttertoast.showToast(msg:res.msg ?? '' );
        Get.toNamed(loginScreen);
        setBusy(false);
        update();
      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();

    }
  }

  Future<void>logOutAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    deviceid = preferences.getString('deviceId');
    print('___________${deviceid}');
    print('useridishere________${id}');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[
      RequestKeys.userId] = id!;

      LogoutModel res = await api.logoutApi(body);
      if(res.status == '1' ) {
        print("logout_successssss____________");
        preferences.setString('id', '');
        preferences.setString('deviceId', '');
        logout = res.status;
        Fluttertoast.showToast(msg:res.msg ?? '' );
        // Get.toNamed(loginScreen);
        setBusy(false);
        update();
      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();

    }
  }

}