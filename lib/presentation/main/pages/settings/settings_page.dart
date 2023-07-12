import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/app/app_preferences.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/data/data_sources/local_data_source.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app/dependency_injection.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/routes_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final LocalDataSource _localDataSource = instance<LocalDataSource>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        padding: const EdgeInsets.all(AppPadding.p8),
        children: [
          ListTile(
            leading: SvgPicture.asset(ImageAssets.changeLanguage),
            title: Text(
              AppStrings.changeLanguage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
            onTap: () {
              _changeLanguage();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.contactUs),
            title: Text(
              AppStrings.contactUs,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
            onTap: () {
              _contactUs();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.inviteFriends),
            title: Text(
              AppStrings.inviteFriends,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: SvgPicture.asset(ImageAssets.settingsRightArrow),
            onTap: () {
              _inviteFriends();
            },
          ),
          ListTile(
            leading: SvgPicture.asset(ImageAssets.logout),
            title: Text(
              AppStrings.logout,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onTap: () {
              _logout();
            },
          )
        ],
      ),
    );
  }

  _changeLanguage() {
    //will be implemented later
  }

  //my solution
  Future<void> _contactUs() async {
    await _launchURL('https://flutter.dev');
  }

  //my solution
  Future<void> _launchURL(String URL) async {
    final Uri url = Uri.parse(URL);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  //my solution
  _inviteFriends() async {
    const whatsappNumber = "+963123456748";
    const whatsappURLAndroid =
        "whatsapp://send?phone=$whatsappNumber&text=hello beautiful";
    await _launchURL(whatsappURLAndroid);
  }

  _logout() {
    //remove user from app preference
    _appPreferences.logout();

    //clear cache
    _localDataSource.clearCache();

    //navigate to login page
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }
}
