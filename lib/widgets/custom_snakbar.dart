import 'package:flutter/material.dart';
import 'package:rick_and_morty/services/helper.dart';

class ProjectSnackBar extends CustomSnackBar {
  final IconData? icon;
  final Widget? image;
  final String? message;
  final String? subMessage;
  final Widget? button;
  final DismissDirection dismissDirection;
  final Duration duration;
  final double? bottomMargin;
  final BuildContext context;
  final double horizontalMargin;
  final BorderRadius? radius;
  final Widget? messageWidget;
  final Color? backgroundColor;
  ProjectSnackBar({
    Key? key,
    this.icon,
    this.image,
    this.subMessage,
    this.dismissDirection = DismissDirection.down,
    this.message,
    required this.context,
    this.button,
    this.bottomMargin,
    this.horizontalMargin = 16,
    required this.duration,
    this.radius,
    this.messageWidget,
    this.backgroundColor,
  }) : super(
          key: key,
          context: context,
          duration: duration,
          message: message,
          style: SnackBarTheme(
            backgroundColor:
                backgroundColor ?? customTheme(context).currentColor.black,
            buttonBackgroundColor: MaterialStateProperty.all(
                customTheme(context).currentColor.white[20]!),
            textColor: customTheme(context).currentColor.text,
            secondaryTextColor: customTheme(context).currentColor.white,
          ),
          bottomMargin: bottomMargin,
          subMessage: subMessage,
          image: image,
          dismissDirection: dismissDirection,
          button: button,
          icon: icon,
          horizontalMargin: horizontalMargin,
          radius: radius ?? BorderRadius.circular(4),
          messageWidget: messageWidget,
        );
}

class CustomSnackBar extends SnackBar {
  final IconData? icon;
  final Widget? image;
  final DismissDirection dismissDirection;

  /// use when you want show text as message
  final String? message;

  /// use when you want show custom widget as message
  final Widget? messageWidget;
  final String? subMessage;
  final Widget? button;
  final SnackBarTheme style;
  final Duration duration;
  final double? bottomMargin;
  final double horizontalMargin;
  final BuildContext context;
  final BorderRadiusGeometry? radius;
  CustomSnackBar({
    Key? key,
    this.icon,
    this.image,
    this.dismissDirection = DismissDirection.down,
    this.message,
    this.messageWidget,
    this.subMessage,
    required this.style,
    required this.context,
    this.button,
    this.bottomMargin,
    this.horizontalMargin = 16,
    required this.duration,
    this.radius,
  }) : super(
          key: key,
          content: Row(
            children: [
              icon != null
                  ? Icon(
                      icon,
                      color: style.textColor,
                      size: 24,
                    )
                  : const SizedBox(),
              image ?? const SizedBox(),
              SizedBox(
                width: icon != null || image != null ? 8 : 0,
              ),
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message == null
                      ? (messageWidget ?? const SizedBox())
                      : Text(
                          message,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: style.textColor),
                        ),
                  subMessage != null
                      ? Text(
                          subMessage,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color:
                                  style.secondaryTextColor ?? style.textColor),
                        )
                      : const SizedBox(),
                ],
              )),
              SizedBox(
                width: button != null ? 8 : 0,
              ),
              button ?? const SizedBox(),
            ],
          ),
          elevation: 0,
          duration: duration,
          shape: RoundedRectangleBorder(
            borderRadius: radius ?? BorderRadius.circular(4),
          ),
          backgroundColor: style.backgroundColor,
          dismissDirection: dismissDirection,
          padding: EdgeInsets.only(
              left: button != null ? 8 : 12, right: 12, top: 12, bottom: 12),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
              left: horizontalMargin,
              right: horizontalMargin,
              bottom: bottomMargin ?? 16),
        );
}

class SnackBarTheme {
  /// use for message color
  final Color textColor;

  /// use for button color
  final Color? buttonTextColor;

  /// use for subMessage color
  final Color? secondaryTextColor;
  final Color backgroundColor;
  final MaterialStateProperty<Color> buttonBackgroundColor;
  SnackBarTheme({
    required this.backgroundColor,
    required this.textColor,
    this.secondaryTextColor,
    required this.buttonBackgroundColor,
    this.buttonTextColor,
  });
}
