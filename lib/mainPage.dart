import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';
import 'package:hive_sozluk_desktop/ui/desktop.dart';
import 'package:hive_sozluk_desktop/widget/kelime_ara/kelime_ara_list_widget.dart';
import 'package:hive_sozluk_desktop/widget/mana_ara/mana_ara_list_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    pcontroller.jumpToPage(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  PageController pcontroller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: WindowTitleBarBox(
                    child: MoveWindow(
                  child: Container(
                      alignment: Alignment.centerLeft, child: Text('sdf')),
                )),
              ),
              Expanded(
                child: WindowTitleBarBox(
                    child: Row(children: [
                  Expanded(child: MoveWindow()),
                  WindowButtons(),
                ])),
              ),
            ],
          ),
          Image.asset(
            'assets/images/cizgi.png',
          ),
          Expanded(
            child: PageView(
              onPageChanged: (val) => setState(() {
                _selectedIndex = val;
              }),
              controller: pcontroller,
              children: [KelimeAraList(), ManaAraList()],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 52,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Text(
                'Kelime',
                style: TextStyle(fontSize: 14),
              ),
              label: 'Kelime Ara',
            ),
            BottomNavigationBarItem(
              icon: Text(
                'Mâna',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              label: 'Mâna ve Kafiye Ara',
            ),
          ],
          backgroundColor: CustomColors.renk1,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
