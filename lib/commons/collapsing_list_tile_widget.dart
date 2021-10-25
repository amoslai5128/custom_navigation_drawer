import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color? iconColor;
  final TextStyle? textStyle;
  final Color? selectedIconColor;
  final TextStyle? selectedTextStyle;
  final AnimationController animationController;
  final bool isSelected;
  final void Function()? onTap;

  CollapsingListTile({
    required this.title,
    required this.icon,
    required this.animationController,
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
    widthAnimation = Tween<double>(begin: 200, end: 70).animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected ? Colors.transparent.withOpacity(0.3) : Colors.transparent,
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
