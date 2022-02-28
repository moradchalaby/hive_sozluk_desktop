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
  bool deyim = true;

  @override
  Widget build(BuildContext context) {
    Widget leftSimpleDrawer = SimpleDrawer(
      child: Container(
        padding: EdgeInsets.only(top: 25),
        color: CustomColors.renk4, //! menu renk
        height: MediaQuery.of(context).size.height,
        width: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElevatedButton(
                onPressed: () {
                  pcontroller.jumpToPage(0);
                  SimpleDrawer.deactivate("left");
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.siyah)),
                child: Container(
                  width: 110,
                  height: 50,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kelime',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      Icon(
                        Icons.search,
                        color: CustomColors.manaArafield,
                        semanticLabel: 'MANA',
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  pcontroller.jumpToPage(1);
                  SimpleDrawer.deactivate("left");
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.siyah)),
                child: Container(
                  height: 50,
                  width: 110,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Kafiye ',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Icon(
                        Icons.search,
                        color: CustomColors.kelimeAra,
                        semanticLabel: 'MANA',
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        ' Mânâ',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  ),
                )),
            /*  Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    pcontroller.jumpToPage(0);
                    SimpleDrawer.deactivate("left");
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(CustomColors.siyah)),
                  child: Text(
                    'Kelime',
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    pcontroller.jumpToPage(1);
                    SimpleDrawer.deactivate("left");
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(CustomColors.siyah)),
                  child: Row(
                    children: [
                      Text(
                        'Kafiye ve Mânâ',
                        maxLines: 1,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ],
                  )),
            ), */
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
                    Icon(
                      Icons.search,
                      color: CustomColors.kelimeAra,
                      semanticLabel: 'MANA',
                      textDirection: TextDirection.rtl,
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
                                  ? Theme.of(context).textTheme.caption
                                  : Theme.of(context).textTheme.headline1,
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
                    Icon(
                      Icons.search,
                      color: CustomColors.kelimeAra,
                      semanticLabel: 'MANA',
                      textDirection: TextDirection.rtl,
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
                    Icon(
                      Icons.search,
                      color: CustomColors.manaArafield,
                      semanticLabel: 'MANA',
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
                          focusNode: mkelimeFocus,
                          cursorRadius: Radius.circular(50),
                          controller: mcontroller,
                          decoration: new InputDecoration(
                              hintText: 'Mana Ara...',
                              hintStyle: Theme.of(context).textTheme.bodyText1,
                              border: InputBorder.none),
                          onChanged: (value) {
                            textim(mcontroller);
                            _debouncer.run(() {
                              getIt<ManaAraModel>().changeSearchString(
                                  value, kcontroller.text, false);
                              getIt<ManaAraModel>().incrementCounter();
                            });
                          },
                        ),
                      ),
                    ),
                    /*   Expanded(
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
                    ), */
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
