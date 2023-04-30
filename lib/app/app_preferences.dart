import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const preferenceKeyLang = 'PREFERENCE_KEY_LANG';

class AppPreferences {
  SharedPreferences sharedPreferences;

  AppPreferences({required this.sharedPreferences});

  Future<String> getAppLanguage() async {
    String? language = sharedPreferences.getString(preferenceKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getValue();
    }
  }
}
