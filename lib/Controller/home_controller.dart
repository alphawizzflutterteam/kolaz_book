import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/get_profile_model.dart';
import '../Models/update_profile_model.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class HomeController extends AppBaseController {



  TextEditingController firstnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  ProfileDataList? profiledata;

  String? id;
  String? firstname;
  String? lastname;
  String? updatedata;



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
      GetProfile res = await api.getProfile(body);
      if (!(res.error ?? true)) {
        profiledata = res.data  ;
        firstname = profiledata?.fname;
        lastname = profiledata?.lname;
        update();

        firstnameController.text = profiledata?.fname ?? "";

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
}