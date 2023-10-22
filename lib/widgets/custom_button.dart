import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final ButtonSize size;
  final String? title;
  final IconData? rightIcon;
  final IconData? leftIcon;
  final Function()? onClick;
  final CustomButtonTheme style;
  final double? horizontalPadding;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.size,
    this.title,
    this.rightIcon,
    this.leftIcon,
    this.onClick,
    required this.style,
    this.horizontalPadding,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onClick,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.08)),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return style.disabledColor;
            } else {
              return style.backgroundColor;
            }
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return style.foregroundDisabledColor;
            } else {
              return style.foregroundColor;
            }
          },
        ),
        minimumSize: MaterialStateProperty.all(Size.zero),
        padding: MaterialStateProperty.all(
          EdgeInsets.zero,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(80.0),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: isLoading
                ? size == ButtonSize.large
                    ? 14
                    : 10
                : size == ButtonSize.large
                    ? 12
                    : 8,
            horizontal: horizontalPadding ?? 8),
        child: isLoading
            ? _buildLoading(context)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // right icon
                  rightIcon != null
                      ? Padding(
                          padding: EdgeInsets.only(left: title != null ? 8 : 0),
                          child: Icon(rightIcon),
                        )
                      : const SizedBox(),

                  // title
                  title != null
                      ? Flexible(
                          child: Text(title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .button!
                                  .copyWith(
                                      color: onClick != null
                                          ? style.foregroundColor
                                          : style.foregroundDisabledColor)),
                        )
                      : const SizedBox(),

                  // left icon
                  leftIcon != null
                      ? Padding(
                          padding:
                              EdgeInsets.only(right: title != null ? 8 : 0),
                          child: Icon(leftIcon),
                        )
                      : const SizedBox(),
                ],
              ),
      ),
    );
  }

  _buildLoading(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(style.loadingButtonTheme.valueColor),
        backgroundColor: style.loadingButtonTheme.backgroundColor,
      ),
    );
  }
}

class CustomButtonTheme {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color disabledColor;
  final Color foregroundDisabledColor;
  final LoadingButtonTheme loadingButtonTheme;

  CustomButtonTheme({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.disabledColor,
    required this.foregroundDisabledColor,
    required this.loadingButtonTheme,
  });
}

class ComponentAction {
  final String text;
  final Function()? onClick;
  final CustomButtonTheme style;
  final CustomIconTheme? icon;
  final bool isLoading;
  ComponentAction({
    required this.text,
    this.onClick,
    required this.style,
    this.icon,
    this.isLoading = false,
  });
}

class CustomIconTheme {
  final IconData icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  CustomIconTheme(
      {required this.icon,
      this.iconColor,
      this.backgroundColor,
      this.borderColor});
}

class LoadingButtonTheme {
  final Color valueColor;
  final Color backgroundColor;

  LoadingButtonTheme({
    required this.valueColor,
    required this.backgroundColor,
  });
}

enum ButtonSize { medium, large }

enum ButtonType { primary, secondary, tertiary }
