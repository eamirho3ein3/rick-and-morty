import 'package:flutter/material.dart';
import 'package:rick_and_morty/services/helper.dart';
import 'package:rick_and_morty/widgets/custom_bottomsheet.dart';
import 'package:rick_and_morty/widgets/custom_button.dart';

class ApiFailureWidget extends StatelessWidget {
  final String message;
  final String? description;
  final IconData icon;
  final Color? iconBackgroundColor;
  final Color? iconColor;
  final Widget? rightButton;
  final Widget? leftButton;
  final bool? hideRightButton;
  final bool? hideLeftButton;
  const ApiFailureWidget(
      {Key? key,
      required this.message,
      this.description,
      required this.icon,
      this.iconBackgroundColor,
      this.iconColor,
      this.rightButton,
      this.leftButton,
      this.hideRightButton,
      this.hideLeftButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProjectBottomSheetView(
      content: _buildContent(context),
      leftButton: leftButton ??
          (hideLeftButton != null && hideLeftButton!
              ? null
              : CustomButton(
                  title: 'Try again',
                  size: ButtonSize.medium,
                  onClick: () {
                    Navigator.pop(context, true);
                  },
                  style: getButtonTheme(ButtonType.secondary, context),
                )),
      rightButton: rightButton ??
          (hideRightButton != null && hideRightButton!
              ? null
              : CustomButton(
                  title: 'Cancel',
                  size: ButtonSize.medium,
                  onClick: () {
                    Navigator.pop(context);
                  },
                  style: getButtonTheme(ButtonType.tertiary, context),
                )),
    );
  }

  _buildContent(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconBackgroundColor ??
                customTheme(context).currentColor.background,
            radius: 24,
            child: Icon(
              icon,
              color: iconColor ??
                  customTheme(context).currentColor.textDanger.withOpacity(0.6),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // message
                  Text(
                    message,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.w800),
                  ),

                  // description
                  description == null || description!.isEmpty
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            description ?? '',
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: customTheme(context)
                                        .currentColor
                                        .text
                                        .withOpacity(0.6)),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
