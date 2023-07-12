import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const preferenceKeyLang = 'PREFERENCE_KEY_LANG';
const preferenceKeyOnBoardingScreenViewed =
    'PREFERENCE_KEY_ON_BOARDING_SCREEN_VIEWED';
const preferenceKeyIsUserLoggedIn = 'PREFERENCE_KEY_IS_USER_LOGGED_IN';

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

  Future<void> setOnBoardingScreenViewed() async {
    sharedPreferences.setBool(preferenceKeyOnBoardingScreenViewed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return sharedPreferences.getBool(preferenceKeyOnBoardingScreenViewed) ??
        false;
  }

  Future<void> setUserLoggedIn() async {
    sharedPreferences.setBool(preferenceKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return sharedPreferences.getBool(preferenceKeyIsUserLoggedIn) ?? false;
  }

  Future<void> logout() async {
    sharedPreferences.remove(preferenceKeyIsUserLoggedIn);
  }
}
