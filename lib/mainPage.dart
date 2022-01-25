import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';
import 'package:hive_sozluk_desktop/widget/class/customclass.dart';

import 'package:hive_sozluk_desktop/widget/kelime_ara/kelime_ara_list_widget.dart';
import 'package:hive_sozluk_desktop/widget/mana_ara/mana_ara_list_widget.dart';
import 'package:simple_drawer/simple_drawer.dart';

import 'main.dart';
import 'model/debouncer.dart';
import 'provider/mana_ara_list.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pcontroller = PageController(initialPage: 0);
  FocusNode kelimeFocus = new FocusNode();
  FocusNode kkelimeFocus = new FocusNode();
  FocusNode mkelimeFocus = new FocusNode();
  TextEditingController mcontroller = new TextEditingController();
  TextEditingController kcontroller = new TextEditingController();
  TextEditingController tcontroller = new TextEditingController();
  final _debouncer = Debouncer(milliseconds: 200);
  bool sapkali = false;
  bool deyim = false;

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
                  onPressed: () {
                    pcontroller.jumpToPage(0);
                    SimpleDrawer.deactivate("left");
                  },
                  child: Text('Kelime Ara')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    pcontroller.jumpToPage(1);
                    SimpleDrawer.deactivate("left");
                  },
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
    print(pcontroller.toString());

    return Scaffold(
      body: Column(
        children: [
          !pcontroller.hasClients || pcontroller.offset == 0.0
              ? Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              if (SimpleDrawer.getDrawerStatus("left")
                                      .toString() ==
                                  'DrawerStatus.active') {
                                SimpleDrawer.deactivate("left");
                              } else {
                                SimpleDrawer.activate("left");
                              }
                            },
                            icon: Image.asset('assets/images/img3.png'),
                          )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Theme(
                        data: ThemeData(
                            textSelectionTheme: TextSelectionThemeData(
                                selectionColor: CustomColors.siyah,
                                selectionHandleColor: CustomColors.mavi,
                                cursorColor: CustomColors.renk2)),
                        child: TextField(
                          style: Theme.of(context).textTheme.headline3,
                          focusNode: kelimeFocus,
                          cursorRadius: Radius.circular(50),
                          controller: tcontroller,
                          decoration: new InputDecoration(
                              hintText: 'Kelime Ara...',
                              hintStyle: Theme.of(context).textTheme.headline5,
                              border: InputBorder.none),
                          onChanged: (value) {
                            textim(tcontroller);
                            _debouncer.run(() {
                              kelimeAra(tcontroller.text, sapkali, deyim);
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            sapkali = !sapkali;
                          });
                          kelimeAra(tcontroller.text, sapkali, deyim);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: CustomColors.renk5,
                          ),
                          child: Center(
                            child: Text(
                              "â",
                              textAlign: TextAlign.center,
                              style: sapkali
                                  ? Theme.of(context).textTheme.headline1
                                  : Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            deyim ? deyim = false : deyim = true;
                          });
                          kelimeAra(tcontroller.text, sapkali, deyim);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: CustomColors.renk5,
                          ),
                          child: !deyim
                              ? Icon(
                                  Icons.format_align_center,
                                  color: CustomColors.renk3,
                                  size: 16,
                                )
                              : Icon(
                                  Icons.format_align_justify,
                                  color: CustomColors.renk1,
                                  size: 16,
                                ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              if (SimpleDrawer.getDrawerStatus("left")
                                      .toString() ==
                                  'DrawerStatus.active') {
                                SimpleDrawer.deactivate("left");
                              } else {
                                SimpleDrawer.activate("left");
                              }
                            },
                            icon: Image.asset('assets/images/img3.png'),
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child: Theme(
                        data: ThemeData(
                            textSelectionTheme: TextSelectionThemeData(
                                selectionColor: CustomColors.siyah,
                                selectionHandleColor: CustomColors.mavi,
                                cursorColor: CustomColors.renk2)),
                        child: new TextField(
                          style: Theme.of(context).textTheme.headline3,
                          focusNode: kkelimeFocus,
                          cursorRadius: Radius.circular(50),
                          controller: kcontroller,
                          decoration: new InputDecoration(
                              hintText: 'Kafiye Ara...',
                              hintStyle: Theme.of(context).textTheme.headline5,
                              border: InputBorder.none),
                          onChanged: (value) {
                            textim(kcontroller);
                            _debouncer.run(() {
                              getIt<ManaAraModel>().changeSearchString(
                                  mcontroller.text, value, deyim);
                              getIt<ManaAraModel>().incrementCounter();
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: new TextField(
                        style: Theme.of(context).textTheme.headline3,
                        focusNode: mkelimeFocus,
                        cursorRadius: Radius.circular(50),
                        controller: mcontroller,
                        decoration: new InputDecoration(
                            hintText: 'Mana Ara...',
                            hintStyle: Theme.of(context).textTheme.headline5,
                            border: InputBorder.none),
                        onChanged: (value) {
                          textim(mcontroller);
                          _debouncer.run(() {
                            getIt<ManaAraModel>().changeSearchString(
                                value, kcontroller.text, deyim);
                            getIt<ManaAraModel>().incrementCounter();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            sapkali = !sapkali;
                          });
                          kelimeAra(tcontroller.text, sapkali, deyim);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: CustomColors.renk5,
                          ),
                          child: Center(
                            child: Text(
                              "â",
                              textAlign: TextAlign.center,
                              style: sapkali
                                  ? Theme.of(context).textTheme.headline1
                                  : Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            deyim ? deyim = false : deyim = true;
                          });
                          kelimeAra(tcontroller.text, sapkali, deyim);
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: CustomColors.renk5,
                          ),
                          child: !deyim
                              ? Icon(
                                  Icons.format_align_center,
                                  color: CustomColors.renk3,
                                  size: 16,
                                )
                              : Icon(
                                  Icons.format_align_justify,
                                  color: CustomColors.renk1,
                                  size: 16,
                                ),
                        ),
                      ),
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
