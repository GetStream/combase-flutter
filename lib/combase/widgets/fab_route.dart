import 'package:flutter/material.dart';

class FabWidgetRoute extends PopupRoute {
  FabWidgetRoute({
    @required this.builder,
    this.onPop,
    this.animationDuration = kThemeChangeDuration,
    RouteSettings settings,
  }) : super(settings: settings);

  final WidgetBuilder builder;
  final VoidCallback onPop;
  final Duration animationDuration;

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => "Combase Widget";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Duration get transitionDuration => animationDuration;

  @override
  bool didPop(dynamic result) {
    if (onPop != null) onPop();
    return super.didPop(result);
  }
}
