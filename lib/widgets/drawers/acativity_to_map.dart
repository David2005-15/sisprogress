Map<String, int> convertToMap(List<dynamic> input) {
  Map<String, int> map = {};

  for (var element in input) {
    element = element.toString();
    map[element] = (map[element] ?? 0) + 1;
  }

  return map;
}

List<String> convertToList(Map<String, int> input) {
  List<String> list = [];
  input.forEach((key, value) {
    for (int i = 0; i < value; i++) {
      list.add(key);
    }
  });

  return list;
}

String? getValueAt(List<dynamic> list, int index) {
  if (index < 0 || index >= list.length) {
    return null;
  }
  return list[index].toString();
}