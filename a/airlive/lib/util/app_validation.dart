bool isNullEmpty(Object? o) => o == null || "" == o;

bool isNullEmptyOrFalse(Object? o) => o == null || false == o || "" == o;

bool isNullEmptyFalseOrZero(Object? o) => o == null || false == o || 0 == o || "" == o || "0" == o;

bool isNumeric(dynamic s) {
  String sConvert = s.toString();
  return (double.tryParse(sConvert) != null || int.tryParse(sConvert) != null);
}
