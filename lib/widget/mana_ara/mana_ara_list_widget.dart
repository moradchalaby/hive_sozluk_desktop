import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_sozluk_desktop/provider/mana_ara_list.dart';
import 'package:hive_sozluk_desktop/widget/mana_ara/kelime.dart';
import 'package:hive_sozluk_desktop/widget/mana_ara/mana.dart';

import '../../main.dart';

class ManaAraList extends StatefulWidget {
  @override
  _ManaAraListState createState() => _ManaAraListState();
}

class _ManaAraListState extends State<ManaAraList> {
  String searchtext;
  TextEditingController tcontroller = new TextEditingController();

  @override
  void initState() {
    // Access the instance of the registered AppModel
    // As we don't know for sure if AppModel is already ready we use getAsync

    getIt
        .isReady<ManaAraModel>()
        .then((_) => getIt<ManaAraModel>().addListener(update));
    // Alternative
    // getIt.getAsync<AppModel>().addListener(update);

    super.initState();
  }

  @override
  void dispose() {
    getIt<ManaAraModel>().removeListener(update);
    super.dispose();
  }

  void update() => setState(() => {});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return FutureBuilder(
        future: getIt.allReady(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Row(
                //alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Expanded(flex: 4, child: ListManaAraKelime()),
                  Expanded(flex: 10, child: ListManaAraMana()),
                ],
              ),
            );
          } else {
            return new Scaffold(
              body: new Center(child: Text('Mana Ara')),
            );
          }
        });
  }
}
