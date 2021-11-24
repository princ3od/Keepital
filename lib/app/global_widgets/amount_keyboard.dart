import 'package:flutter/material.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:money_formatter/money_formatter.dart';

class EnterAmountScreen extends StatefulWidget {
  final String? currentAmount;
  EnterAmountScreen({this.currentAmount});
  @override
  _EnterAmountScreenState createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  var isEnd = false;
  var userInput = '';
  var answer = '';
  var userInputFormat = '';
  var answerFormat = '';
  final List<String> buttons = ['AC', '÷', '×', '⌫', '7', '8', '9', '-', '4', '5', '6', '+', '1', '2', '3', '=', '0', '000', '.', '✓'];

  @override
  void initState() {
    userInput = widget.currentAmount ?? '';
    if (userInput.isNotEmpty) {
      equalPressed();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          color: AppColors.textColor,
        ),
        title: Text(
          'Calculate your amount',
          style: AppTheme.currentTheme.textTheme.headline2!.copyWith(
            fontSize: 16,
            color: AppColors.textColor,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: AppTheme.currentTheme.backgroundColor,
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        reverse: true,
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  child: Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInput.length.toString() + '/12',
                        style: AppTheme.currentTheme.textTheme.headline3!.copyWith(
                          color: AppColors.textColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.centerRight,
                      child: Text(
                        userInputFormat,
                        style: AppTheme.currentTheme.textTheme.headline3!.copyWith(
                          fontSize: 25,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      alignment: Alignment.centerRight,
                      child: Text(
                        answerFormat,
                        style: AppTheme.currentTheme.textTheme.headline3!.copyWith(
                          fontSize: 35,
                          color: AppColors.textColor,
                        ),
                      ),
                    )
                  ]),
                ),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    padding: EdgeInsets.fromLTRB(28, 20, 20, 40),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: AppColors.calculatorBackgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  buildKeyOfCalculator(
                                    0,
                                    AppColors.calculatorForegroundColor,
                                    AppColors.calculatorCancelButtonColor,
                                  ),
                                  buildKeyOfCalculator(4, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(8, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(12, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(16, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                ],
                              ),
                              Column(
                                children: [
                                  buildKeyOfCalculator(1, AppColors.calculatorForegroundColor, AppColors.calculatorFunctionButtonColor),
                                  buildKeyOfCalculator(5, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(9, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(13, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(17, AppColors.calculatorForegroundColor, AppColors.calculatorFunctionButtonColor),
                                ],
                              ),
                              Column(
                                children: [
                                  buildKeyOfCalculator(2, AppColors.calculatorForegroundColor, AppColors.calculatorFunctionButtonColor),
                                  buildKeyOfCalculator(6, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(10, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(14, AppColors.calculatorForegroundColor, AppColors.calculatorNumberButtonBackgroundColor),
                                  buildKeyOfCalculator(18, AppColors.calculatorForegroundColor, AppColors.calculatorFunctionButtonColor),
                                ],
                              ),
                              Column(
                                children: [
                                  buildKeyOfCalculator(3, AppColors.calculatorForegroundColor, AppColors.calculatorFunctionButtonColor),
                                  buildKeyOfCalculator(7, AppColors.calculatorForegroundColor, AppColors.calculatorFunctionButtonColor),
                                  buildKeyOfCalculator(11, AppColors.calculatorForegroundColor, AppColors.calculatorFunctionButtonColor),
                                  buildKeyOfCalculator(isEnd ? 19 : 15, AppColors.calculatorForegroundColor, isEnd ? AppColors.calculatorCompleteButtonColor : AppColors.calculatorCalculateButtonColor, 2),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '÷' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    var sign = [
      '+',
      '-',
      '*',
      '/',
    ];
    sign.forEach((element) {
      if (userInput.endsWith(element)) userInput = userInput.substring(0, userInput.length - 1);
    });

    String finalUserInput = userInput;
    if (finalUserInput.isEmpty) return;

    Parser p = Parser();
    Expression exp = p.parse(finalUserInput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    answer = eval.toStringAsFixed(0);
    setState(() {
      answerFormat = MoneyFormatter(amount: double.parse(answer)).output.withoutFractionDigits;
      userInput = answer;
      userInputFormat = MoneyFormatter(amount: double.parse(userInput)).output.withoutFractionDigits;
    });
  }

  convertInput() {
    final intRegex = RegExp(r'[+|\-|*|/]');
    var listString = intRegex.allMatches(userInput).map((m) => m.group(0)).toList();
    var listNumber = userInput.split(intRegex);
    String finalString = '';
    for (var i = 0; i < listNumber.length; i++) {
      if (listNumber[i] != '') {
        var formatNumber = MoneyFormatter(amount: double.tryParse(listNumber[i])!).output.withoutFractionDigits;
        if (i != listNumber.length - 1) {
          finalString += formatNumber + listString[i]!;
        } else {
          finalString += formatNumber;
        }
        userInputFormat = finalString;
      }
    }
  }

  keyOnclick(int index) {
    setState(() {
      isEnd = false;
    });
    if (index == 0) {
      setState(() {
        userInput = '';
        answer = '0';
        userInputFormat = '';
        answerFormat = '0';
      });
    } else if (index == 3) {
      {
        if (userInput.isEmpty) return;
        setState(() {
          userInput = userInput.substring(0, userInput.length - 1);
          userInputFormat = userInput;
        });
        convertInput();
      }
    } else if (index == 15) {
      setState(() {
        isEnd = true;
        equalPressed();
      });
    } else if (index == 19) {
      if (answer != null && answer != '') Navigator.pop(context, answer);
    } else {
      setState(() {
        var sign = ['+', '-', '*', '/'];
        var input;
        if (buttons[index] == '×')
          input = '*';
        else if (buttons[index] == '÷')
          input = '/';
        else
          input = buttons[index];
        if (input == '.') return;

        if (sign.contains(input)) {
          for (var s in sign) {
            if (userInput.length == 0)
              return;
            else if (userInput.endsWith(s)) {
              if (s == input)
                return;
              else {
                userInput = userInput.substring(0, userInput.length - 1);
              }
            }
          }
        }

        if (userInput.length < 12) userInput += input;
        if (userInput.length > 12) userInput = userInput.substring(0, 12);
        final intRegex = RegExp(r'[+|\-|*|/]');
        var listString = intRegex.allMatches(userInput).map((m) => m.group(0)).toList();
        var listNumber = userInput.split(intRegex);
        String finalString = '';
        for (var i = 0; i < listNumber.length; i++) {
          if (listNumber[i] != '') {
            var formatNumber = MoneyFormatter(amount: double.tryParse(listNumber[i])!).output.withoutFractionDigits;
            if (i != listNumber.length - 1) {
              finalString += formatNumber + listString[i]!;
            } else {
              finalString += formatNumber;
            }
            userInputFormat = finalString;
          }
        }
      });
    }
  }

  Widget buildKeyOfCalculator(int index, Color txtcolor, Color backgroundColor, [int flex = 1]) {
    return Expanded(
      flex: flex,
      child: GestureDetector(
        onTap: () {
          keyOnclick(index);
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppTheme.currentTheme.primaryColor.withOpacity(0.5),
                spreadRadius: 1.5,
                blurRadius: 7,
                offset: Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          width: 70,
          margin: EdgeInsets.all(7),
          child: Text(
            buttons[index],
            style: AppTheme.currentTheme.textTheme.bodyText1!.copyWith(
              color: txtcolor,
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
