import 'dart:async';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:turkish/turkish.dart';
import '../main.dart';

Box<Sozluk> sozlukBox = Hive.box<Sozluk>('Sozluk');

abstract class ManaAraModel extends ChangeNotifier {
  String _searchm; //? mana arama değişkeni
  String _searchk; //? kafiye arama değişkeni
  int _selectmana = 10; //? mana seçme değişleni
  bool _deyim = false; //? şapkali hassasiyeti
  List<Kelime> kelimeler = sozlukBox.get('kelime').kelime; //? Tüm  liste
  Kelime _mana = sozlukBox.get('kelime').kelime.first; //  ? ilk mana
  void incrementCounter();
  void getMana();

  List<Kelime> get item;
  Kelime get mana;
  int get itm;
  bool get deyim;

  void changeSearchmana(int selectmana) {
    //? tıklanan kelimenin id si buraya geliyor => getMana()
    _selectmana = selectmana;
    //print(selectmana);

    notifyListeners();
  }

  void changeSearchString(String searchm, String searchk, bool deyim) {
    //? textfield den gelen metin burada değişkenlere atanıyor =>
    _searchm = searchm;
    _searchk = searchk;
    _deyim = deyim;
    notifyListeners();
  }
}

class ManaAraModelImplementation extends ManaAraModel {
  int _itm = 0;
  List<Kelime> _items = sozlukBox.get('kelime').kelime;

  ManaAraModelImplementation() {
    Future.delayed(Duration(seconds: 3)).then((_) => getIt.signalReady(this));
  }

  @override
  List<Kelime> get item => _items;

  @override
  int get itm => _itm;
  @override
  Kelime get mana => _mana;
  @override
  bool get deyim => _deyim;
  @override
  void incrementCounter() async {
    _items = deyim
        ? kelimeler
            .where((a) => ((removeDiacritics(a.mana.join(' ')))
                    .toLowerCaseTr()
                    .contains(removeDiacritics(_searchm).toLowerCaseTr()) &&
                (removeDiacritics(a.text))
                    .toLowerCaseTr()
                    .endsWith(removeDiacritics(_searchk).toLowerCaseTr())))
            .toList()
        : kelimeler
            .where((a) =>
                a.deyimid == 0 &&
                ((removeDiacritics(a.mana.join(' ')))
                        .toLowerCaseTr()
                        .contains(removeDiacritics(_searchm).toLowerCaseTr()) &&
                    (removeDiacritics(a.text))
                        .toLowerCaseTr()
                        .endsWith(removeDiacritics(_searchk).toLowerCaseTr())))
            .toList();
    if (_items.isNotEmpty) {
      _mana = kelimeler.where((w) => w.id == _items.first.id).toList().first;
    }

    notifyListeners();
  }

  @override
  void getMana() {
    //print('aranan');
    //print(_selectmana);
    _mana = kelimeler.where((w) => w.id == _selectmana).toList().first;

    notifyListeners();
  }
}
