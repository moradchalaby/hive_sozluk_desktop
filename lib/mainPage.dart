import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';
import 'package:hive_sozluk_desktop/ui/desktop.dart';

import 'package:hive_sozluk_desktop/widget/kelime_ara/kelime_ara_list_widget.dart';
import 'package:hive_sozluk_desktop/widget/mana_ara/mana_ara_list_widget.dart';
import 'package:simple_drawer/simple_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pcontroller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    Widget leftSimpleDrawer = SimpleDrawer(
      child: Container(
        padding: EdgeInsets.only(top: 25),
        color: CustomColors.renk4,
        height: MediaQuery.of(context).size.height,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => pcontroller.jumpToPage(0),
                  child: Text('Kelime Ara')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => pcontroller.jumpToPage(1),
                  child: AutoSizeText(
                    'Mana ve Kafiye Ara',
                    maxLines: 1,
                    style: TextStyle(fontSize: 14),
                  )),
            ),
          ],
        ),
      ),
      childWidth: 150,
      direction: Direction.left,
      id: "left",
      animationDurationInMilliseconds: 300,
      onDrawerStatusChanged: (drawerStatus) {
        Random rng = Random();
        print("DrawerStatus changed to: " + DrawerStatus.slidingIn.toString());
      },
    );
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: WindowTitleBarBox(
                    child: MoveWindow(
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          if (SimpleDrawer.getDrawerStatus("left").toString() ==
                              'DrawerStatus.active') {
                            SimpleDrawer.deactivate("left");
                          } else {
                            SimpleDrawer.activate("left");
                          }
                        },
                        icon: Image.asset('assets/images/img3.png'),
                      )),
                )),
              ),
              Expanded(
                child: WindowTitleBarBox(
                    child: Row(children: [
                  Expanded(child: MoveWindow()),
                  WindowButtons(),
                ])),
              ),
            ],
          ),
          Image.asset(
            'assets/images/cizgi.png',
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: PageView(
                    onPageChanged: (val) => setState(() {}),
                    controller: pcontroller,
                    children: [
                      KelimeAraList(),
                      ManaAraList(),
                    ],
                  ),
                ),
                leftSimpleDrawer,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
