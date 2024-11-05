import 'package:encrypt/encrypt.dart';

import '../arch/net/config.dart';

class AesUtil{

  static String decrypt(String plainText){
    try {
      final key = Key.fromUtf8(NetConfig.AES_KEY);
      final iv = IV.fromUtf8(NetConfig.AES_KEY);
      final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
      final decrypted = encrypter.decrypt16(plainText,iv: iv);
      return decrypted;
    }catch(e){
    }
    return "";
  }

  static String encrypt(String plainText) {
    try {
      final key = Key.fromUtf8(NetConfig.AES_KEY);
      final iv = IV.fromUtf8(NetConfig.AES_KEY);
      final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base16;
    } catch (e) {
    }
    return "";
  }

}