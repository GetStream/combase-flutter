import 'package:flutter/material.dart';

import 'theme_data.dart';

class CombaseTheme extends StatelessWidget {
  const CombaseTheme({
    Key key,
    @required this.data,
    @required this.child,
  })  : assert(data != null),
        assert(child != null),
        super(key: key);

  final CombaseThemeData data;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _CombaseThemeProvider(theme: this, child: child);
  }

  static CombaseThemeData of(BuildContext context) {
    final _CombaseThemeProvider _data =
        context.dependOnInheritedWidgetOfExactType<_CombaseThemeProvider>();
    return _data?.theme?.data;
  }
}


class _CombaseThemeProvider extends InheritedWidget {
  const _CombaseThemeProvider({
    Key key,
    @required this.theme,
    @required Widget child,
  })  : assert(theme != null),
        super(key: key, child: child);

  final CombaseTheme theme;

  @override
  bool updateShouldNotify(_CombaseThemeProvider oldWidget) =>
      theme != oldWidget.theme || theme.data != oldWidget.theme.data;
}

extension CombaseThemeExtension on BuildContext {
  CombaseThemeData get combaseTheme => CombaseTheme.of(this);
}
