import 'package:test/test.dart';

String _checkTypeEmployee(String credential) {
  // must be "t" or "x"

  var credentialLower = credential.toLowerCase();

  if (credentialLower.startsWith("t")) {
    return "t";
  } else if (credentialLower.startsWith("x")) {
    if (credentialLower.length == 7 &&
        _isNumeric(credentialLower.substring(1, 7))) {
      return "x";
    } else {
      return "t";
    }
  } else {
    return "t";
  }
}

bool _isNumeric(String s) {
  return double.tryParse(s) != null;
}

void main() {
  test("Checa o funcionamento do @checkTypeEmployee", () {
    //casos normais
    expect(_checkTypeEmployee("x265876"), "x");
    expect(_checkTypeEmployee("t123456"), "t");

    //casos excepcionais
    expect(_checkTypeEmployee("x2658764"), "t");
    expect(_checkTypeEmployee("nborges"), "t");
    expect(_checkTypeEmployee("emanuel"), "t");
    expect(_checkTypeEmployee("dinossauro"), "t");
    expect(_checkTypeEmployee("xavier"), "t");
    expect(_checkTypeEmployee("xxmanuel"), "t");
    expect(_checkTypeEmployee("X"), "t");
    expect(_checkTypeEmployee("22658764"), "t");
    expect(_checkTypeEmployee("xpto123"), "t");
  });
}
