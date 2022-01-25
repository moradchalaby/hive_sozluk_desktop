import 'dart:io';
import 'dart:ui';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:desktop_window/desktop_window.dart';

import 'package:hive/hive.dart';
import 'package:hive_sozluk_desktop/mainPage.dart';
import 'package:hive_sozluk_desktop/provider/mana_ara_list.dart';
import 'package:hive_sozluk_desktop/widget/mana_ara/mana_ara_list_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'loading.dart';

import 'model/theme/theme_model.dart';
import 'provider/kelime_ara_list.dart';

part 'main.g.dart';

@HiveType(typeId: 2)
class Kelime {
  Kelime({
    this.id,
    this.deyimid,
    this.osmanlica,
    this.text,
    this.team,
    this.mana,
  });
  @HiveField(0)
  int id;
  @HiveField(1)
  int deyimid;
  @HiveField(2)
  String osmanlica;
  @HiveField(3)
  String text;
  @HiveField(4)
  int team;
  @HiveField(5)
  List mana;

  factory Kelime.fromMap(Map<String, dynamic> json) => Kelime(
        id: json["id"],
        deyimid: json["deyimid"],
        osmanlica: json["osmanlica"],
        text: json["text"],
        team: json["team"],
        mana: json['mana'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "deyimid": deyimid,
        "osmanlica": osmanlica,
        "text": text,
        "team": team,
        "mana": mana,
      };
}

@HiveType(typeId: 3)
class Mana {
  Mana({
    this.id,
    this.text,
  });
  @HiveField(0)
  String id;
  @HiveField(1)
  String text;

  factory Mana.fromMap(Map<String, dynamic> json) => Mana(
        id: json["id"],
        text: json["text"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "text": text,
      };
}

@HiveType(typeId: 1)
class Sozluk {
  Sozluk({this.kelime, this.mana});

  @HiveField(0)
  List<Kelime> kelime;

  @HiveField(1)
  List<Mana> mana;

  @override
  String toString() {
    return '${kelime.length}: ${mana.length}';
  }
}

GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive
    ..init(document.path)
    ..registerAdapter(SozlukAdapter())
    ..registerAdapter(ManaAdapter())
    ..registerAdapter(KelimeAdapter());

  await Hive.openBox<Sozluk>('Sozluk');

  //await Hive.box<Sozluk>('Sozluk').clear();

  runApp(MyApp());
  doWhenWindowReady(() {
    final win = appWindow;

    win.maximize();

    win.maxSize = Size(350, 3000);

    final initialSize = Size(350, win.size.height - 30);
    win.size = initialSize;
    win.alignment = Alignment.topRight;
    //win.alignment = Alignment.topRight;
    win.title = "LUGAT -Türkçe sözlük ve kafiye programı";

    win.show();
    print(win.size.height);
    return win.show();
  });
}

class MyApp extends StatelessWidget {
  static final String title = 'BÜYÜK TÜRKÇE SÖZLÜK';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        //'/MyHomePage': (BuildContext context) => new MyHomePage(),
        '/YukleniyorPage': (BuildContext context) => new YukleniyorPage(),
        '/ManaPage': (BuildContext context) => new ManaAraList(),
        '/MainPage': (BuildContext context) => new MainPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State {
  Box<Sozluk> kelimeBox;
  Box<Sozluk> manaBox;
  List<Kelime> sozluk;
  @override
  void initState() {
    kelimeBox = Hive.box<Sozluk>('Sozluk');
    Future.delayed(Duration.zero, () async {
      if (kelimeBox.isEmpty) {
        Navigator.of(context).pushReplacementNamed('/YukleniyorPage');
      } else {
        getIt.registerSingleton<KelimeModel>(KelimeModelImplementation(),
            signalsReady: true);

        getIt.registerSingleton<ManaAraModel>(ManaAraModelImplementation(),
            signalsReady: true);

        // Alternative
        // getIt.getAsync<AppModel>().addListener(update);

        Navigator.of(context).pushReplacementNamed('/MainPage');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIt.allReady(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Scaffold(
              body: new Center(child: Text('SPLASH')),
            );
          } else {
            return new Scaffold(
              body: new Center(child: Text('SPLASH')),
            );
          }
        });
  }
}
