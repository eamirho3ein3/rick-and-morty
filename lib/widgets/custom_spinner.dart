import 'package:flutter/material.dart';
import 'package:rick_and_morty/services/helper.dart';

class CustomSpinner extends StatelessWidget {
  final SpinerSize size;
  final Color? defaultColor;
  const CustomSpinner({Key? key, required this.size, this.defaultColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(size == SpinerSize.small ? 2 : 4),
      height: size == SpinerSize.small ? 24 : 48,
      width: size == SpinerSize.small ? 24 : 48,
      child: CircularProgressIndicator(
        strokeWidth: size == SpinerSize.small ? 4 : 6,
        valueColor: AlwaysStoppedAnimation<Color>(
            defaultColor ?? customTheme(context).currentColor.black[60]!),
        backgroundColor: customTheme(context).currentColor.black[20],
      ),
    );
  }
}

enum SpinerSize { small, large }
