import 'package:flutter/material.dart';

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

        primaryColor: CustomColors.renk5,
        scaffoldBackgroundColor: CustomColors.renk4,
        fontFamily: 'Scopoe', //3
        cardTheme: CardTheme(
          color: CustomColors.renk3,
          shadowColor: CustomColors.siyah,
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
        // ignore: deprecated_member_use
        textSelectionColor: CustomColors.siyah,
        elevatedButtonTheme: ElevatedButtonThemeData(
            // 4
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor))),
        textTheme: TextTheme(
          bodyText1: TextStyle(
              color: CustomColors.manaArafield,
              fontFamily: 'Minion',
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal),
          subtitle1: TextStyle(
              color: CustomColors.anakelimeler,
              letterSpacing: 1.1,
              wordSpacing: 0.1,
              fontFamily: 'Minion',
              fontSize: 20,
              fontWeight: FontWeight.w300),
          subtitle2: TextStyle(
              color: CustomColors.deyim,
              fontFamily: 'Minion',
              fontSize: 16,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
          headline1: TextStyle(
              color: CustomColors.renk1,
              letterSpacing: 1.1,
              wordSpacing: 0.1,
              fontFamily: 'Minion',
              fontSize: 20,
              fontWeight: FontWeight.w300),
          headline2: TextStyle(
              color: CustomColors.osmanlica,
              fontFamily: 'Rakkas',
              fontSize: 20,
              fontWeight: FontWeight.w100),
          headline3: TextStyle(
              color: CustomColors.renk1,
              fontFamily: 'Minion',
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w400),
          headline4: TextStyle(
              color: CustomColors.deyim,
              fontFamily: 'Minion',
              fontSize: 16,
              //fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
          headline5: TextStyle(
              color: CustomColors.kelimeAra,
              fontFamily: 'Minion',
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal),
          caption: TextStyle(
            color: CustomColors.deyim,
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
        // ignore: deprecated_member_use
        textSelectionColor: CustomColors.siyah,
        elevatedButtonTheme: ElevatedButtonThemeData(
            // 4
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith(getColor))),
        textTheme: TextTheme(
          headline1: TextStyle(
              color: CustomColors.renk1,
              letterSpacing: 1.1,
              wordSpacing: 0.1,
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
}
