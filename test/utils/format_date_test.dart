import 'package:flutter_test/flutter_test.dart';
import 'package:shoppinglist/utils/format_date.dart';

void main() {
  test('Garantindo o formato correto da data', () {
    var dateTest = DateTime(2022, 11, 26, 19, 24, 0);
    var result = formatDate(dateTest);
    expect(result, "26/11/2022 às 19:24");

    dateTest = DateTime(2022, 11, 26, 19, 1, 0);
    result = formatDate(dateTest);
    expect(result, "26/11/2022 às 19:01");
  });
}
