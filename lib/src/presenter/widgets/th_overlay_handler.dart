
import 'package:flutter/material.dart';

///Loading overlay
class THOverlayHandler {
  ///Constructor
  THOverlayHandler();

  OverlayEntry? _loadingOverlay;
  OverlayEntry? _errorOverlay;

  ///Whether error or loading overlay is showing or not
  bool get isShowing => _errorOverlay != null || _loadingOverlay != null;

  ///Show loading overlay
  void showLoading(BuildContext context, {required Widget loadingWidget}) {
    hide();

    _loadingOverlay = OverlayEntry(
      builder: (BuildContext context) => loadingWidget,
    );
    Overlay.of(context).insert(_loadingOverlay!);
  }

  ///Show error overlay
  void showError(BuildContext context, {required Widget errorWidget}) {
    hide();

    _errorOverlay = OverlayEntry(
      builder: (BuildContext context) => errorWidget,
    );
    Overlay.of(context).insert(_errorOverlay!);
  }

  ///Hide loading/error overlay
  void hide() {
    //Error
    if (_errorOverlay != null) {
      _errorOverlay!.remove();
      _errorOverlay = null;
    }

    //Loading
    if (_loadingOverlay != null) {
      _loadingOverlay!.remove();
      _loadingOverlay = null;
    }
  }
}
