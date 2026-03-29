
import 'package:flutter_getx_boilerplate/screen/a/a_controller.dart';
import 'package:flutter_getx_boilerplate/screen/dashboard/dashboard_controller.dart';
import 'package:get/get.dart';

class GlobalBind implements Bindings {

  static final shared = GlobalBind();

  var _alreadyPutAllControllers = false;

  GlobalBind();

  @override
  void dependencies() {
    if (_alreadyPutAllControllers) {
      return;
    }

    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<AController>(() => AController(), fenix: true);

    _alreadyPutAllControllers = true;
  }
}
