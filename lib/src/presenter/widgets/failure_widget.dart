
import 'package:flutter/material.dart';
import 'package:th_core/src/extensions/extensions.dart';
import 'package:th_core/src/resources/th_dimens.dart';
import 'package:th_dependencies/th_dependencies.dart';

///Failure widget
class FailureWidget extends StatelessWidget {
  ///Constructor
  const FailureWidget(
      {Key? key, this.errorMessage, this.titleButton, this.onRetry,})
      : super(key: key);

  ///Error message
  final String? errorMessage;
  ///Title button
  final String? titleButton;
  ///Retry callback
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/error.png', package: 'th_core',),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(THDimens.size24),
          child: Text(
            '${errorMessage ?? tr('something_went_wrong').inCaps} :(',
            style: themeData.textTheme.headline6!
                .apply(color: themeData.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),

        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(THDimens.size16),
            ),
            border: Border.all(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(THDimens.size16),
            onTap: onRetry,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: THDimens.size8,
                horizontal: THDimens.size32,
              ),
              child: Text(
                titleButton ?? tr('retry').inCaps,
                style: Theme.of(context).textTheme.subtitle1!.apply(
                  fontWeightDelta: 2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
