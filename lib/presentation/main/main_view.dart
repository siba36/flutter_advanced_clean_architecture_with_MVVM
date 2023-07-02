import 'package:flutter/material.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/main/pages/home/view/home_page.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/main/pages/notifications/notification_page.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/main/pages/search/search_page.dart';
import 'package:flutter_advanced_clean_architecture_with_mvvm/presentation/main/pages/settings/settings_page.dart';

import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage()
  ];

  List<String> titles = [
    AppStrings.home,
    AppStrings.search,
    AppStrings.notification,
    AppStrings.settings,
  ];

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex],
            style: Theme.of(context).textTheme.titleSmall),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.lightGrey, spreadRadius: AppSize.s1)
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: _onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: AppStrings.home),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: AppStrings.search),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppStrings.notification),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: AppStrings.settings)
          ],
        ),
      ),
    );
  }

  _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
