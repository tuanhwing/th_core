import 'package:flutter/material.dart';
import 'package:th_core/src/extensions/extensions.dart';
import 'package:th_core/src/resources/th_dimens.dart';
import 'package:th_dependencies/th_dependencies.dart';

///Failure widget
class FailureWidget extends StatelessWidget {
  ///Constructor
  const FailureWidget({
    super.key,
    this.title,
    this.description,
    this.titleButton,
    this.onRetry,
    this.padding,
  });

  ///Title
  final String? title;

  ///Message
  final String? description;

  ///Title button
  final String? titleButton;

  ///Retry callback
  final VoidCallback? onRetry;

  ///Padding
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final String descriptionStr = description ?? '';

    return Padding(
      padding: padding ?? const EdgeInsets.all(THDimens.size16),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: THDimens.size32),
            child: Image.asset(
              'assets/images/error.png',
              package: 'th_core',
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(THDimens.size8),
            child: Column(
              children: <Widget>[
                Text(
                  '${title ?? tr('something_went_wrong').allInCaps}!',
                  style: themeData.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (descriptionStr.isNotEmpty)
                  Text(
                    descriptionStr.inCaps,
                    style: themeData.textTheme.bodyLarge
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
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(
                    horizontal: THDimens.size16,
                  ),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(THDimens.size8),
                    side: BorderSide(color: themeData.disabledColor),
                  ),
                ),
              ),
              child: Text(
                titleButton ?? tr('retry').inCaps,
                style: const TextStyle(fontSize: THDimens.size16),
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );
  }
}
