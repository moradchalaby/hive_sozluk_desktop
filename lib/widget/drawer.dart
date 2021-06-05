import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_sozluk_desktop/ui/desktop.dart';
import 'package:hive_sozluk_desktop/widget/kelime_ara/kelime_ara_list_widget.dart';
import 'package:hive_sozluk_desktop/widget/mana_ara/mana_ara_list_widget.dart';

Widget drawe(context) {
  return SafeArea(
    child: Container(
      child: ListTileTheme(
        textColor: Colors.white,
        iconColor: Colors.white,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: 128.0,
                height: 128.0,
                margin: const EdgeInsets.only(
                  top: 24.0,
                  bottom: 64.0,
                ),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/flutter_logo.png',
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => KelimeAraList()),
                      ModalRoute.withName('/KelimePage'));
                },
                leading: Icon(Icons.search),
                title: Text('Kelime Ara'),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ManaAraList()),
                      ModalRoute.withName('/ManaPage'));

                  /* MaterialPageRoute(
                      builder: (BuildContext context) => ManaAraList()); */
                },
                leading: Icon(Icons.search),
                title: Text('Mana ve Kafiye Ara'),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.settings),
                title: Text('Ayarlar'),
              ),
              Spacer(),
              DefaultTextStyle(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white54,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Text('Terms of Service | Privacy Policy'),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
