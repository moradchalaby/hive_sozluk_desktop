import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';

var sidebarColor = Color(0xFF007e89);

class LeftSide extends StatelessWidget {
  const LeftSide({Key key, Widget child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    return SizedBox(
        width: 700,
        child: Container(
          color: sidebarColor,
          child: Column(
            children: [
              WindowTitleBarBox(child: MoveWindow()),
              Expanded(child: child)
            ],
          ),
        ));
  }
}

var backgroundStartColor = Color(0xFF019aa7);
var backgtoundEndColor = Color(0xFF007e89);

class RightSide extends StatelessWidget {
  const RightSide({Key key, Widget child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [backgroundStartColor, backgtoundEndColor],
            stops: [0.0, 1.0]),
      ),
      child: Column(
        children: [
          WindowTitleBarBox(
              child: Row(children: [
            Expanded(child: MoveWindow()),
            WindowButtons(),
          ])),
          Expanded(
            child: child,
          ),
        ],
      ),
    ));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: CustomColors.renk3,
    mouseOver: Color(0xFF007e89),
    mouseDown: Color(0xFF02535a),
    iconMouseOver: Color(0xFF02535a),
    iconMouseDown: Color(0xFF019aa7));

final closeButtonColors = WindowButtonColors(
    mouseOver: Color(0xFFd20000),
    mouseDown: Color(0xFFab2727),
    iconNormal: CustomColors.renk3,
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}
