import 'package:flutter/material.dart';

@immutable
class CombaseThemeData {
  factory CombaseThemeData({
    Brightness brightness,
    Color primaryColor,
    Color secondaryColor,
    Color surfaceColor,
    TextStyle primaryTextStyle,
    TextStyle secondaryTextStyle,
    Size combasePopupSize,
    Gradient combaseGradient,
    double borderRadius,
  }) {
    if (Brightness.light == brightness) {
      return CombaseThemeData._(
        borderRadius: borderRadius ?? 16.0,
        primaryColor: primaryColor ?? const Color(0xFF4D7CFE),
        secondaryColor: secondaryColor ?? const Color(0xFF70A7FF),
        surfaceColor: surfaceColor ?? Colors.white,
        primaryTextStyle: primaryTextStyle ??
            const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF16171d),
              fontSize: 20.0,
            ),
        secondaryTextStyle: secondaryTextStyle ??
            TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
            ),
        combaseGradient: combaseGradient ??
            const LinearGradient(
              begin: Alignment(0.5, 0.0),
              end: Alignment(0.5, 1.0),
              colors: [
                Color(0xFF70A7FF),
                Color(0xFF4D7CFE),
              ],
            ),
        combasePopupSize: combasePopupSize ?? const Size(300.0, 550.0),
      );
    } else {
      return CombaseThemeData._(
        borderRadius: borderRadius ?? 16.0,
        primaryColor: primaryColor ?? const Color(0xFF4D7CFE),
        secondaryColor: secondaryColor ?? const Color(0xFF70A7FF),
        primaryTextStyle: primaryTextStyle ??
            const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Colors.white,
            ),
        secondaryTextStyle: secondaryTextStyle ??
            TextStyle(
              color: Colors.grey[500],
              fontSize: 12.0,
            ),
        combaseGradient: combaseGradient ??
            const LinearGradient(
              begin: Alignment(0.5, 0.0),
              end: Alignment(0.5, 1.0),
              colors: [
                Color(0xFF70A7FF),
                Color(0xFF4D7CFE),
              ],
            ),
        surfaceColor: surfaceColor ?? const Color(0xFF16171d),
        combasePopupSize: combasePopupSize ?? const Size(300.0, 550.0),
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
    this.borderRadius,
  });

  final Color primaryColor;
  final Color secondaryColor;
  final Color surfaceColor;
  final TextStyle primaryTextStyle;
  final TextStyle secondaryTextStyle;
  final Size combasePopupSize;
  final Gradient combaseGradient;
  final double borderRadius;

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
        o.borderRadius == borderRadius &&
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
        borderRadius.hashCode ^
        combaseGradient.hashCode;
  }
}
