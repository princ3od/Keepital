import 'package:keepital/app/data/models/keepital_user.dart';
import 'package:keepital/app/data/providers/user_provider.dart';
import 'package:keepital/app/data/providers/wallet_provider.dart';
import 'package:keepital/app/data/services/auth_service.dart';

class DataService {
  DataService._privateConstructor();
  static final DataService instance = DataService._privateConstructor();

  static KeepitalUser? currentUser;

  loadUserData() async {
    currentUser = await UserProvider().fetch(AuthService.instance.currentUser!.uid);
    currentUser!.wallets = await WalletProvider().fetchAll();
  }
}
