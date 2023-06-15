
import 'package:kolazz_book/Models/faq_model.dart';


import '../Widgets/show_message.dart';
import 'appbased_controller/appbase_controller.dart';

class FaqController extends AppBaseController {

  List<Faqdata> getfaq = [];

  Future<void> onInit() async {
    // TODO: implement onInit
    getFaq();
    super.onInit();
  }
  Future<void>getFaq() async {
    setBusy(true);
    try {
      Map<String, String> body = {};
      Faq res = await api.getFaqApi(body);
      print('${res.status}_____________');
      if(res.status == '1'){
        print('${res.setting?.first.title}_____________');
        getfaq = res.setting ?? [];
        
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