import 'dart:math';

String generateId(int length) {
  const String charset = "abcdefghijklmnopqrstuvwxyz0123456789";
  Random random = Random();
  String result = "";

  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(charset.length);
    result += charset[randomIndex];
  }

  return result;
}