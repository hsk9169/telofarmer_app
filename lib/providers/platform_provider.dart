import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';
import 'package:telofarmer_app/models/api/models.dart';

class Platform extends ChangeNotifier {
  AuthEntity _authEntity = AuthEntity();

  AuthEntity get authEntity => _authEntity;

  set authEntity(AuthEntity value) {
    _authEntity = value;
    notifyListeners();
  }
}
