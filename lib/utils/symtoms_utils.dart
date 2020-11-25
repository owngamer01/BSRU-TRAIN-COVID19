import 'package:covid19/enum/symptoms_enum.dart';
import 'package:flutter/cupertino.dart';

class SymtomsUtils {

  static final String _assetPath = 'assets/image';

  static String getSymtomsText(SymptomsType type) {
    if (type == SymptomsType.caugh) {
      return 'Caugh';
    } else if (type == SymptomsType.fever) {
      return 'Fever';
    } else if (type == SymptomsType.headache) {
      return 'Headache';
    } else {
      return 'default';
    }
  }

  static Image getSymtomsIcon(SymptomsType type) {
    if (type == SymptomsType.caugh) {
      return Image.asset('$_assetPath/caugh.png');
    } else if (type == SymptomsType.fever) {
      return Image.asset('$_assetPath/fever.png');
    } else if (type == SymptomsType.headache) {
      return Image.asset('$_assetPath/headache.png');
    } else {
      return null;
    }
  }
}