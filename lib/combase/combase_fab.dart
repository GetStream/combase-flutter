import 'package:combase_flutter/combase/theme/theme.dart';
import 'package:flutter/material.dart';

import './welcome_screen.dart';
import 'widgets/fab_route.dart';
import 'widgets/gradient_fab.dart';

class CombaseAction extends StatefulWidget {
  @override
  _CombaseActionState createState() => _CombaseActionState();
}

class _CombaseActionState extends State<CombaseAction> {
  ValueNotifier<bool> _showOnboardingDialog = ValueNotifier<bool>(false);
  LayerLink _layerLink = LayerLink();

  void _updateFabStatus() {
    _showOnboardingDialog.value = !_showOnboardingDialog.value;
  }

  void onFabPressed() {
    _updateFabStatus();
    final theme = CombaseTheme.of(context);
    Navigator.of(context).push(
      FabWidgetRoute(
        onPop: _updateFabStatus,
        builder: (BuildContext context) {
          return Align(
            child: CompositedTransformFollower(
              targetAnchor: Alignment(1.0, -1.4),
              followerAnchor: Alignment.bottomRight,
              link: _layerLink,
              child: SizedBox.fromSize(
                size: theme.combasePopupize,
                child: CombaseTheme(
                  data: theme,
                  child: CombaseWelcome(
      
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GradientFab(
        onPressed: onFabPressed,
        child: ValueListenableBuilder<bool>(
          valueListenable: _showOnboardingDialog,
          builder: (context, value, _) {
            return AnimatedSwitcher(
              duration: kThemeChangeDuration,
              switchInCurve: Curves.ease,
              switchOutCurve: Curves.ease,
              child: value
                  ? Icon(
                      Icons.close,
                      size: 24.0,
                      color: Colors.white,
                    )
                  : Text(
                      '💭',
                      style: TextStyle(fontSize: 24.0),
                    ),
            );
          },
        ),
      ),
    );
  }
}
