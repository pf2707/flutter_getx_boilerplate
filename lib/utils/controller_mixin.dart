
import 'package:get/get.dart';

mixin ControllerMixin {

  var updateUICount = 1.obs;

  var isLoadingData = false.obs;

  prepare() {

  }

  cleanUp() {

  }

  doTasks() {

  }

  doTasksAfterLogin({Function? fnCompleteTask}) {
    forceRefreshUI();
  }

  forceRefreshUI() {
    updateUICount++;
    updateUICount.refresh();
  }

  String? validateInput() {
    return null;
  }
}