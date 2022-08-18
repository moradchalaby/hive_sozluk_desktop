import 'package:hive_sozluk_desktop/widget/class/diactritica/replacementa_map.dart';

String removeDiacriticsa(String text) =>
    String.fromCharCodes(replaceCodeUnitsa(text.codeUnits));
