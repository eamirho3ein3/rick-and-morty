import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/services/api/errors.dart';
import 'package:rick_and_morty/widgets/custom_snakbar.dart';
import 'package:rick_and_morty/widgets/network_failure_widget.dart';

class FailureActionBuilder {
  final BuildContext context;
  final DioException? error;
  final Function(BuildContext) onRetryButton;

  FailureActionBuilder(this.context, this.error, this.onRetryButton);

  AppBottomSheetAlert asBottomSheet(
      {String? message,
      bool isDismissible = true,
      String? description,
      Widget? rightButton,
      Widget? leftButton,
      bool? hideRightButton,
      bool? hideLeftButton,
      IconData icon = Icons.warning_amber_outlined,
      Color? iconBackgroundColor,
      Color? iconColor,
      double radius = 8.0}) {
    return AppBottomSheetAlert(
      this,
      message,
      isDismissible,
      description,
      rightButton,
      leftButton,
      hideRightButton,
      hideLeftButton,
      iconBackgroundColor,
      iconColor,
      icon,
      radius,
    );
  }

  AppSnackBarAlert asSnackBar({
    String? message,
    IconData icon = Icons.warning_rounded,
    double bottomMargin = 16,
    int duration = 5,
    Color? backgroundColor,
  }) {
    return AppSnackBarAlert(
        this, message, icon, bottomMargin, duration, backgroundColor);
  }

  show() async {
    switch (error?.type) {
      case DioExceptionType.badResponse:
        switch (error?.response?.statusCode) {
          case 401:
            // we don't have authentication in this app
            break;
          case 400:
          case 422:
          case 429:
            asSnackBar().show();
            break;
          case 404:
          case 500:
            var message = default_error;
            asBottomSheet(message: message).show();
            break;
          case 503:
            var message = update_server_error;
            asBottomSheet(message: message).show();
            break;
        }
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        var message = internet_error;
        asBottomSheet(message: message).show();

        break;
      case DioExceptionType.unknown:
      default:
        var message = default_error;
        asSnackBar(message: message).show();
        break;
    }
  }
}

class AppSnackBarAlert extends AppFailureAlert {
  final double bottomMargin;
  final int duration;
  final IconData icon;
  final Color? backgroundColor;
  AppSnackBarAlert(
    FailureActionBuilder builder, [
    String? message,
    this.icon = Icons.warning_rounded,
    this.bottomMargin = 16,
    this.duration = 5,
    this.backgroundColor,
  ]) : super(builder, message);

  @override
  show() async {
    if (message == null) {
      message =
          (jsonDecode((builder.error?.response ?? "").toString()) as Map? ??
                  {})['message'] ??
              builder.error?.message;
    }

    var snackBar = ProjectSnackBar(
      context: builder.context,
      message: message,
      bottomMargin: bottomMargin,
      duration: Duration(seconds: duration),
      icon: icon,
      backgroundColor: backgroundColor,
    );

    ScaffoldMessenger.of(builder.context).removeCurrentSnackBar();
    ScaffoldMessenger.of(builder.context).showSnackBar(snackBar);
  }
}

class AppBottomSheetAlert extends AppFailureAlert {
  final IconData icon;
  final double radius;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final String? description;
  final Widget? rightButton;
  final Widget? leftButton;
  final bool? hideRightButton;
  final bool? hideLeftButton;
  final bool isDismissible;

  AppBottomSheetAlert(FailureActionBuilder builder,
      [String? message,
      this.isDismissible = true,
      this.description,
      this.rightButton,
      this.leftButton,
      this.hideRightButton,
      this.hideLeftButton,
      this.iconBackgroundColor,
      this.iconColor,
      this.icon = Icons.warning_rounded,
      this.radius = 8.0])
      : super(builder, message);

  @override
  show() async {
    if (message == null) {
      print(
          "error message  = ${(jsonDecode((builder.error?.response ?? "").toString()) as Map? ?? {})['message']}");
      message =
          (jsonDecode((builder.error?.response ?? "").toString()) as Map? ??
                  {})['message'] ??
              (builder.error?.message ?? builder.error?.error);
    }

    Future<bool?> future = showModalBottomSheet<bool?>(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
      ),
      isDismissible: isDismissible,
      context: builder.context,
      builder: (context) => ApiFailureWidget(
        message: message ?? '',
        description: description,
        icon: icon,
        iconColor: iconColor,
        iconBackgroundColor: iconBackgroundColor,
        rightButton: rightButton,
        leftButton: leftButton,
        hideLeftButton: hideLeftButton,
        hideRightButton: hideRightButton,
      ),
    );
    future.then((bool? value) {
      if (value != null && value) {
        builder.onRetryButton(builder.context);
      }
    });
  }
}

abstract class AppFailureAlert {
  final FailureActionBuilder builder;
  String? message;

  AppFailureAlert(this.builder, [this.message]) {
    message = message;
  }

  show() {}
}

class FailureAction {
  static FailureActionBuilder create(BuildContext context, DioException? error,
      Function(BuildContext) onRetryButton) {
    return FailureActionBuilder(context, error, onRetryButton);
  }
}
