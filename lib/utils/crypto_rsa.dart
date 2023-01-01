import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/pointycastle.dart';

class CryptoRSA {
  late String publicKeyPemBase64;

  static final CryptoRSA _instance = CryptoRSA._internal();
  CryptoRSA._internal();

  factory CryptoRSA({required String publicKeyPemBase64}) {
    _instance.publicKeyPemBase64 = publicKeyPemBase64;
    return _instance;
  }

  Future<String> makePasswordSecret(String plainText) async {
    final String publicKeyStr = utf8.decode(base64.decode(publicKeyPemBase64));
    RSAKeyParser rsaKeyParser = RSAKeyParser();
    RSAAsymmetricKey publicKeyParser = rsaKeyParser.parse(publicKeyStr);
    final publicKey =
        RSAPublicKey(publicKeyParser.modulus!, publicKeyParser.exponent!);
    final encrypter = Encrypter(RSA(publicKey: publicKey));
    final secret = encrypter.encrypt(plainText);
    return secret.base64.toString();
  }
}
