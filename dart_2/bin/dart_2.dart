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
  stdout.write(list);

  print('\n\n1.범위설정  2.검색');
  String check = stdin.readLineSync();
  switch (check) {
    case '1':
      print('어디까지?');
      int count = stdin.readByteSync();

      print('\n');
      print(list.take(count - 48).toList());
      print('\n');
      break;
    case '2':
      print('검색할 단어를 입력하세요.');
      String element = stdin.readLineSync();
      if (list.contains(element) == true) {
        print('\n');
        print([element]);
        print('\n');
        break;
      } else {
        print('검색 결과가 없습니다.');
        break;
      }
      break;
  }
}
