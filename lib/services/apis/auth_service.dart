import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:telofarmer_app/models/auth/models.dart';
import 'package:telofarmer_app/utils/http_parser.dart';

class AuthService {
  final _hostAddress = 'datadam.telofarm.com';

  Future<dynamic> getCryptoInfo() async {
    try {
      final res = await http.get(
        Uri(
          scheme: 'https',
          host: _hostAddress,
          path: '/api/auth',
        ),
      );
      if (res.statusCode == 200) {
        return PublicKey.fromJson(json.decode(res.body));
      }
    } catch (err) {
      if (err is SocketException) {
        return 'SOCKET_EXCEPTION';
      } else if (err is TimeoutException) {
        return 'SERVER_TIMEOUT';
      } else {
        return 'UNKNOWN_ERROR';
      }
    }
  }

  Future<dynamic> signIn(String email, String secret) async {
    try {
      final res = await http.post(
          Uri(
            scheme: 'https',
            host: _hostAddress,
            path: '/api/auth',
          ),
          body: jsonEncode(<String, String>{
            'email': email,
            'secret': secret,
          }));
      final body = jsonDecode(res.body);
      final accessToken = HttpParser().getAccessToken(res.headers);
      if (res.statusCode == 200) {
        return AuthEntity.fromJson(body, accessToken);
      }
    } catch (err) {
      if (err is SocketException) {
        return 'SOCKET_EXCEPTION';
      } else if (err is TimeoutException) {
        return 'SERVER_TIMEOUT';
      } else {
        return 'UNKNOWN_ERROR';
      }
    }
  }
}
