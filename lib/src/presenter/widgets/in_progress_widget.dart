
import 'package:flutter/material.dart';

///In-progress widget
class InProgressWidget extends StatelessWidget {
  ///Constructor
  const InProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return  Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(themeData.primaryColor),
      ),
    );
  }
}
