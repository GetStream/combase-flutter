import 'package:flutter/material.dart';

@immutable
class CombaseThemeData {
  factory CombaseThemeData({Brightness brightness}) {
    if (Brightness.light == brightness) {
      return CombaseThemeData._(
        primaryColor: const Color(0xFF4D7CFE),
        secondaryColor: const Color(0xFF70A7FF),
        surfaceColor: Colors.white,
        primaryTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF16171d),
            fontSize: 20.0),
        secondaryTextStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 12.0,
        ),
        combaseGradient: const LinearGradient(
          begin: Alignment(0.5, 0.0),
          end: Alignment(0.5, 1.0),
          colors: [
            Color(0xFF70A7FF),
            Color(0xFF4D7CFE),
          ],
        ),
        combasePopupSize: const Size(300.0, 550.0),
      );
    } else {
      return CombaseThemeData._(
        primaryColor: const Color(0xFF4D7CFE),
        secondaryColor: const Color(0xFF70A7FF),
        primaryTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          color: Colors.white,
        ),
        secondaryTextStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 12.0,
        ),
        combaseGradient: const LinearGradient(
          begin: Alignment(0.5, 0.0),
          end: Alignment(0.5, 1.0),
          colors: [
            Color(0xFF70A7FF),
            Color(0xFF4D7CFE),
          ],
        ),
        surfaceColor: const Color(0xFF16171d),
        combasePopupSize: const Size(300.0, 550.0),
      );
    }
  }

  const CombaseThemeData._({
    this.primaryColor,
    this.secondaryColor,
    this.surfaceColor,
    this.primaryTextStyle,
    this.secondaryTextStyle,
    this.combaseGradient,
    this.combasePopupSize,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;
  final TextStyle primaryTextStyle;
  final TextStyle secondaryTextStyle;
  final Size combasePopupSize;
  final Gradient combaseGradient;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CombaseThemeData &&
        o.primaryColor == primaryColor &&
        o.secondaryColor == secondaryColor &&
        o.surfaceColor == surfaceColor &&
        o.primaryTextStyle == primaryTextStyle &&
        o.secondaryTextStyle == secondaryTextStyle &&
        o.combasePopupSize == combasePopupSize &&
        o.combaseGradient == combaseGradient;
  }

  @override
  int get hashCode {
    return primaryColor.hashCode ^
        secondaryColor.hashCode ^
        surfaceColor.hashCode ^
        primaryTextStyle.hashCode ^
        secondaryTextStyle.hashCode ^
        combasePopupSize.hashCode ^
        combaseGradient.hashCode;
  }
}
