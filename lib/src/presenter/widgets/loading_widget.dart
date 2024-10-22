
import 'package:flutter/material.dart';

import 'package:th_core/src/resources/th_dimens.dart';

///Loading widget
class LoadingWidget extends StatelessWidget {
  ///Constructor
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return  ColoredBox(
      color: themeData.primaryColorDark.withOpacity(0.1),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: THDimens.size2,
          valueColor: AlwaysStoppedAnimation<Color>(themeData.primaryColor),
        ),
      ),
    );
  }
}
