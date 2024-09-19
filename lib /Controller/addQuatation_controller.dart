import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kolazz_book/Models/event_type_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/get_quotation_model.dart';
import '../Models/Type_of_photography_model.dart';
import '../Models/add_clientmodel.dart';
import '../Models/add_quatation_model.dart';
import '../Route_managements/routes.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class AddQuatationController extends AppBaseController {

  final formKey = GlobalKey<FormState>();



  TextEditingController clientNameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController eventController = TextEditingController();
  TextEditingController outputController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  int value1 = 0;

  String? clientdata;
  Addclientmodel? addClient;
  List<String> selectedvlaue = [];

  List<List<String>> stringList = [];

  String? id;

  String photographer = "photographer";

  List<Setting> getQuotation = [];

  // Categories? categoryValue;

  List<DateTime> selectedDates = [];
  String? categories;
  List<int> up= [0];

  void increment(int ind){
      if(up[ind]>=0 && up[ind]<10) {
        up[ind]++;
      }
      update();
  }

  DateTime? adquatationDate;

  int val=0;

  List<Categories> categoryValue = [];




  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: adquatationDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != adquatationDate) {

        adquatationDate = picked;
        selectedDates.add(adquatationDate!);
        stringList.add(selectedvlaue);
        // selectedvlaue.add();
        // selectedvlaue.clear();
        // up[0] = 1;
        update();
        // selectedValue.add(categoryValue!);
    }
  }
  Future<void> onInit() async {
    // TODO: implement onInit
    getQuotations();
    getPhotographerType();
    getEventType();
    super.onInit();
  }
  List<Categories> typeofPhotographyEvent = [];

  List<EventType> eventList = [];

  Future<void>getPhotographerType() async {
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

  Future<void>getEventType() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      //body[RequestKeys.userId] = id!;
      EventTypeModel res = await api.getEventTypeApi(body);

      if(res.status == 1){
        eventList = res.categories ??[];
        print('${eventList[0].cName}thisisres_____________________');
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

  Future<void>getQuotations() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.userId] = id!;
      body[RequestKeys.type] = 'client';
      GetQuotationModel res = await api.getQuotationsAPI(body);
      print('${res.status}_______*******______');
      if(res.status == '1'){
        print('${res.setting?.first.clientName}_____________');
        getQuotation = res.setting ?? [];
        update();
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

  Future<void>addQuatation() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString('id');
    print("initiated $id");
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.clientName] = clientNameController.text.trim();
      body[RequestKeys.city] = cityController.text.trim();
      body[RequestKeys.mobile] = mobileController.text.trim();
      body[RequestKeys.event] = eventController.text.trim();
      body[RequestKeys.userId] = id!;
      body[RequestKeys.outPut] = outputController.text.trim();
      body[RequestKeys.amount] = amountController.text.trim();
        body[RequestKeys.date] = selectedDates.toString();
        body[RequestKeys.type] = photographer.toString();
        for(var i= 0; i< stringList.length; i++) {
          body[RequestKeys.typePhotographer] = stringList.toString();
        }
        print("this is add quotation request $body");
      AddQuatation res = await api.addnewQuatationApi(body);
      if (!(res.error ?? true)) {
        clientdata =res.message ;
        print('this is message------>${res.message}');
        Fluttertoast.showToast(msg:res.message ?? '' );
        ShowMessage.showSnackBar('Server Res', res.message ?? '');
        setBusy(false);
        onTapClear();
        Get.toNamed(moreQuotations);
        getQuotations();
        update();
      }
    } catch (e) {
      ShowMessage.showSnackBar('Server Res', '$e');
    } finally {
      setBusy(false);
      update();
    }
  }

  void onTapClear(){
    clientNameController.clear();
    lastnameController.clear();
    cityController.clear();
    mobileController.clear();
    eventController.clear();
    outputController.clear();
    amountController.clear();
    selectedvlaue.clear();
    selectedDates.clear();
  }

  selectValue(Categories newValue, int index){
   typeofPhotographyEvent[index].selectedValue = newValue;
   print("____this is newValueeeeeeeeeeee${newValue.resId}");
    selectedvlaue.add(typeofPhotographyEvent[index].selectedValue!.resId.toString());
    print("__________________${selectedvlaue}");

    print('________this____is__________stringlist${stringList}');
  }

}

