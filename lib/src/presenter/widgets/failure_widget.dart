import 'package:flutter/material.dart';
import 'package:th_core/src/extensions/extensions.dart';
import 'package:th_core/src/resources/th_dimens.dart';
import 'package:th_dependencies/th_dependencies.dart';

///Failure widget
class FailureWidget extends StatelessWidget {
  ///Constructor
  const FailureWidget({
    super.key,
    this.imageWidth,
    this.title,
    this.titleStyle,
    this.description,
    this.descriptionStyle,
    this.titleButton,
    this.onRetry,
    this.padding,
    this.buttonStyle,
  });

  ///Image width
  final double? imageWidth;

  ///Title
  final String? title;

  ///Title style
  final TextStyle? titleStyle;

  ///Message
  final String? description;

  ///Description style
  final TextStyle? descriptionStyle;

  ///Title button
  final String? titleButton;

  ///Button style
  final TextStyle? buttonStyle;

  ///Retry callback
  final VoidCallback? onRetry;

  ///Padding
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final String descriptionStr = description ?? '';
    final double leftImagePadding =
        imageWidth != null ? (imageWidth! / THDimens.size8) : THDimens.size32;

    return Padding(
      padding: padding ?? const EdgeInsets.all(THDimens.size16),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: leftImagePadding > THDimens.size32
                  ? THDimens.size32
                  : leftImagePadding,
            ),
            child: Image.asset(
              'assets/images/error.png',
              package: 'th_core',
              width: imageWidth,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(THDimens.size8),
            child: Column(
              children: <Widget>[
                Text(
                  '${title ?? tr('something_went_wrong').allInCaps}!',
                  style: titleStyle ??
                      themeData.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                if (descriptionStr.isNotEmpty)
                  Text(
                    descriptionStr.inCaps,
                    style: descriptionStyle ??
                        themeData.textTheme.bodyMedium
                            ?.copyWith(color: themeData.hintColor),
                  )
                else
                  const SizedBox(),
              ],
            ),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: onRetry,
              style: ButtonStyle(
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(
                    horizontal: THDimens.size16,
                  ),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(THDimens.size8),
                    side: BorderSide(color: themeData.disabledColor),
                  ),
                ),
              ),
              child: Text(
                titleButton ?? tr('retry').inCaps,
                style: buttonStyle ?? themeData.textTheme.titleMedium,
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
