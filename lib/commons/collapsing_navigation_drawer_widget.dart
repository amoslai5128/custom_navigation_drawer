import 'package:flutter/material.dart';

import '../custom_navigation_drawer.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  final bool isCollapsedByDefault;
  final int? currentSelectedIndex;
  final List<NavigationModel> navigationModels;
  final Color? backgroundColor;
  final double? elevation;
  final Color? userIconColor;
  final Color? itemIconColor;
  final Color? selectedIconColor;
  final Color? selectedItemBackgroundColor;
  final AnimatedIconData? openDrawerIcon;
  final AnimatedIconData? closeDrawerIcon;
  final Color? openedDrawIconColor;
  final Color? closedDrawIconColor;
  final String userName;
  final TextStyle? userNameTextStyle;
  final TextStyle? itemTextStyle;
  final TextStyle? selectedItemTextStyle;
  final Widget? userIconWidget;
  final Widget? buttonCopyrightWidget;

  const CollapsingNavigationDrawer({
    Key? key,
    required this.navigationModels,
    required this.userName,
    this.elevation,
    this.backgroundColor,
    this.openDrawerIcon,
    this.closeDrawerIcon,
    this.openedDrawIconColor,
    this.closedDrawIconColor,
    this.userIconColor,
    this.itemIconColor,
    this.selectedIconColor,
    this.selectedItemBackgroundColor,
    this.itemTextStyle,
    this.selectedItemTextStyle,
    this.userNameTextStyle,
    this.buttonCopyrightWidget,
    this.isCollapsedByDefault = true,
    this.userIconWidget,
    this.currentSelectedIndex,
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
    } else {
      widthAnimation = Tween<double>(begin: maxWidth, end: minWidth).animate(_animationController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, itemWidget) => getWidget(context, itemWidget),
    );
  }

  AnimatedIconData _getDrawerIcon() {
    if (widget.isCollapsedByDefault) {
      return widget.openDrawerIcon ?? AnimatedIcons.menu_arrow;
    } else {
      return widget.closeDrawerIcon ?? AnimatedIcons.arrow_menu;
    }
  }

  Widget getWidget(context, itemWidget) {
    final elevation = isCollapsed ? (widget.elevation ?? 30.0) : 82.0;
    return Material(
      elevation: elevation,
      child: Container(
        width: widthAnimation.value,
        color: widget.backgroundColor ?? drawerBackgroundColor,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 85,
              child: CollapsingListTile(
                title: widget.userName,
                iconColor: widget.userIconColor,
                textStyle: widget.userNameTextStyle,
                userIconWidget: widget.userIconWidget,
                animationController: _animationController,
                isCollapsedByDefault: widget.isCollapsedByDefault,
              ),
            ),
            SizedBox(
              // color: Colors.grey,
              height: 40.0,
            ),
            Expanded(
              child: ListView.builder(
                /* separatorBuilder: (context, counter) {
                  return Divider(height: 12.0);
                }, */
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                    onTap: () {
                      widget.navigationModels[counter].onTap();
                    },
                    isSelected: widget.currentSelectedIndex == counter,
                    iconColor: widget.itemIconColor,
                    selectedIconColor: widget.selectedIconColor,
                    selectedItemBackgroundColor: widget.selectedItemBackgroundColor,
                    textStyle: widget.itemTextStyle,
                    selectedTextStyle: widget.selectedItemTextStyle,
                    title: widget.navigationModels[counter].title,
                    itemIcon: widget.navigationModels[counter].icon,
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
                  if (widget.isCollapsedByDefault) {
                    isCollapsed ? _animationController.reverse() : _animationController.forward();
                  } else {
                    isCollapsed ? _animationController.forward() : _animationController.reverse();
                  }
                });
              },
              child: AnimatedIcon(
                icon: _getDrawerIcon(),
                progress: _animationController,
                color: isCollapsed ? widget.openedDrawIconColor : widget.closedDrawIconColor,
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
