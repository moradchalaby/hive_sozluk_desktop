import 'package:flutter/material.dart';

import '../debouncer.dart';
import 'colors.dart';

class CustomTheme {
  static Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return CustomColors.renk3;
    }
    return CustomColors.renk4;
  }

  static ThemeData get lightTheme {
    //1
    return ThemeData(
        //2

        primaryColor: CustomColors.renk4,
        scaffoldBackgroundColor: CustomColors.renk5,
        fontFamily: 'Scopoe', //3
        cardTheme: CardTheme(
          color: CustomColors.renk3,
          shadowColor: CustomColors.siyah,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            // 4
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor))),
        textTheme: TextTheme(
          headline1: TextStyle(
              color: CustomColors.renk1,
              wordSpacing: 0.0,
              fontFamily: 'Minion',
              fontSize: 20,
              fontWeight: FontWeight.w300),
          headline2: TextStyle(
              color: CustomColors.renk1,
              fontFamily: 'Rakkas',
              fontSize: 20,
              fontWeight: FontWeight.w100),
          headline3: TextStyle(
              color: CustomColors.renk1,
              fontFamily: 'Minion',
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400),
          headline5: TextStyle(
              color: CustomColors.renk1.withOpacity(0.5),
              fontFamily: 'Minion',
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal),
          headline4: TextStyle(
              color: CustomColors.renk2,
              fontFamily: 'Minion',
              fontSize: 16,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
          caption: TextStyle(
            color: CustomColors.renk2,
            fontFamily: 'Minion',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        buttonTheme: ButtonThemeData(
          // 4
          disabledColor: CustomColors.gri,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.renk5,
        ));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        primaryColor: CustomColors.renk5,
        scaffoldBackgroundColor: CustomColors.siyah,
        fontFamily: 'Scopoe', //3
        cardTheme: CardTheme(
          color: CustomColors.renk5,
          shadowColor: CustomColors.siyah,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        ),
        buttonTheme: ButtonThemeData(
          // 4

          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: CustomColors.renk4,
        ));
  }
}
