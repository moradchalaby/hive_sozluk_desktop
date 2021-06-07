/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_sozluk_desktop/widget/kelime_ara/kelime_ara_list_widget.dart';
import 'package:hive_sozluk_desktop/widget/mana_ara/mana_ara_list_widget.dart';

import 'package:multilevel_drawer/multilevel_drawer.dart';

Widget drawe(context) {
  return MultiLevelDrawer(
    backgroundColor: Colors.white,
    rippleColor: Colors.white,
    subMenuBackgroundColor: Colors.grey.shade100,
    divisionColor: Colors.grey,
    header: Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/dp_default.png",
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text("RetroPortal Studio")
        ],
      )),
    ),
    children: [
      MLMenuItem(
          leading: Icon(Icons.person),
          trailing: Icon(Icons.arrow_right),
          content: Text(
            "My Profile",
          ),
          subMenuItems: [
            MLSubmenu(
                onClick: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => KelimeAraList()));
                },
                submenuContent: Text("Option 1")),
            MLSubmenu(onClick: () {}, submenuContent: Text("Option 2")),
            MLSubmenu(onClick: () {}, submenuContent: Text("Option 3")),
          ],
          onClick: () {}),
      MLMenuItem(
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.arrow_right),
          content: Text("Settings"),
          onClick: () {},
          subMenuItems: [
            MLSubmenu(onClick: () {}, submenuContent: Text("Option 1")),
            MLSubmenu(onClick: () {}, submenuContent: Text("Option 2"))
          ]),
      MLMenuItem(
        leading: Icon(Icons.notifications),
        content: Text("Notifications"),
        onClick: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ManaAraList()));
        },
      ),
      MLMenuItem(
          leading: Icon(Icons.payment),
          trailing: Icon(Icons.arrow_right),
          content: Text(
            "Payments",
          ),
          subMenuItems: [
            MLSubmenu(onClick: () {}, submenuContent: Text("Option 1")),
            MLSubmenu(onClick: () {}, submenuContent: Text("Option 2")),
            MLSubmenu(onClick: () {}, submenuContent: Text("Option 3")),
            MLSubmenu(onClick: () {}, submenuContent: Text("Option 4")),
          ],
          onClick: () {}),
    ],
  );
}
 */