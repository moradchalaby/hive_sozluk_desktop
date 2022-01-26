//? listview e consumer eklenecek

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_sozluk_desktop/model/debouncer.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';
import 'package:hive_sozluk_desktop/provider/kelime_ara_list.dart';
import 'package:hive_sozluk_desktop/provider/mana_ara_list.dart';
import 'package:hive_sozluk_desktop/widget/kelime_ara/kelime_ara_list_widget.dart';
import 'package:styled_text/styled_text.dart';
import 'package:styled_text/tags/styled_text_tag.dart';
import 'package:styled_text/tags/styled_text_tag_action.dart';

import '../../main.dart';

class ListManaAraMana extends StatefulWidget {
  @override
  _ListManaAraManaState createState() => _ListManaAraManaState();
}

class _ListManaAraManaState extends State<ListManaAraMana> {
  int say = 0;
  final _debouncer = Debouncer(milliseconds: 10);
  Box<Sozluk> sozlukBox;
  var manaList = getIt<ManaAraModel>().mana.mana;
  Kelime kelime = getIt<ManaAraModel>().mana;
  int kelimesay = getIt<ManaAraModel>().item.length;
  @override
  void initState() {
    getIt
        .isReady<ManaAraModel>()
        .then((_) => getIt<ManaAraModel>().addListener(update));

    super.initState();
  }

  @override
  void dispose() {
    getIt<ManaAraModel>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {
        kelime = getIt<ManaAraModel>().mana,
        kelimesay = getIt<ManaAraModel>().item.length,
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
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(0)),
                    overlayColor:
                        MaterialStateProperty.all<Color>(CustomColors.renk5),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(CustomColors.renk5),
                  ),
                  onPressed: () {
                    print('ad');
                  },
                  child: Container(
                    width: 350,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 25),
                    decoration: BoxDecoration(
                        color: CustomColors.renk5,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Text(kelimesay.toString() + ' kelime bulundu.',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      color: CustomColors.renk5,
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
                            child: SingleChildScrollView(
                              controller: ScrollController(),
                              scrollDirection: Axis.vertical, //.horizontal
                              child: SelectableText(
                                kelime.text,
                                // minFontSize: 4,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                style: kelime.deyimid == 0
                                    ? Theme.of(context).textTheme.headline1
                                    : Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
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

                              return Container(
                                margin:
                                    EdgeInsets.only(left: 40.0, right: 20.0),
                                child: StyledText(
                                  textAlign: TextAlign.justify,
                                  text: ((firstChar
                                          ? '<_>' +
                                              (say).toString() +
                                              '. ' +
                                              '</_>'
                                          : '') +
                                      manaList[index]),
                                  style: Theme.of(context).textTheme.headline1,
                                  tags: {
                                    '_': StyledTextTag(
                                        style: TextStyle(
                                            color: CustomColors.mavi)),
                                    '*': StyledTextTag(
                                        style: TextStyle(
                                            color: CustomColors.sari)),
                                    '#': StyledTextTag(
                                        style: TextStyle(
                                            height: 2,
                                            fontStyle: FontStyle.italic,
                                            color: CustomColors.renk3)),
                                    '%': StyledTextTag(
                                        style:
                                            TextStyle(color: CustomColors.gri)),
                                    '^': StyledTextTag(
                                        style: TextStyle(
                                            height: 2,
                                            color: CustomColors.kirmizi)),
                                  },
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
          mini: true,
          tooltip: 'müstensih',
          backgroundColor: CustomColors.renk5,
          elevation: 7.0,
          onPressed: () {
            Clipboard.setData(ClipboardData(text: kelime.text + ':\n' + copy))
                .then(
              (value) {
                //only if ->
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("\"" +
                      kelime.text +
                      '\" Kelismesinin mânâsı istinsah edildi.'),
                  dismissDirection: DismissDirection.horizontal,
                  backgroundColor: CustomColors.renk5,
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
