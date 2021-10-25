import 'package:flutter/material.dart';

import '../custom_navigation_drawer.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  final List<NavigationModel> navigationModels;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? selectedIconColor;
  final String userName;
  final TextStyle? userNameTextStyle;
  final TextStyle? itemTextStyle;
  final TextStyle? selectedItemTextStyle;
  final Widget? buttonCopyrightWidget;

  const CollapsingNavigationDrawer({
    Key? key,
    required this.navigationModels,
    required this.userName,
    this.backgroundColor,
    this.iconColor,
    this.selectedIconColor,
    this.itemTextStyle,
    this.selectedItemTextStyle,
    this.userNameTextStyle,
    this.buttonCopyrightWidget,
  }) : super(key: key);

  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer> with SingleTickerProviderStateMixin {
  double maxWidth = 210;
  double minWidth = 70;
  bool isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.navigationModels.isEmpty) {
      setState(() {
        widget.navigationModels.addAll(demoNavigationItems);
      });
    }
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, itemWidget) => getWidget(context, itemWidget),
    );
  }

  Widget getWidget(context, itemWidget) {
    return Material(
      elevation: 80.0,
      child: Container(
        width: widthAnimation.value,
        color: widget.backgroundColor ?? drawerBackgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 85,
              child: CollapsingListTile(
                title: widget.userName,
                iconColor: widget.iconColor,
                textStyle: widget.userNameTextStyle,
                icon: Icons.person,
                animationController: _animationController,
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 40.0,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(height: 12.0);
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                    onTap: () {
                      setState(() {
                        currentSelectedIndex = counter;
                      });
                    },
                    isSelected: currentSelectedIndex == counter,
                    iconColor: widget.iconColor,
                    selectedIconColor: widget.selectedIconColor,
                    textStyle: widget.itemTextStyle,
                    selectedTextStyle: widget.selectedItemTextStyle,
                    title: widget.navigationModels[counter].title,
                    icon: widget.navigationModels[counter].icon,
                    animationController: _animationController,
                  );
                },
                itemCount: widget.navigationModels.length,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                  isCollapsed ? _animationController.forward() : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: _animationController,
                color: widget.selectedIconColor,
                size: 50.0,
              ),
            ),
            SizedBox(
              height: 50.0,
              child: FittedBox(child: widget.buttonCopyrightWidget),
            ),
          ],
        ),
      ),
    );
  }
}
