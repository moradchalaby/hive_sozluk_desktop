import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_sozluk_desktop/model/debouncer.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';
import 'package:hive_sozluk_desktop/provider/kelime_ara_list.dart';
import 'package:hive_sozluk_desktop/provider/mana_ara_list.dart';
import 'package:hive_sozluk_desktop/widget/class/customclass.dart';

import '../../main.dart';

class ListManaAraKelime extends StatefulWidget {
  @override
  _ListManaAraKelimeState createState() => _ListManaAraKelimeState();
}

class _ListManaAraKelimeState extends State<ListManaAraKelime> {
  ScrollAction contac = ScrollAction();
  ScrollController controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);
  ScrollController controller2 =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false);

  bool sapkali = false;
  bool deyim = false;
  TextEditingController mcontroller = new TextEditingController();
  TextEditingController kcontroller = new TextEditingController();
  FocusNode kelimeFocus;
  /* var controller =
      IndexedScrollController(initialIndex: 0, initialScrollOffset: 0.0); */
  var kelimeList = getIt<ManaAraModel>().item;
  int kelimesec = 0;
  final _debouncer = Debouncer(milliseconds: 300);
  getMana(context, data, index) {
    getIt<ManaAraModel>().changeSearchmana(data[index].id);
    getIt<ManaAraModel>().getMana();
  }

  final FocusNode _focusNode = FocusNode();
  void _handleKeyEvent(RawKeyEvent event) {
    var offset = controller.offset;
    print(offset);
    if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
      setState(() {
        if (kReleaseMode) {
          controller.animateTo(offset - 27,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        } else {
          controller.animateTo(offset - 27,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
      setState(() {
        if (kReleaseMode) {
          controller.animateTo(offset + 27,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
          kelimesec + 1;
        } else {
          controller.animateTo(offset + 27,
              duration: Duration(milliseconds: 30), curve: Curves.ease);
          kelimesec + 1;
        }
      });
    } else if (event.logicalKey == LogicalKeyboardKey.pageUp) {
      if (kReleaseMode) {
        controller.animateTo(offset - 340,
            duration: Duration(milliseconds: 30), curve: Curves.ease);
        kelimesec - 18;
      } else {
        controller.animateTo(offset - 340,
            duration: Duration(milliseconds: 30), curve: Curves.ease);
        kelimesec - 18;
      }
    } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
      if (kReleaseMode) {
        controller.animateTo(offset + 340,
            duration: Duration(milliseconds: 30), curve: Curves.ease);
      } else {
        controller.animateTo(offset + 340,
            duration: Duration(milliseconds: 30), curve: Curves.ease);
      }
    }
    ;
  }

  @override
  void initState() {
    getIt
        .isReady<ManaAraModel>()
        .then((_) => getIt<ManaAraModel>().addListener(update));

    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();

    getIt<ManaAraModel>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {
        deyim = getIt<ManaAraModel>().deyim,
        kelimeList = getIt<ManaAraModel>().item,
        kelimesec = 0,
        controller =
            ScrollController(initialScrollOffset: 0.0, keepScrollOffset: false),
      });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return RawKeyboardListener(
      onKey: _handleKeyEvent,
      autofocus: true,
      focusNode: _focusNode,
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.renk4,
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            /*   Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: new TextField(
              style: Theme.of(context).textTheme.headline3,
              focusNode: kelimeFocus,
              cursorRadius: Radius.circular(50),
              controller: mcontroller,
              decoration: new InputDecoration(
                  hintText: 'Mana Ara...',
                  hintStyle: Theme.of(context).textTheme.headline5,
                  border: InputBorder.none),
              onChanged: (value) {
                textim(mcontroller);
                _debouncer.run(() {
                  getIt<ManaAraModel>()
                      .changeSearchString(value, kcontroller.text, deyim);
                  getIt<ManaAraModel>().incrementCounter();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: new TextField(
              style: Theme.of(context).textTheme.headline3,
              focusNode: kelimeFocus,
              cursorRadius: Radius.circular(50),
              controller: kcontroller,
              decoration: new InputDecoration(
                  hintText: 'Kafiye Ara...',
                  hintStyle: Theme.of(context).textTheme.headline5,
                  border: InputBorder.none),
              onChanged: (value) {
                textim(kcontroller);
                _debouncer.run(() {
                  getIt<ManaAraModel>()
                      .changeSearchString(mcontroller.text, value, deyim);
                  getIt<ManaAraModel>().incrementCounter();
                });
              },
            ),
          ),
          Image.asset(
            'assets/images/cizgi.png',
          ), */
            Expanded(
              child: RawScrollbar(
                thumbColor: CustomColors.gri,
                radius: Radius.circular(20),
                controller: controller,
                scrollbarOrientation: ScrollbarOrientation.right,
                thickness: kelimeList.length < 5000 ? 10 : 0,
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    scrollbars: false,
                  ),
                  child: ListView.separated(
                      // emptyItemBuilder: (context, index) => Text('geleyor'),
                      physics: ScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: kelimeList.length,
                      separatorBuilder: (context, index) {
                        return new Container(
                          padding: EdgeInsets.zero,
                          margin: EdgeInsets.zero,
                          height: 0.05,
                          color: Colors.white,
                        );
                      },
                      controller: controller,
                      //itemCount: kelimeList.length,

                      itemBuilder: (context, index) {
                        if (kelimeList.length == 0) {
                          return Center(
                              child: CircularProgressIndicator(
                            backgroundColor: CustomColors.renk5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                CustomColors.renk4),
                          ));
                        } else {
                          return new TextButton(
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.all(0)),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    CustomColors.hover.withOpacity(0.5)),
                                backgroundColor: kelimesec == index
                                    ? MaterialStateProperty.all<Color>(
                                        CustomColors.hover.withOpacity(0.4))
                                    : MaterialStateProperty.all<Color>(
                                        CustomColors.renk5)),
                            onPressed: () {
                              getMana(context, kelimeList, index);
                              setState(() {
                                kelimesec = index;
                              });
                            },
                            child: AutoSizeText(
                              kelimeList[index].text,
                              textAlign: TextAlign.justify,
                              maxLines: 1,
                              style: kelimeList[index].deyimid == 0
                                  ? Theme.of(context).textTheme.subtitle1
                                  : Theme.of(context).textTheme.subtitle2,
                            ),
                          );
                          /*ListTile(
                            onTap: () {},
                            title: Container(
                              width: 50,
                              child: AutoSizeText(
                                kelimeList[index].text,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: kelimeList[index].deyimid == 0
                                    ? Theme.of(context).textTheme.headline1
                                    : Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          );  */
                        }
                      }),
                ),
              ),
            ),

            /* InkWell(
            onTap: () {
              setState(() {
                deyim = !deyim;
              });
              _debouncer.run(() {
                getIt<ManaAraModel>().changeSearchString(
                    mcontroller.text, kcontroller.text, deyim);
                getIt<ManaAraModel>().incrementCounter();
              });
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
          ), */
          ],
        ),
      ),
    );
  }
}
