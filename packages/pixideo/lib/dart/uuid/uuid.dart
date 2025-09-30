
import 'dart:math';


String generateUuidAzkadev(
  int length, {
  String text = "0123456789abcdefghijklmnopqrstuvwxyz",
}) {
  return List.generate(length, (index) {
    final String dataText = text[Random().nextInt(text.length)];
    return dataText;
  }).join("");
}

