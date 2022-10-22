import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hive_sozluk_desktop/widget/kelime_ara/kelime.dart';
import 'package:hive_sozluk_desktop/widget/kelime_ara/mana.dart';

import '../../main.dart';

class KelimeAraList extends StatefulWidget {
  @override
  _KelimeAraListState createState() => _KelimeAraListState();
}

class _KelimeAraListState extends State<KelimeAraList> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return FutureBuilder(
        future: getIt.allReady(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Row(
                children: [
                  Expanded(flex: 4, child: ListKelime()),
                  Expanded(flex: 10, child: ListMana()),
                ],
              ),
            );
          } else {
            return new Scaffold(
              body: new Center(
                  child: Text(
                'Kelimeler listeleniyor...',
                style: Theme.of(context).textTheme.headline1,
              )),
            );
          }
        });
  }
}
