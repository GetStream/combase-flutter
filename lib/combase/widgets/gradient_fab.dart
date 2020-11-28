
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
    return Container(
      constraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
      decoration: BoxDecoration(
        boxShadow: kElevationToShadow[12],
        shape: BoxShape.circle,
        gradient: context.combaseTheme.combaseGradient
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
