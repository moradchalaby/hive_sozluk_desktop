import 'package:flutter/cupertino.dart';
import 'package:hive_sozluk_desktop/main.dart';
import 'package:hive_sozluk_desktop/model/debouncer.dart';
import 'package:hive_sozluk_desktop/provider/kelime_ara_list.dart';

sapkalifonk(TextEditingController controller, String harf) {
  controller.text = controller.text + harf;
  controller.selection =
      TextSelection.fromPosition(TextPosition(offset: controller.text.length));
}

kelimeAra(String aranan, bool sapkali, bool deyim) {
  getIt<KelimeModel>().changeSearchString(aranan, sapkali, deyim);
  getIt<KelimeModel>().incrementCounter();
}

getMana(context, data, index) {
  getIt<KelimeModel>().changeSearchmana(data[index].id);
  getIt<KelimeModel>().getMMana();
}

void textim(value) {
  value.text = value.text.toLowerCase();

  value.text = value.text.replaceAll('^^a', 'â');
  value.text = value.text.replaceAll('^^A', 'â');
  value.text = value.text.replaceAll('^^u', 'û');
  value.text = value.text.replaceAll('^^U', 'û');
  value.text = value.text.replaceAll('^^İ', 'î');
  value.text = value.text.replaceAll('^^i', 'î');

  value.selection =
      TextSelection.fromPosition(TextPosition(offset: value.text.length));
}
