
import '../Models/tnc&privacy_policy_model.dart';
import '../Services/request_keys.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class TermsAndConditionsController extends AppBaseController {

  List<Setting> getprivacypolicy = [];
  List<Setting> getprivacypolicy1 = [];
  List<Setting> getprivacypolicy2 = [];

  Future<void> onInit() async {
    // TODO: implement onInit

    getSetting();
    getTnc();
    aboutUs();
    super.onInit();
  }
  Future<void>getSetting() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.Id] = "1";
      Getsetting res = await api.GetTncPrivacyPolicyApi(body);
      if(res.status == '1'){
        getprivacypolicy = res.setting!;
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

  Future<void>getTnc() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.Id] = "3";
      Getsetting res = await api.GetTncPrivacyPolicyApi(body);
      print("________________________${res.status}");


      if(res.status == '1'){
        print("this Is Privacyyyyyyyyy${getprivacypolicy}");

        getprivacypolicy1 = res.setting!;
        print('${getprivacypolicy.first.title}this is privacypolicyyyyyyyyyyy__________________');
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
  Future<void>aboutUs() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // id = preferences.getString('id');
    setBusy(true);
    try {
      Map<String, String> body = {};
      body[RequestKeys.Id] = "2";
      Getsetting res = await api.GetTncPrivacyPolicyApi(body);
      print("________________________${res.status}");


      if(res.status == '1'){

        getprivacypolicy2 = res.setting!;
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

}