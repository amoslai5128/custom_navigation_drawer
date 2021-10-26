import 'package:flutter/material.dart';

import '../custom_navigation_drawer.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  final List<NavigationModel> navigationModels;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? selectedIconColor;
  final Color? selectedItemBackgroundColor;

  final String userName;
  final TextStyle? userNameTextStyle;
  final TextStyle? itemTextStyle;
  final TextStyle? selectedItemTextStyle;
  final Widget? buttonCopyrightWidget;
  final bool isCollapsedByDefault;

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
    this.selectedItemBackgroundColor,
    this.isCollapsedByDefault = true,
  }) : super(key: key);

  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer> with SingleTickerProviderStateMixin {
  double maxWidth = 240;
  double minWidth = 70;
  late bool isCollapsed;
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
    isCollapsed = widget.isCollapsedByDefault;

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    if (isCollapsed) {
      widthAnimation = Tween<double>(begin: minWidth, end: maxWidth).animate(_animationController);
      _animationController.forward();
    } else {
      widthAnimation = Tween<double>(begin: maxWidth, end: minWidth).animate(_animationController);
      _animationController.reverse();
    }
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
      elevation: 70.0,
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
                isCollapsedByDefault: widget.isCollapsedByDefault,
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
                      widget.navigationModels[counter].onTap();
                    },
                    isSelected: currentSelectedIndex == counter,
                    iconColor: widget.iconColor,
                    selectedIconColor: widget.selectedIconColor,
                    selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
                    textStyle: widget.itemTextStyle,
                    selectedTextStyle: widget.selectedItemTextStyle,
                    title: widget.navigationModels[counter].title,
                    icon: widget.navigationModels[counter].icon,
                    animationController: _animationController,
                    isCollapsedByDefault: widget.isCollapsedByDefault,
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
                icon: AnimatedIcons.menu_close,
                progress: _animationController,
                color: widget.selectedIconColor,
                size: 50.0,
              ),
            ),
            SizedBox(
              height: 50.0,
              child: isCollapsed ? null : FittedBox(child: widget.buttonCopyrightWidget),
            ),
          ],
        ),
      ),
    );
  }
}
