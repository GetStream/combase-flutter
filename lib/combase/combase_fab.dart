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

class CombaseActionLayout extends StatefulWidget {
  const CombaseActionLayout({Key key, @required this.child}) : super(key: key);
  final Widget child;

  @override
  _CombaseActionLayoutState createState() => _CombaseActionLayoutState();
}

class _CombaseActionLayoutState extends State<CombaseActionLayout>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    setState(() {
      // Rebuild tree with for new metrics
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Widget buildPositioned(final Widget child) {
    final textDirection = Directionality.of(context);
    if (textDirection == TextDirection.ltr) {
      return Positioned(
        right: 16.0,
        bottom: MediaQuery.of(context).viewPadding.bottom + 16.0,
        child: child,
      );
    } else {
      return Positioned(
        left: 16.0,
        bottom:MediaQuery.of(context).viewPadding.bottom + 16.0,
        child: child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(WidgetsBinding.instance.window),
      child: Builder(builder: (context) {
        return Stack(
          children: <Widget>[
            widget.child,
            buildPositioned(
              SafeArea(child: CombaseAction()),
            ),
          ],
        );
      }),
    );
  }
}
