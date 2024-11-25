import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class taskActionButton extends StatelessWidget{
  final String iconPath;
  final void Function()? onPressed;

  const taskActionButton({
    required this.iconPath,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: SvgPicture.asset(iconPath,
          height: 21,
          width: 21,
        ),
      ),
    );
  }

}