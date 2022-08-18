bool _initialized = false;
Map<int, int> _singleUnit = {};
Map<int, List<int>> _multiUnit = {};

void _registera(String base, String accents) {
  if (base.codeUnits.length == 1) {
    final baseUnit = base.codeUnits.first;
    for (var unit in accents.codeUnits) {
      _singleUnit[unit] = baseUnit;
    }
  } else {
    for (var unit in accents.codeUnits) {
      _multiUnit[unit] = base.codeUnits;
    }
  }
}

List<int> replaceCodeUnitsa(List<int> codeUnits) {
  _initIfRequireda();
  final result = <int>[];
  for (var original in codeUnits) {
    // Combining Diacritical Marks in Unicode
    if (original >= 0x0300 && original <= 0x036F) {
      continue;
    }

    // single-unit replacements
    final single = _singleUnit[original];
    if (single != null) {
      result.add(single);
      continue;
    }

    // multi-unit replacements
    final multiple = _multiUnit[original];
    if (multiple != null) {
      result.addAll(multiple);
      continue;
    }

    // no replacement
    result.add(original);
  }
  return result;
}

/// Replaces list of code units to a simplified list.
/// The length of the result list may differ from the source.
List<int> replaceCodeUnitsb(List<int> codeUnits) {
  _initIfRequireda();
  final result = <int>[];
  for (var original in codeUnits) {
    // Combining Diacritical Marks in Unicode
    if (original >= 0x0300 && original <= 0x036F) {
      continue;
    }

    // single-unit replacements
    final single = _singleUnit[original];
    if (single != null) {
      result.add(single);
      continue;
    }

    // multi-unit replacements
    final multiple = _multiUnit[original];
    if (multiple != null) {
      result.addAll(multiple);
      continue;
    }

    // no replacement
    result.add(original);
  }
  return result;
}

void _initIfRequireda() {
  if (_initialized) return;
  _registera(' ', '\u00A0');

  _registera('a',
      '\u0061\u24D0\uFF41\u1E9A\u00E0\u00E1\u00E2\u1EA7\u1EA5\u1EAB\u1EA9\u00E3\u0101\u0103\u1EB1\u1EAF\u1EB5\u1EB3\u0227\u01E1\u00E4\u01DF\u1EA3\u00E5\u01FB\u01CE\u0201\u0203\u1EA1\u1EAD\u1EB7\u1E01\u0105\u2C65\u0250\u0251');

  _registera('i', '\uFF49\u00EE\u012F\u1E2D\u0268');
  //_registera('î', '\u00EE');
  _registera('u',
      '\u0075\u24E4\uFF55\u00F9\u00FA\u00FB\u0169\u1E79\u016B\u1E7B\u016D\u01DC\u01D8\u01D6\u01DA\u1EE7\u016F\u0171\u01D4\u0215\u0217\u01B0\u1EEB\u1EE9\u1EEF\u1EED\u1EF1\u1EE5\u1E73\u0173\u1E77\u1E75\u0289');
  _initialized = true;
}
