import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'main.dart';
import 'model/debouncer.dart';
import 'onboarding.dart';

class YukleniyorPage extends StatefulWidget {
  @override
  _YukleniyorPageState createState() => _YukleniyorPageState();
}

class _YukleniyorPageState extends State<YukleniyorPage> {
  String message = 'YÜKLENİYOR...';

  double percent = 0.0;
  int progM = 0;
  Box<Sozluk> sozlukBox;
  bool hazir = false;
  List<Kelime> kelimeList = List<Kelime>();
  var manaList;
  bool start = false;
  final _debouncer = DebouncerMain(seconds: 5);

  final String kelimePath = 'assets/szlkint.json';
  final String manaPath = 'assets/manalar_data.json';
  Future<void> kelimeJson() async {
    var kelimeData = await rootBundle.loadString('assets/szlkint.json');

    List<dynamic> decodedJson = json.decode(kelimeData);

    kelimeList = decodedJson.map((kelime) => Kelime.fromMap(kelime)).toList();
    var kelimem = Sozluk(kelime: kelimeList);
    await sozlukBox.put('kelime', kelimem);
    return kelimeList;
  }

  Future<void> manaJson() async {
    var manaData = await rootBundle.loadString('assets/manalar_data.json');

    List<dynamic> decodedJson = json.decode(manaData);
    manaList = decodedJson.map((mana) => Mana.fromMap(mana)).toList();
    var manam = Sozluk(mana: manaList);
    await sozlukBox.put('mana', manam);

    return manaList;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    super.initState();
    sozlukBox = Hive.box<Sozluk>('Sozluk');
    manaListele();
  }

  manaListele() async {
    setState(() {
      percent = 0.2;
    });

    await manaJson();
    setState(() {
      percent = 0.7;
    });
    await kelimeJson();
    setState(() {
      percent = 1;
      hazir = true;
      message = "TAMAMLANDI";
    });
    /* _debouncer.run(() {
      Navigator.of(context).pushReplacementNamed('/MyHomePage');
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LUGAT'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: new LinearPercentIndicator(
              linearGradient: LinearGradient(
                colors: [CustomColors.renk3, CustomColors.renk5],
              ),
              animateFromLastPercent: true,
              animation: true,
              width: MediaQuery.of(context).size.width - 20,
              lineHeight: 20.0,
              percent: percent,
              backgroundColor: CustomColors.renk5.withOpacity(0.3),
              //progressColor: CustomColors.siyah,
            ),
          ),
          Expanded(flex: 19, child: OnBoardingPage(hazir, message)),
        ],
      ),
    );
  }
}
//?   #031023   =>  Daha Kooyu
//?   #14325C   =>  Lacivert
//?   #5398D9   =>  Mavi
//?   #F4E3B1   =>  krem
//?   #D96B0C   =>  turuncu
//?   #A53A3B   =>  kırmızı
//?   #cddcbe   =>  yEŞİL

//?   #040C0E   =>  SİYAHIMSI
//?   #132226   =>  GRİİMSİ
//?   #525B56   =>  HAKİ
//?   #BE9063   =>  KAHVE
//?   #A4978E   =>  AÇIK GRİ
