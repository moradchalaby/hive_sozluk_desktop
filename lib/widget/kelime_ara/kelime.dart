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

  var kelimeList = getIt<KelimeModel>().item;
  int kelime = getIt<KelimeModel>().itm;
  final _debouncer = Debouncer(milliseconds: 200);

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
          }
      });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.renk4,
        /*  borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50), topRight: Radius.circular(50)), */
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/cizgi.png',
          ),
          Padding(
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
          ),
          Image.asset(
            'assets/images/cizgi.png',
          ),
          Expanded(
            child: IndexedListView.separated(
                physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                minItemCount: 0,
                separatorBuilder: (context, index) {
                  return Image.asset(
                    'assets/images/cizgi.png',
                  );
                },
                controller: controller,
                maxItemCount: kelimeList.length,
                itemBuilder: (context, index) {
                  if (kelimeList != null) {
                    return ListTile(
                      onTap: () {
                        getMana(context, kelimeList, index);
                      },
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
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
          Row(
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
          )
        ],
      ),
    );
  }
}
