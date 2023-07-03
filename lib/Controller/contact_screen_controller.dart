import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kolazz_book/Controller/edit_client_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Type_of_photography_model.dart';
import '../Models/add_clientmodel.dart';
import '../Models/add_photographermodel.dart';
import '../Models/client_model.dart';
import '../Models/photographer_client_model.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class addPhotographerController extends AppBaseController {
  final formKey = GlobalKey<FormState>();


  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController photogreaphertypeController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController perdayController = TextEditingController();
  TextEditingController searchController =  TextEditingController();

  String? userData;
  AddPhotographer? addPhotographer;

  String? userId;
  String? id;
  // Categories?
  var categoryValue;
  String? newValue;


  Future<void>AddPhotographerr() async {
    print("working here!!");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};

      body[RequestKeys.firstname] = firstnameController.text.trim();
      body[RequestKeys.lastname] = lastnameController.text.trim();
      body[RequestKeys.city] = cityController.text.trim();
      body[RequestKeys.mobile] = mobileController.text.trim();
      body[RequestKeys.photographertype] =categoryValue?.toString() ?? '';
      body[RequestKeys.companyname] = companyController.text.trim();
      body[RequestKeys.perdaycharge] = perdayController.text.trim();
      body[RequestKeys.userId] = id!;

      print("This is request_________________________${body}");


      AddPhotographer res = await api.addPhotographeApi(body);
      if (!(res.error ?? true)) {
        userData =res.message ;
        print('this is message------>${res.message}');
         Fluttertoast.showToast(msg:res.message ?? '' );
        ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        onTapClear();
        getClientPhotographer();

        Get.back();

        update();
      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  String? clientdata;
  Addclientmodel? addClient;

  Future<void>AddClient() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.firstname] = firstnameController.text.trim();
      body[RequestKeys.lastname] = lastnameController.text.trim();
      body[RequestKeys.city] = cityController.text.trim();
      body[RequestKeys.mobile] = mobileController.text.trim();
      body[RequestKeys.userId] = id!;



      Addclientmodel res = await api.addClientApi(body);
      if (!(res.error ?? true)) {
        clientdata =res.message ;
        print('this is message------>${res.message}');
        Fluttertoast.showToast(msg:res.message ?? '' );
        ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        onTapClear();
        getClientPhotographer();
        getClienttlist();
        Get.back();
        update();
      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  Future<void>editClient(String vid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.firstname] = firstnameController.text.trim();
      body[RequestKeys.lastname] = lastnameController.text.trim();
      body[RequestKeys.city] = cityController.text.trim();
      body[RequestKeys.mobile] = mobileController.text.trim();
      body[RequestKeys.userId] = userId!;
      body[RequestKeys.type] = 'client';
      body[RequestKeys.Id] = vid.toString();



      EditClientModel res = await api.editClientPhotographer(body);
      if (!(res.error ?? true)) {
        clientdata =res.message ;
        print('this is message------>${res.message}');
        Fluttertoast.showToast(msg:res.message ?? '' );
        ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        onTapClear();
        getClientPhotographer();
        getClienttlist();
        Get.back();
        update();
      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  Future<void>editPhotographer(String vid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    userId = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.firstname] = firstnameController.text.trim();
      body[RequestKeys.lastname] = lastnameController.text.trim();
      body[RequestKeys.city] = cityController.text.trim();
      body[RequestKeys.mobile] = mobileController.text.trim();
      body[RequestKeys.photographertype] =categoryValue.toString() ?? '';
      body[RequestKeys.companyname] = companyController.text.trim();
      body[RequestKeys.perdaycharge] = perdayController.text.trim();
      body[RequestKeys.userId] = userId!;
      body[RequestKeys.type] = 'photographer';
      body[RequestKeys.Id] = vid.toString();



      EditClientModel res = await api.editClientPhotographer(body);
      if (!(res.error ?? true)) {
        clientdata =res.message ;
        print('this is message------>${res.message}');
        Fluttertoast.showToast(msg:res.message ?? '' );
        ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        onTapClear();
        getClientPhotographer();
        Get.back();
        update();
      }

    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  List<PhotogrpaherClientData> getphotographetClient = [];
  List<ClientList> gettClient = [];

  bool isSelected = true;
  String client = 'client';
  String photographers = 'photographers';

  Future<void> getClientPhotographer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = id!;
      // body[RequestKeys.type] = photographers;

      body[RequestKeys.type] = isSelected ? photographers  : client ;
      body[RequestKeys.searchText] = searchController.text.toString();
      update();
      PhotographerClientModel res = await api.getPhtographerclintApi(body);

      if(res.responseCode == "1"){

        getphotographetClient = res.data ??[];
        print('${getphotographetClient.first.firstName}___________');
        update();


        // Fluttertoast.showToast(msg:res.message ?? '' );
        // ShowMessage.showSnackBar('Server Res', res.msg ?? '');
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

  Future<void> getClienttlist() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = id!;
      body[RequestKeys.type] = client ;
      body[RequestKeys.searchText] = searchController.text.toString();
      update();
      ClientModel res = await api.getclintApi(body);

      if(res.responseCode == "1"){

        gettClient = res.data ??[];
        print('${gettClient.first.firstName}___________');
        update();


        // Fluttertoast.showToast(msg:res.message ?? '' );
        // ShowMessage.showSnackBar('Server Res', res.msg ?? '');
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

  List<Categories> typeofPhotographyEvent = [];

  Future<void>GateEventType() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      //body[RequestKeys.userId] = id!;
      TypeofPhotography res = await api.getPhotographertypeApi(body);

      if(res.status == 1){
        typeofPhotographyEvent = res.categories ??[];
        print('${typeofPhotographyEvent.first.resName}thisisres_____________________');
        update();

        // Fluttertoast.showToast(msg:res.message ?? '' );
        // ShowMessage.showSnackBar('Server Res', res.msg ?? '');
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

  // searchTypes(String value) {
  //   if (value.isEmpty) {
  //     GateEventType();
  //     update();
  //   } else {
  //     final suggestions = getphotographetClient.where((element) {
  //       final photographer = element.firstName!.toLowerCase();
  //       print('___element.name_______${element.firstName}_________');
  //       final input = value;
  //       return photographer.contains(input);
  //     }).toList();
  //     getphotographetClient = suggestions;
  //     update();
  //   }
  // }
  //
  // onSearchTextChanged(String text) async {
  //   typeofPhotographyEvent.clear();
  //   if (text.isEmpty) {
  //     update();
  //     return;
  //   }
  //   typeofPhotographyEvent.forEach((userDetail) {
  //     if (userDetail.resName!.contains(text))
  //       typeofPhotographyEvent.add(userDetail);
  //   });
  //   update();
  //
  // }

  searchTypes(String value) {
    // if (value.isEmpty) {
    //   GateEventType();
    //   getClientPhotographer();
    //   update();
    // } else {
      if (isSelected) {
        if (value.isEmpty) {
          GateEventType();
          getClientPhotographer();
          update();
        }else {
          final suggestions = getphotographetClient.where((element) {
            final photographer = element.firstName!.toLowerCase();
            final photographer1 = element.lastName!.toString();
            String lowercaseQuery = value.toLowerCase();
            print('___element.name_______${element.firstName}________${element
                .city}_');
            // final input = value;
            return photographer.contains(lowercaseQuery) ||
                photographer1.contains(lowercaseQuery);
          }).toList();
          getphotographetClient = suggestions;
          update();
        }
      }else {
        if (value.isEmpty) {
          GateEventType();
          getClientPhotographer();
          update();
        } else {
          final suggestions = gettClient.where((element) {
            final photographer = element.firstName!.toLowerCase();
            final photographer1 = element.lastName!.toString();
            String lowercaseQuery = value.toLowerCase();
            print('___element.name_______${element.firstName}________${element
                .city}_');
            // final input = value;
            return photographer.contains(lowercaseQuery) ||
                photographer1.contains(lowercaseQuery);
          }).toList();
          gettClient = suggestions;
          update();
        }
      }
    // }

  }
  onSearchTextChanged(String text) async {
    typeofPhotographyEvent.clear();
    if (text.isEmpty) {
      update();
      return;
    }
    typeofPhotographyEvent.forEach((userDetail) {
      if (userDetail.resName!.contains(text))
        typeofPhotographyEvent.add(userDetail);
    });
    update();

  }



  void onTapClear(){
    firstnameController.clear();
    lastnameController.clear();
    mobileController.clear();
    cityController.clear();
    photogreaphertypeController.clear();
    companyController.clear();
    perdayController.clear();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getClientPhotographer();
    GateEventType();
  }
}