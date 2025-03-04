import 'package:encrypt/encrypt.dart';

import 'package:flutter/services.dart';
import 'package:pointycastle/pointycastle.dart';

class Encrypt {
  static Future<String> rsaEncrypt(String message) async {
    final keyData = await rootBundle.loadString('public.pem');
    final parser = RSAKeyParser();
    final publicKey =
        parser.parse(keyData) as RSAPublicKey; // Cast to RSAPublicKey
    // Create the encryption options object
    final encrypter = Encrypter(
      RSA(
        publicKey: publicKey,
      ),
    );
    final encrypted = encrypter.encrypt(message);
    return encrypted.base64;
  }
}
