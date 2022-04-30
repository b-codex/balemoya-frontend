import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:crypto/crypto.dart';

String hashPassword({required String password}) {
  final hashedPassword = Crypt.sha256(password, salt: 'this_is_random_salt');
  return hashedPassword.toString();
}

String hashValue({required String password}) {
  var bytes = utf8.encode(password);
  var digest = sha512.convert(bytes);

  // print("Digest as bytes: ${digest.bytes}");
  return digest.toString();
}
