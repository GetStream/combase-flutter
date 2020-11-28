library combase_flutter;

import 'package:flutter/material.dart';

import 'combase/combase_fab.dart';
import 'combase/theme/theme.dart';
import 'combase/theme/theme_data.dart';

export './combase/welcome_screen.dart';
export './combase/combase_fab.dart';
export 'combase/theme/theme.dart';
export './combase/theme/theme_data.dart';

class Combase extends StatefulWidget {
  const Combase({
    Key key,
    @required this.child,
    this.theme,
  }) : super(key: key);
  final Widget child;
  final CombaseThemeData theme;

  @override
  _CombaseState createState() => _CombaseState();
}

class _CombaseState extends State<Combase> {
  @override
  Widget build(BuildContext context) {
    return CombaseTheme(
      data: widget.theme ??
          CombaseThemeData(
            brightness: Theme.of(context).brightness,
          ),
      child: CombaseActionLayout(
        child: widget.child,
      ),
    );
  }
}
