//? listview e consumer eklenecek

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_sozluk_desktop/model/debouncer.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';
import 'package:hive_sozluk_desktop/provider/kelime_ara_list.dart';
import 'package:screenshot/screenshot.dart';
import 'package:styled_text/styled_text.dart';

import '../../main.dart';

class ListMana extends StatefulWidget {
  @override
  _ListManaState createState() => _ListManaState();
}

class _ListManaState extends State<ListMana> {
  int say = 0;
  final _debouncer = Debouncer(milliseconds: 10);
  Box<Sozluk> sozlukBox;
  var manaList = getIt<KelimeModel>().mana.mana;
  Kelime kelime = getIt<KelimeModel>().mana;
  ScrollController controller = ScrollController();
  final _screencont = ScreenshotController();
  File _imageFile;
  @override
  void initState() {
    getIt
        .isReady<KelimeModel>()
        .then((_) => getIt<KelimeModel>().addListener(update));

    super.initState();
  }

  @override
  void dispose() {
    getIt<KelimeModel>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {
        kelime = getIt<KelimeModel>().mana,
        manaList = kelime.mana,
      });

  @override
  Widget build(BuildContext context) {
    say = 0;
    var copyci = manaList.toString();
    var copy = copyci
        .substring(1, copyci.length - 1)
        .replaceAll('<^>', '\n')
        .replaceAll('</^>', '')
        .replaceAll('<#>', '\n')
        .replaceAll('</#>', '')
        .replaceAll('<link>', '\n')
        .replaceAll('</link>', '')
        .replaceAll('<*>', '\n')
        .replaceAll('</*>', '')
        .replaceAll('<%>', '\n')
        .replaceAll('</%>', '')
        .replaceAll('. , ', '.\n');
    return Scaffold(
      body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            //!decoration: BoxDecoration(color: CustomColors.manaArkaplan),
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            height: MediaQuery.of(context).size.height,
            child: Screenshot(
              controller: _screencont,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    height: 40,
                    decoration: BoxDecoration(
                        color: CustomColors.renk5, //! kelime arkaplan
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.zero,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                scrollDirection: Axis.vertical, //.horizontal
                                child: SelectableText(
                                  kelime.text,
                                  // minFontSize: 4,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: kelime.deyimid == 0
                                      ? Theme.of(context).textTheme.subtitle1
                                      : Theme.of(context).textTheme.subtitle2,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              padding: EdgeInsets.zero,
                              child: SingleChildScrollView(
                                controller: ScrollController(),
                                scrollDirection: Axis.vertical, //.horizontal
                                child: SelectableText(
                                  kelime.osmanlica,

                                  //minFontSize: 4,
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.headline2,
                                  textDirection: TextDirection.rtl,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: ListView.builder(
                            controller: controller,
                            itemCount: manaList.length,
                            itemBuilder: (context, index) {
                              if (manaList.isEmpty) {
                                return CircularProgressIndicator();
                              } else {
                                bool firstChar = true;

                                String aranan;
                                if (manaList[index].contains('^') ||
                                    manaList[index].contains('*') ||
                                    manaList[index].contains('%') ||
                                    manaList[index].contains('#')) {
                                  firstChar = false;
                                } else {
                                  say++;

                                  firstChar = true;
                                }
                                if (manaList[index].contains('(bk.') &&
                                    !manaList[index].contains('<link>')) {
                                  const start = "(bk. ";
                                  const end = ")";

                                  final startIndex =
                                      manaList[index].indexOf(start);
                                  final endIndex = manaList[index]
                                      .indexOf(end, startIndex + start.length);
                                  aranan = manaList[index].substring(
                                      startIndex + start.length, endIndex);

                                  manaList[index] =
                                      '<link>' + manaList[index] + '</link>';
                                } else if (manaList[index].contains('(bk.') &&
                                    manaList[index].contains('<link>')) {
                                  const start = "(bk. ";
                                  const end = ")";

                                  final startIndex =
                                      manaList[index].indexOf(start);
                                  final endIndex = manaList[index]
                                      .indexOf(end, startIndex + start.length);
                                  aranan = manaList[index].substring(
                                      startIndex + start.length, endIndex);
                                } else if (!manaList[index].contains('(bk.')) {
                                  if (manaList[index].contains('bk.') &&
                                      !manaList[index].contains('<link>')) {
                                    aranan = manaList[index]
                                        .substring(
                                            3, (manaList[index].length - 1))
                                        .trimLeft();
                                    manaList[index] =
                                        '<link>' + manaList[index] + '</link>';
                                  } else if (manaList[index].contains('bk.') &&
                                      manaList[index].contains('<link>')) {
                                    aranan = manaList[index]
                                        .substring(
                                            9, (manaList[index].length - 8))
                                        .trimLeft();
                                  }
                                }

                                return Container(
                                  margin:
                                      EdgeInsets.only(left: 4.0, right: 4.0),
                                  child: StyledText.selectable(
                                    textAlign: TextAlign.start,
                                    enableInteractiveSelection: true,
                                    toolbarOptions: ToolbarOptions(
                                        selectAll: true, copy: true),
                                    newLineAsBreaks: true,
                                    strutStyle: StrutStyle(),
                                    text: ((firstChar
                                            ? '<_>' +
                                                (say).toString() +
                                                '. ' +
                                                '</_>'
                                            : '') +
                                        manaList[index]),
                                    style:
                                        Theme.of(context).textTheme.headline1,
                                    tags: {
                                      '_': StyledTextTag(
                                          style: TextStyle(
                                              color: CustomColors
                                                  .rakam)), //?sayılar
                                      '*': StyledTextTag(
                                          style: TextStyle(
                                              color:
                                                  CustomColors.aruz)), //?Aruz
                                      '#': StyledTextTag(
                                          style: TextStyle(
                                              height: 1,
                                              fontStyle: FontStyle.italic,
                                              color:
                                                  CustomColors.ornek)), //?örnek
                                      '%': StyledTextTag(
                                          style: TextStyle(
                                              color: CustomColors
                                                  .aciklama)), //?değişim açıklama
                                      '^': StyledTextTag(
                                          style: TextStyle(
                                              height: 2,
                                              color:
                                                  CustomColors.tur)), //?özellik
                                      'link': StyledTextActionTag(
                                        (text, attrs) => _debouncer.run(() {
                                          print(aranan);
                                          getIt<KelimeModel>()
                                              .changeSearchString(
                                                  aranan, false, false);
                                          getIt<KelimeModel>()
                                              .incrementCounter();
                                        }),
                                        style: TextStyle(
                                            decorationThickness: 0.5,
                                            decorationColor:
                                                CustomColors.renk3, //!mana renk
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          )),
      floatingActionButton: FloatingActionButton(
          mini: true,
          tooltip: 'müstensih',
          backgroundColor: CustomColors.renk5, //!Kopyalaarkaplan
          elevation: 7.0,
          onPressed: () {
            Clipboard.setData(ClipboardData(text: kelime.text + ':\n' + copy))
                .then(
              (value) {
                //only if ->
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("\"" +
                      kelime.text +
                      '\" Kelimesinin mânâsı istinsah edildi.'),
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor:
                      CustomColors.renk5, //!kopyalama bildirim arkaplan
                  duration: Duration(milliseconds: 1500),
                )); // -> show a notification
              },
            );
          },
          child: Icon(
            Icons.copy_all,
          )),
    );
  }
}
