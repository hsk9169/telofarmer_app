import 'package:flutter/foundation.dart';
import 'package:telofarmer_app/models/auth/models.dart';

// Global variables for App Session management
class Session extends ChangeNotifier {
  AuthEntity _authEntity = AuthEntity();

  AuthEntity get authEntity => _authEntity;

  set authEntity(AuthEntity value) {
    _authEntity = value;
    notifyListeners();
  }
}
