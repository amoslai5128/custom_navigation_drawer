import 'package:custom_navigation_drawer/custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Navigation Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: drawerBackgroundColor,
          title: Text(
            "Collapsing Navigation Drawer/Sidebar",
          ),
        ),
        //drawer: CollapsingNavigationDrawer(),
        body: Stack(
          children: <Widget>[
            Container(
              color: selectedColor,
            ),
            BaseNavigationDrawer(),
          ],
        ));
  }
}

class BaseNavigationDrawer extends StatelessWidget {
  const BaseNavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CollapsingNavigationDrawer(
        isCollapsedByDefault: true,
        elevation: 0,
        backgroundColor: KColors.primary,
        openedDrawIconColor: KColors.passive,
        closedDrawIconColor: KColors.background,
        userIconColor: KColors.background,
        itemIconColor: KColors.passive,
        userNameTextStyle: Theme.of(context).textTheme.headline4?.copyWith(color: KColors.background),
        itemTextStyle: Theme.of(context).textTheme.bodyText1?.copyWith(color: KColors.background),
        selectedIconColor: Colors.white,
        selectedItemBackgroundColor: KColors.primaryLight.withOpacity(0.3),
        selectedItemTextStyle: Theme.of(context).textTheme.bodyText2?.copyWith(color: Colors.white),
        userName: 'Amos',
        userIconWidget: Image.asset("assets/images/user_1.png", width: 30),
        buttonCopyrightWidget: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset("assets/images/app_logo_white.png", width: 30),
        ),
        navigationModels: [
          NavigationModel(
            title: 'Comparasion',
            icon: Icons.home,
            onTap: () => {} /* Navigator.popAndPushNamed(context,  ) */,
          ),
          NavigationModel(title: 'Second Page', icon: Icons.settings, onTap: () {})
        ],
      ),
    );
  }
}

class KColors {
  static const background = Colors.white;

  /// Card, Textfield, widgets backgound
  static const base = Color(0xFFF4F5F9);

  static const primary = Color(0xFF4F5DE0);
  static const primaryLight = Color(0xFFE2E7FB);

  // Colors for status, buttons
  /// Textfield, Boarder
  static const passive = Color(0xFFD0D1E1);
}
