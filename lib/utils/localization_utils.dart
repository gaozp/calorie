
import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class LocalizationUtils {
  final Locale locale;

  LocalizationUtils(this.locale);

  static LocalizationUtils of(BuildContext context){
    return Localizations.of(context,LocalizationUtils);
  }

  static Map<String,Map<String,String>> _localizedValues = {
    'en': {
      'app name': 'calculate your calorie',

    },
    'zh': {
      'app name': '饮食计算器',
    },
  };

  get appName{
    print("gaozhipeng ${locale.languageCode}");
    return _localizedValues[locale.languageCode]['app name'];
  }

}

class LocalizationDelegate extends LocalizationsDelegate<LocalizationUtils>{

  const LocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en','zh'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationUtils> load(Locale locale) {
    return new SynchronousFuture<LocalizationUtils>(new LocalizationUtils(locale));
  }

  @override
  bool shouldReload(LocalizationsDelegate<LocalizationUtils> old) {
    return false;
  }

  static LocalizationDelegate delegate = const LocalizationDelegate();

}