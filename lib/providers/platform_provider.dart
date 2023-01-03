import 'package:flutter/foundation.dart';

// Global variables for App Platform management
class Platform extends ChangeNotifier {
  int _servicePageNum = 0;
  bool _isLoading = false;
  bool _allowAlarm = true;

  int get servicePageNum => _servicePageNum;
  bool get isLoading => _isLoading;
  bool get allowAlarm => _allowAlarm;

  set servicePageNum(int value) {
    _servicePageNum = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set allowAlarm(bool value) {
    _allowAlarm = value;
    notifyListeners();
  }
}
