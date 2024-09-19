
import '../Models/subscription_model.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class HelpSupportController extends AppBaseController {

  List<Datum> getPlan = [];

  Future<void> onInit() async {
    // TODO: implement onInit
    getSubscription();
    super.onInit();
  }
  Future<void>getSubscription() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      SubscriptionModel res = await api.getSubscriptionApi(body);
      print('${res.responseCode}_____________');
      if(res.responseCode == '1'){
        print('${res.data?.first.title}_____________');
        getPlan = res.data ?? [];

        update();
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