import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;

  final Color? iconColor;
  final TextStyle? textStyle;
  final Color? selectedIconColor;
  final TextStyle? selectedTextStyle;
  final Color? selectedItemBackgroundColor;

  final AnimationController animationController;
  final bool isCollapsedByDefault;

  final bool isSelected;
  final void Function()? onTap;

  CollapsingListTile({
    required this.title,
    required this.icon,
    required this.animationController,
    required this.isCollapsedByDefault,
    this.selectedItemBackgroundColor,
    this.isSelected = false,
    this.onTap,
    this.iconColor,
    this.selectedIconColor,
    this.textStyle,
    this.selectedTextStyle,
  });

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    final double beginW, endW, begainS, endS;
    if (widget.isCollapsedByDefault) {
      beginW = 70;
      endW = 210;
      begainS = 0;
      endS = 10;
    } else {
      beginW = 210;
      endW = 70;
      begainS = 10;
      endS = 0;
    }

    widthAnimation = Tween<double>(begin: beginW, end: endW).animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: begainS, end: endS).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? (widget.selectedItemBackgroundColor ?? Colors.transparent.withOpacity(0.25))
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? widget.selectedIconColor : (widget.iconColor ?? Colors.white30),
              size: 38.0,
            ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= 190)
                ? Text(
                    widget.title,
                    style: widget.isSelected
                        ? (widget.selectedTextStyle ?? listTitleSelectedTextStyle)
                        : (widget.textStyle ?? listTitleDefaultTextStyle),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
