
bool isDigitsOnly(String str) {
  return RegExp(r'^\d+$').hasMatch(str);
}