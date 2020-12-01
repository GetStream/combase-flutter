import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';

class GradientFab extends StatelessWidget {
  const GradientFab({
    Key key,
    @required this.child,
    this.onPressed,
    this.gradient,
  }) : super(key: key);

  final VoidCallback onPressed;
  final Gradient gradient;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12.0,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          gradient: context.combaseTheme.combaseGradient,
        ),
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            width: 56.0,
            height: 56.0,
            child: Center(
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
