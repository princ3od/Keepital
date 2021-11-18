import 'package:get/get.dart';
import 'package:keepital/app/modules/event/event_controller.dart';

class EventBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EventController>(() => EventController());
  }
}
