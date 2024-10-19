import 'package:pengastigen/models/user.dart';

class MoneyService {

  void incrementMoney(User user) {
    user.incrementMoney();
  }

  void updateMoney(User user, int newAmount) {
    user.addMoney(newAmount);
  }

  void useMoney(User user) {
    user.useMoney();
  }
}
