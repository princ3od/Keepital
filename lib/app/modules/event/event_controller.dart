import 'package:get/get.dart';
import 'package:keepital/app/core/values/app_value.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/data/providers/event_provider.dart';
import 'package:keepital/app/routes/pages.dart';

class EventController extends GetxController {
  var events = <Event>[];
  var finishedEvents = <Event>[].obs;
  var onGoingEvents = <Event>[].obs;
  var isLoading = false.obs;
  EventProvider _eventProvider = EventProvider();
  @override
  void onInit() async {
    isLoading.value = true;
    await Future.delayed(AppValue.delayTime);
    final _events = await _eventProvider.fetchAll();
    onGoingEvents.addAll(_events.where((element) => !element.isFinished));
    finishedEvents.addAll(_events.where((element) => element.isFinished));
    isLoading.value = false;
    super.onInit();
  }

  Future<void> onAddEvent() async {
    final result = await Get.toNamed(Routes.addEvent);
    if (result != null) {
      isLoading.value = true;
      onGoingEvents.add(result);
      isLoading.value = false;
    }
  }
}
