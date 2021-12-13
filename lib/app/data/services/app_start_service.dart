import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';

class AppStartService {
  AppStartService._privateConstructor();
  static final AppStartService instance = AppStartService._privateConstructor();

  initFirebase() async {
    await Firebase.initializeApp();
    print('Init Firebase');
  }

  initGetStorage() async {
    await GetStorage.init();
    print('Init storage');
  }
}
