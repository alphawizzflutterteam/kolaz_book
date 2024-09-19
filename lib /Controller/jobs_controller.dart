
import '../Models/get_quotation_model.dart';
import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class GetQuotationController extends AppBaseController {

  List<Setting> getQuotation = [];

  Future<void> onInit() async {
    // TODO: implement onInit
    getQuotations();
    super.onInit();
  }

  Future<void>getQuotations() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      GetQuotationModel res = await api.getQuotationsAPI(body);
      print('${res.status}_____________');
      if(res.status == '1'){
        print('${res.setting?.first.clientName}_____________');
        getQuotation = res.setting ?? [];

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