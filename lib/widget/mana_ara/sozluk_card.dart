import 'package:flutter/material.dart';
import 'package:hive_sozluk_desktop/model/theme/colors.dart';

class KelimeCard extends StatelessWidget {
  final String id;
  final String team;
  final String osmanlica;
  final String text;
  final String deyimid;
  const KelimeCard(
      {Key key, this.osmanlica, this.text, this.deyimid, this.id, this.team})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: deyimid == '0' ? 0 : 20),
      child: Card(
        child: SizedBox(
          height: 25,
          width: 50,
          child: Padding(
            padding: const EdgeInsets.only(top: 3.5, left: 8.0),
            child: Tooltip(
              message: text,
              child: Text(text,
                  textAlign: TextAlign.start,
                  style: deyimid != '0'
                      ? TextStyle(color: CustomColors.gri)
                      : Theme.of(context).textTheme.headline1),
            ),
          ),
        ),
      ),
    );
  }
}
