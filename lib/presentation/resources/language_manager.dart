import 'dart:ui';

enum LanguageType { arabic, english }

const arabic = 'ar';
const english = 'en';

const assetLocalizationPath = 'assets/translations';

const arabicLocale = Locale('ar', 'SA');
const englishLocale = Locale('en', 'US');

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}
