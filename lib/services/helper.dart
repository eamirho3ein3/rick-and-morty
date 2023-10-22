import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/services/api/errors.dart';
import 'package:rick_and_morty/theme/theme-manager.dart';
import 'package:rick_and_morty/widgets/custom_button.dart';

CustomTheme customTheme(BuildContext context) {
  return Provider.of<CustomTheme>(context, listen: false);
}

CustomButtonTheme getButtonTheme(ButtonType type, BuildContext context) {
  CustomButtonTheme style;
  switch (type) {
    case ButtonType.primary:
      style = CustomButtonTheme(
        backgroundColor: customTheme(context).currentColor.primary,
        disabledColor: customTheme(context).currentColor.primaryDisable,
        foregroundColor: customTheme(context).currentColor.text,
        foregroundDisabledColor:
            customTheme(context).currentColor.text.withOpacity(0.6),
        loadingButtonTheme: getLoadingStyle(context),
      );
      break;
    case ButtonType.secondary:
      style = CustomButtonTheme(
        backgroundColor: customTheme(context).currentColor.secondary,
        disabledColor: customTheme(context).currentColor.secondaryDisable,
        foregroundColor: customTheme(context).currentColor.text,
        foregroundDisabledColor: customTheme(context).currentColor.textSoft,
        loadingButtonTheme: getLoadingStyle(context),
      );
      break;
    case ButtonType.tertiary:
    default:
      style = CustomButtonTheme(
        backgroundColor: customTheme(context).currentColor.background,
        disabledColor: customTheme(context).currentColor.text,
        foregroundColor: customTheme(context).currentColor.text,
        foregroundDisabledColor: customTheme(context).currentColor.text,
        loadingButtonTheme: getLoadingStyle(context),
      );
      break;
  }
  return style;
}

LoadingButtonTheme getLoadingStyle(BuildContext context,
    {Color? overridValueColor, Color? overridBackgroundColor}) {
  return customTheme(context).isDarkMode
      ? LoadingButtonTheme(
          valueColor:
              overridValueColor ?? customTheme(context).currentColor.black[60]!,
          backgroundColor: overridBackgroundColor ??
              customTheme(context).currentColor.black[20]!,
        )
      : LoadingButtonTheme(
          valueColor:
              overridValueColor ?? customTheme(context).currentColor.white,
          backgroundColor: overridBackgroundColor ??
              customTheme(context).currentColor.white[20]!,
        );
}

// Future<Token?> getToken() async {
//   var globalVariable = GlobalVariable();
//   if (globalVariable.token != null) {
//     return globalVariable.token!;
//   } else {
//     var value = await StorageManager.readData(token);

//     if (value != null) {
//       var result = Token.fromJson(jsonDecode(value));
//       // log("access_token = ${result.accessToken}");
//       // log("refresh_token = ${result.refreshToken}");
//       // log("tokenId = ${result.tokenId}");
//       globalVariable.setToken = result;
//       return result;
//     } else {
//       return null;
//     }
//   }
// }

// Future<bool> saveToken(dynamic data) async {
//   try {
//     log("access_token = ${data['token']}");
//     var result = await StorageManager.saveData(token, jsonEncode(data));
//     var globalVariable = GlobalVariable();
//     var _token = Token.fromJson(data);
//     globalVariable.setToken = _token;
//     return result;
//   } catch (e) {
//     print("e = $e");
//     return false;
//   }
// }

Future<DioException> checkError(dynamic error, {String? defaultMessage}) async {
  if (error is DioException) {
    return error;
  } else {
    String message = defaultMessage ?? default_error;
    var err = createCustomError(message: message);
    return err;
  }
}

DioException createCustomError(
    {required String message, DioExceptionType? type}) {
  return DioException(
    requestOptions: RequestOptions(path: ''),
    error: message,
    type: type ?? DioExceptionType.unknown,
  );
}
