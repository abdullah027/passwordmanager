
import 'package:encrypt/encrypt.dart';

String? encrypt(String? text){

  final key = Key.fromUtf8('SecretKeyForEncryptionAndDecrypt');
  final iv = IV.fromUtf8('helloworldhellow');
  final encryptor = Encrypter(AES(key,mode: AESMode.cbc));
  final encrypted = encryptor.encrypt(text!,iv: iv);
  print(encrypted);
  return encrypted.base64;
}

String? decrypt(dynamic text){

  final key = Key.fromUtf8('SecretKeyForEncryptionAndDecrypt');
  final iv = IV.fromUtf8('helloworldhellow');
  final encryptor = Encrypter(AES(key,mode: AESMode.cbc));
  final decrypted = encryptor.decrypt64(text,iv: iv);
  return decrypted;

}