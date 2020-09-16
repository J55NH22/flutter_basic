import 'dart:io';

void main() {
  List list = [];

  print("입력하세요.");

  while (true) {
    String data = stdin.readLineSync();
    if (data == '') {
      break;
    }
    list.add(data);
  }
  print(list);
}
