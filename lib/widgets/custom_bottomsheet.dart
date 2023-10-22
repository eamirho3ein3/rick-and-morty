import 'package:flutter/material.dart';
import 'package:rick_and_morty/services/helper.dart';

typedef ScrollableContentWidgetBuilder = Widget Function(
  BuildContext context,
  ScrollController scrollController,
);

class CustomBottomSheetView extends StatelessWidget {
  final String? title;
  final Widget? content;
  final Widget? rightButton;
  final Widget? leftButton;
  final BottomSheetTheme style;
  final ScrollableContentWidgetBuilder? builder;
  const CustomBottomSheetView({
    Key? key,
    this.title,
    this.content,
    this.rightButton,
    this.leftButton,
    required this.style,
    this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return builder != null
        ? ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - kToolbarHeight),
            child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return _buidDragableView(context, scrollController);
                }),
          )
        : _buildView(context);
  }

  _buildView(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height - kToolbarHeight),
      child: SingleChildScrollView(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0)),
            color: style.backgroundColor,
          ),
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: SafeArea(
            child: Column(
              children: [
                _buildHandle(context),
                _buildTitle(context),
                content ?? const SizedBox(),
                _buildButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buidDragableView(BuildContext context, ScrollController scrollController) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        color: style.backgroundColor,
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SafeArea(
          child: Column(
            children: [
              _buildHandle(context),
              _buildTitle(context),
              builder != null
                  ? Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          children: [
                            builder!(context, scrollController),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox(),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  _buildHandle(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: 32,
        height: 4,
        decoration: BoxDecoration(
          color: style.handleColor,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  _buildTitle(BuildContext context) {
    return title != null
        ? Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(title ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4),
          )
        : const SizedBox();
  }

  _buildButtons(BuildContext context) {
    return rightButton != null || leftButton != null
        ? Row(
            children: [
              // right button
              rightButton != null
                  ? Expanded(child: rightButton!)
                  : const SizedBox(),
              SizedBox(
                width: leftButton != null && rightButton != null ? 12 : 0,
              ),
              // left button
              leftButton != null
                  ? Expanded(child: leftButton!)
                  : const SizedBox(),
            ],
          )
        : const SizedBox();
  }
}

class BottomSheetTheme {
  final Color backgroundColor;
  final Color handleColor;

  BottomSheetTheme({
    required this.backgroundColor,
    required this.handleColor,
  });
}

class ProjectBottomSheetView extends StatelessWidget {
  final String? title;
  final Widget? content;
  final Widget? rightButton;
  final Widget? leftButton;
  final Widget Function(BuildContext, ScrollController)? builder;
  const ProjectBottomSheetView({
    Key? key,
    this.title,
    this.content,
    this.rightButton,
    this.leftButton,
    this.builder,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CustomBottomSheetView(
      style: BottomSheetTheme(
          backgroundColor: customTheme(context).currentColor.background,
          handleColor: customTheme(context).currentColor.black[20]!),
      content: content,
      leftButton: leftButton,
      rightButton: rightButton,
      title: title,
      builder: builder,
    );
  }
}
