import 'dart:io';

void main() {
  print("이름을 입력하세요.");

  String name = stdin.readLineSync();

  print("안녕, $name!");
}
