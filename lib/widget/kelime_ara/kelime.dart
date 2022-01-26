import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_sozluk_desktop/model/debouncer.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';
import 'package:hive_sozluk_desktop/provider/kelime_ara_list.dart';
import 'package:hive_sozluk_desktop/widget/class/customclass.dart';
import 'package:indexed_list_view/indexed_list_view.dart';

import '../../main.dart';

class ListKelime extends StatefulWidget {
  @override
  _ListKelimeState createState() => _ListKelimeState();
}

class _ListKelimeState extends State<ListKelime> {
  var controller = IndexedScrollController();
  FocusNode kelimeFocus = new FocusNode();

  bool sapkali = false;
  bool deyim = false;
  String searchtext;
  TextEditingController tcontroller = new TextEditingController();
  int kelimesec = getIt<KelimeModel>().itm;
  var kelimeList = getIt<KelimeModel>().item;
  int kelime = getIt<KelimeModel>().itm;
  final _debouncer = Debouncer(milliseconds: 200);
  String kelimesay = getIt<KelimeModel>().kelimeler.length.toString();
  @override
  void initState() {
    getIt
        .isReady<KelimeModel>()
        .then((_) => getIt<KelimeModel>().addListener(update));
    getIt.isReady<KelimeModel>().then((_) => getIt<KelimeModel>().itm);
    super.initState();
  }

  @override
  void dispose() {
    getIt<KelimeModel>().removeListener(update);

    super.dispose();
  }

  void update() => setState(() => {
        kelimeList = getIt<KelimeModel>().item,
        if (kelime != getIt<KelimeModel>().itm)
          {
            kelime = getIt<KelimeModel>().itm,
            controller.jumpToIndex(kelime),
          },
        kelimesay = getIt<KelimeModel>().kelimeler.length.toString(),
      });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: CustomColors.renk4,

        /*  borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)), */
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /*  Padding(
            padding: const EdgeInsets.only(left: 3, right: 3),
            child: new TextField(
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
          ), */

          Expanded(
            flex: 1,
            child: IndexedListView.separated(
                physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                minItemCount: 0,
                separatorBuilder: (context, index) {
                  return new Container(
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 0.05,
                    color: Colors.white,
                  );
                },
                controller: controller,
                maxItemCount: kelimeList.length,
                itemBuilder: (context, index) {
                  if (kelimeList != null) {
                    return TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                          overlayColor:
                              MaterialStateProperty.all<Color>(Colors.red[400]),
                          backgroundColor: kelimesec == index
                              ? MaterialStateProperty.all<Color>(
                                  Colors.red[900])
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
                            ? Theme.of(context).textTheme.headline1
                            : Theme.of(context).textTheme.headline4,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
          /*  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
          ) */
        ],
      ),
    );
  }
}
