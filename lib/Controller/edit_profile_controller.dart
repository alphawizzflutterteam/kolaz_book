import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:kolazz_book/Models/get_cities_model.dart';
import 'package:kolazz_book/Models/get_country_model.dart';
import 'package:kolazz_book/Models/get_states_model.dart';
import 'package:kolazz_book/Utils/strings.dart';
import 'package:kolazz_book/Views/home_screen/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Models/get_profile_model.dart';
import '../Models/update_profile_model.dart';
import '../Services/request_keys.dart';
import '../Utils/colors.dart';
import '../Views/dashboard/Dashboard.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class EditProfileController extends AppBaseController {

  TextEditingController firstnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController companynameController = TextEditingController();
  TextEditingController companyphoneController = TextEditingController();
  TextEditingController companyaddressController = TextEditingController();
  TextEditingController companyStateController = TextEditingController();
  TextEditingController companyEmailController = TextEditingController();
  // TextEditingController countryController = TextEditingController();
  TextEditingController perdayController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();
  TextEditingController termsconditionControlletr = TextEditingController();


  ProfileData? profiledata;

  String? id;
 String? firstname;
 String? lastname;
 String? profilePic;
 String? companyLogo;
 String? countryId, stateId;
  UpdateProfile ? updateprofile;
 String? updatedata;
  List<CityList> citiesList = [];
  List<StateList> statesList = [];
  List<Countries> countryList = [];
  var cityController;
  var countryController;
  var stateController;

  bool isCountry = true;
  bool isState = true;
  bool isCity = true;


  getCitiesList(String stateId) async {
    var uri = Uri.parse(getCitiesApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['state_id'] = stateId.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
      citiesList = GetCitiesModel.fromJson(userData).data!;
      update();
  }

  sendHelpSupportMessage(BuildContext context) async {
    var uri = Uri.parse(helpSupportApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    request.fields['name'] = '${firstnameController.text.toString()} ${lastnameController.text.toString()}';
    request.fields['email'] = emailController.text.toString();
    request.fields['message'] = messageController.text.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    Fluttertoast.showToast(msg: userData['message']);
    Navigator.pop(context);
    // citiesList = GetCitiesModel.fromJson(userData).data!;
    update();
  }

  getStateList(String countryId) async {
    var uri = Uri.parse(getStatesApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
     request.fields['country_id'] = countryId.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    statesList = GetStatesModel.fromJson(userData).data!;
    update();
  }

  getCountryList() async {
    var uri = Uri.parse(getCountryApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
    // request.fields['type_id'] = "1";
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    countryList = GetCountryModel.fromJson(userData).data!;
    update();
  }

  removeProfileImage(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? id = preferences.getString('id');
    var uri = Uri.parse(removeProfileImageApi.toString());
    // '${Apipath.getCitiesUrl}');
    var request = http.MultipartRequest("POST", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };

    request.headers.addAll(headers);
     request.fields[RequestKeys.userId] = id.toString();
    // request.fields['vendor_id'] = userID;
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    Fluttertoast.showToast(msg: userData['message']);
    Navigator.pop(context);
    Navigator.pop(context);

    print("this is country list ${countryList.length}");

  }


  @override
  void onInit() {
    getProfile();
    getCountryList();
    // getStateList();
    // getCitiesList();
    //update();
    super.onInit();
  }

  Future<void>getProfile() async {
    print("working");
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
        profilePic = profiledata?.profilePic;
        companyLogo = profiledata?.companyLogo;
         // SharedPreferences prefe = await SharedPreferences.getInstance();
         // prefe.setString('name',firstname!);
        firstnameController.text = profiledata?.fname ?? "";
        usernameController.text = profiledata?.username ?? "";
        lastnameController.text= profiledata?.lname??'';
        emailController.text= profiledata?.email??'';
        mobileController.text = profiledata?.mobile ??'';
        companynameController.text= profiledata?.companyName??'';
        companyphoneController.text= profiledata?.companyNumber??'';
        companyaddressController.text= profiledata?.companyAddress??'';
        countryController = profiledata?.country??'';
        isCountry = true;
        stateController = profiledata?.state ?? "";
        isState =true;
        cityController = profiledata?.city?? "";
        isCity = true;
        //  countryController = profiledata?.country ?? '';
         // stateController = profiledata?.sta
         // companyStateController.text = profiledata?.country ?? '';

        companyEmailController.text = profiledata?.companyLink??'';
        facebookController.text = profiledata?.facebook??'';
        instagramController.text = profiledata?.instagram??'';
        youtubeController.text = profiledata?.youtube??'';
        termsconditionControlletr.text = profiledata?.note??'';
        print("this is my profile image $profilePic");
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

  updateProfile() async {
    print("working here!!");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setBusy(true);

    var headers = {'Cookie': 'ci_session=cf2fmpq7vue0kthvj5s046uv4m2j5r11'};

    Map<String, String> body = {};
    body[RequestKeys.Id] = id!;
    body[RequestKeys.firstname] = firstnameController.text.trim();
    body[RequestKeys.lastname] = lastnameController.text.trim();
    body[RequestKeys.email] = emailController.text.trim();
    body[RequestKeys.mobile] = mobileController.text.trim();
    body[RequestKeys.companyname] = companynameController.text.trim();
    body[RequestKeys.companyphone] = companyphoneController.text.trim();
    body[RequestKeys.companyaddress] = companyaddressController.text.trim();
     body[RequestKeys.city] = cityController != null ? cityController.toString() : "";
    body[RequestKeys.state] = stateController != null ? stateController.toString() : "";
    body[RequestKeys.companyaddress] = companyaddressController.text.trim();
    body[RequestKeys.companyEmail] = companyEmailController.text.trim();
    body[RequestKeys.facebookLink] = facebookController.text.trim();
    body[RequestKeys.instagramLink] = instagramController.text.trim();
    body[RequestKeys.youtubeLink] = youtubeController.text.trim();
    body[RequestKeys.tncLink] = termsconditionControlletr.text.trim();
    body[RequestKeys.country] = countryController != null ? countryController.toString() :  "";
    var request = http.MultipartRequest(
        'POST', Uri.parse(updateUserProfileApi.toString()));
    request.fields.addAll(body);


    imageFile == null ? null : request.files.add(
        await http.MultipartFile.fromPath(
            RequestKeys.profileImage, imageFile!.path.toString()));


    imageFile2 == null ? null : request.files.add(
        await http.MultipartFile.fromPath(
            RequestKeys.companyImage, imageFile2!.path.toString()));


    print("ok++++++++======>>>> ${request.files}");
    request.headers.addAll(headers);

    var response = await request.send();


    print("this is response =========>>>> ${response.statusCode}");

    if (response.statusCode == 200) {
      String str = await response.stream.bytesToString();
      var data = json.decode(str.toString());
      final jsonResponse = UpdateProfile.fromJson(data);
      if (jsonResponse.status == "success") {
        Fluttertoast.showToast(msg: "${jsonResponse.message}");
        Fluttertoast.showToast(msg: jsonResponse.message ?? '');
        setBusy(false);
        Get.to(DashBoard());
        update();
      } else {
        ShowMessage.showSnackBar('Server Res', jsonResponse.message ?? '');

      }
    } else {
      Fluttertoast.showToast(msg: "Error during communication : server error");
      print(response.reasonPhrase);
    }
  }



  // Future<void>updateProfile() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   id = preferences.getString('id');
  //   setBusy(true);
  //   try {
  //     Map<String, String> body = {};
  //     body[RequestKeys.Id] = id!;
  //     body[RequestKeys.firstname] = firstnameController.text.trim();
  //     body[RequestKeys.lastname] = lastnameController.text.trim();
  //     body[RequestKeys.email] = emailController.text.trim();
  //     body[RequestKeys.mobile] = mobileController.text.trim();
  //     body[RequestKeys.companyname] = companynameController.text.trim();
  //     body[RequestKeys.companyphone] = companyphoneController.text.trim();
  //     body[RequestKeys.companyaddress] = companyaddressController.text.trim();
  //     // body[RequestKeys.city] = cityController.trim();
  //     body[RequestKeys.state] = companyStateController.text.toString();
  //     body[RequestKeys.companyaddress] = companyaddressController.text.trim();
  //     body[RequestKeys.companyEmail] = companyEmailController.text.trim();
  //     body[RequestKeys.facebookLink] = facebookController.text.trim();
  //     body[RequestKeys.instagramLink] = instagramController.text.trim();
  //     body[RequestKeys.youtubeLink] = youtubeController.text.trim();
  //     body[RequestKeys.tncLink] = termsconditionControlletr.text.trim();
  //     body[RequestKeys.country] = countryController.text.trim();
  //     imageFile2 != null ?
  //     body[RequestKeys.profileImage] = imageFile!.path
  //     :  body[RequestKeys.profileImage] = '';
  //     imageFile2 != null ?
  //     body[RequestKeys.companyImage] = imageFile2!.path
  //     :  body[RequestKeys.companyImage] = '';
  //     UpdateProfile res = await api.updateProfileApi(body);
  //
  //     print("thisis response ${res.status}");
  //     print("_______________________>>>>>>>>${body.toString()}");
  //
  //     if(res.status == 'success' ) {
  //       updatedata = res.message?? "";
  //       print('this is message------>${res.message}');
  //       Fluttertoast.showToast(msg:res.message ?? '' );
  //       ShowMessage.showSnackBar('Server Res', res.message ?? '');
  //       setBusy(false);
  //       Get.to(DashBoard());
  //       update();
  //     }
  //
  //   } catch (e) {
  //     ShowMessage.showSnackBar('Server Res', '$e');
  //   } finally {
  //     setBusy(false);
  //     update();
  //   }
  // }

  File? imageFile;
  File? imageFile2;
  String? imagePath;

  void Dialoguebox(String type){
    Get.defaultDialog(
        title:'Select Image',
        backgroundColor: Colors.white,
        titleStyle: TextStyle(color:AppColors.back),
        radius: 10,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                _getFromCamera(type);
              },
              child:Text('Camera'),
            ),
            const SizedBox(width: 15,),
            ElevatedButton(
              onPressed: (){
                _getFromGallery(type);
              },
              child:const Text('Gallery'),
            ),
          ],
        )
    );

  }

  _getFromGallery(String type) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      if(type =='profile') {
        imageFile = File(pickedFile.path);
      }else {
        imageFile2 = File(pickedFile.path);
      }
      print('image======${imageFile}');
      Get.back();
      update();
    }

  }
  _getFromCamera(String type) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      if(type=='profile') {

        imageFile = File(pickedFile.path);
      }else {

        imageFile2 = File(pickedFile.path);
      }
      Get.back();
      update();
    }
  }


  void requestPermission(BuildContext context,int i) async{
    return await showDialog<void>(
      context: context,
      // barrierDismissible: barrierDismissible, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(6))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () async {
                  getImageGallery(ImgSource.Gallery, context ,i);
                },
                child:  Container(
                  child: ListTile(
                      title:  Text("Gallery"),
                      leading: Icon(
                        Icons.image,
                        color: AppColors.primary,
                      )),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                 getImage(ImgSource.Camera, context, i);
                },
                child: Container(
                  child: ListTile(
                      title:  Text("Camera"),
                      leading: Icon(
                        Icons.camera,
                        color: AppColors.primary,
                      )),
                ),
              ),
              Container(
                width: 200,
                height: 1,
                color: Colors.black12,
              ),
              InkWell(
                onTap: () async {
                  removeProfileImage(context);
                },
                child:  ListTile(
                    title:  Text("Remove Image"),
                    leading: Icon(
                      Icons.delete,
                      color: AppColors.primary,
                    )),
              ),
            ],
          ),
        );
      },
    );

    ///

  }

  Future getImage(ImgSource source, BuildContext context, int i) async {


    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
   // back();
  }
  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    update();
    if (i == 1) {
      imageFile = File(croppedFile!.path);
    } else if (i == 2) {
      imageFile2 = File(croppedFile!.path);
    }
    updateProfile();
    update();
    back();
  }
  Future getImageGallery(ImgSource source, BuildContext context, int i) async {
    var image = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: const Icon(
        Icons.add,
        color: Colors.red,
      ), //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    getCropImage(context, i, image);
   // back();
  }


}