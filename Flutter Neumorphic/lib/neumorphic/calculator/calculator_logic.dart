// import 'package:flutter/material.dart';
//
// import '../../math_expressions/math_expressions.dart';
//
// class Calculator extends ChangeNotifier {
//   num _value = 0;
//   List<CalculatorVariable> _actions = [CalculatorNumber('0')];
//
//   num get value => _value;
//   CalculatorVariable get currentVariable => _actions.last;
//
//   void add() {
//     takeAction(
//       CalculatorAdd(),
//       when: _actions.last is! CalculatorAdd,
//     );
//   }
//
//   void deduct() {
//     takeAction(
//       CalculatorDeduct(),
//       when: _actions.last is! CalculatorDeduct,
//     );
//   }
//
//   void multiply() {
//     takeAction(
//       CalculatorMultiply(),
//       when: _actions.last is! CalculatorMultiply,
//     );
//   }
//
//   void divide() {
//     takeAction(
//       CalculatorDivide(),
//       when: _actions.last is! CalculatorDivide,
//     );
//   }
//
//   void takeAction(
//     CalculatorVariable action, {
//     required bool when,
//   }) {
//     if (when) {
//       if (_actions.last is MathFunction) {
//         _actions.removeLast();
//       } else {
//         _value = parseCalculatorActions(_actions);
//       }
//       _actions.add(action);
//     }
//     notifyListeners();
//   }
//
//   void reset() {
//     _actions = [CalculatorNumber('0')];
//     _value = 0;
//     notifyListeners();
//   }
//
//   void showResult() {
//     _value = parseCalculatorActions(_actions);
//     notifyListeners();
//   }
//
//   void setValue(num number) {
//     if (_actions.last is! CalculatorNumber) _value = 0;
//
//     final stringifyedValue = _value.toString();
//     if (_value == 0) {
//       _value = number;
//     } else {
//       _value = int.parse(stringifyedValue + number.toString());
//     }
//
//     notifyListeners();
//
//     final lastAction = _actions.last;
//     if (lastAction is CalculatorNumber) _actions.removeLast();
//
//     _actions.add(CalculatorNumber(_value.toString()));
//   }
// }
//
// abstract class CalculatorVariable {
//   CalculatorVariable({required this.value});
//
//   final String value;
// }
//
// class CalculatorAdd extends CalculatorVariable with MathOperator {
//   final String value = '+';
// }
//
// class CalculatorMultiply extends CalculatorVariable with MathOperator {
//   String value = '*';
// }
//
// class CalculatorDivide extends CalculatorVariable with MathOperator {
//   String value = '/';
// }
//
// class CalculatorDeduct extends CalculatorVariable with MathOperator {
//   String value = '-';
//
//   CalculatorDeduct(this.value) : super(value: '-');
// }
//
// class CalculatorNumber extends CalculatorVariable {
//   @override
//   final String value;
//
//   CalculatorNumber(this.value) : super(value: '0');
// }
//
// num parseCalculatorActions(List<CalculatorVariable> actions) {
//   final List<String> mathVariables = [];
//
//   for (var action in actions) {
//     mathVariables.add(action.value);
//   }
//
//   final variablesLength = mathVariables.length;
//
//   if (variablesLength.isEven) mathVariables.removeLast();
//
//   final equation = mathVariables.join(' ');
//
//   final num result = Parser().parse(equation).evaluate(
//         EvaluationType.REAL,
//         ContextModel(),
//       );
//
//   debugPrint('$equation = $result');
//
//   final prettierResult = isInteger(result) ? result.round() : result;
//
//   return prettierResult;
// }
//
// bool isInteger(num value) {
//   return value is int || value == value.roundToDouble();
// }
