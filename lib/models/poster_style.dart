import 'package:flutter/material.dart';

// ─── FractionalOffset2 ───────────────────────────────────────────────────────
class FractionalOffset2 {
  final double x;
  final double y;

  const FractionalOffset2({this.x = 0.0, this.y = 0.0});

  FractionalOffset2 copyWith({double? x, double? y}) =>
      FractionalOffset2(x: x ?? this.x, y: y ?? this.y);

  Map<String, dynamic> toMap() => {'x': x, 'y': y};

  factory FractionalOffset2.fromMap(Map<String, dynamic> m) =>
      FractionalOffset2(
        x: (m['x'] as num?)?.toDouble() ?? 0.0,
        y: (m['y'] as num?)?.toDouble() ?? 0.0,
      );
}

// ─── TextStyle2 ──────────────────────────────────────────────────────────────
class TextStyle2 {
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double letterSpacing;
  final double lineHeight;
  final TextAlign align;

  const TextStyle2({
    required this.fontSize,
    this.fontWeight = FontWeight.w600,
    this.color = Colors.white,
    this.letterSpacing = 0.0,
    this.lineHeight = 1.2,
    this.align = TextAlign.left,
  });

  TextStyle2 copyWith({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? lineHeight,
    TextAlign? align,
  }) =>
      TextStyle2(
        fontSize: fontSize ?? this.fontSize,
        fontWeight: fontWeight ?? this.fontWeight,
        color: color ?? this.color,
        letterSpacing: letterSpacing ?? this.letterSpacing,
        lineHeight: lineHeight ?? this.lineHeight,
        align: align ?? this.align,
      );

  Map<String, dynamic> toMap() => {
        'fontSize': fontSize,
        'fontWeight': fontWeight.index,
        'color': color.value,
        'letterSpacing': letterSpacing,
        'lineHeight': lineHeight,
        'align': align.index,
      };

  factory TextStyle2.fromMap(Map<String, dynamic> m) => TextStyle2(
        fontSize: (m['fontSize'] as num?)?.toDouble() ?? 14.0,
        fontWeight: FontWeight.values[m['fontWeight'] as int? ?? 5],
        color: Color(m['color'] as int? ?? 0xFFFFFFFF),
        letterSpacing: (m['letterSpacing'] as num?)?.toDouble() ?? 0.0,
        lineHeight: (m['lineHeight'] as num?)?.toDouble() ?? 1.2,
        align: TextAlign.values[m['align'] as int? ?? 0],
      );

  TextStyle toFlutter({String? fontFamily}) => TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
        height: lineHeight,
        fontFamily: fontFamily,
      );
}

// ─── PosterStyle ─────────────────────────────────────────────────────────────
class PosterStyle {
  final Color bgStart;
  final Color bgEnd;
  final String pattern; // 'circuit' | 'dots' | 'grid' | 'none'
  final Color accentColor;

  // Logo
  final bool showLogo;
  final Color logoBoxColor;
  final Color logoTextColor;
  final double logoFontSize;
  final FractionalOffset2 logoOffset;

  // Photo
  final Color photoFrameColor;
  final double photoFrameWidth;
  final double photoWidthFraction;
  final double photoHeightFraction;
  final FractionalOffset2 photoOffset;

  // Text styles
  final String welcomeText;
  final TextStyle2 welcomeStyle;
  final FractionalOffset2 welcomeOffset;

  final TextStyle2 nameStyle;
  final TextStyle2 positionStyle;

  final String bodyText;
  final TextStyle2 bodyStyle;

  // Socials
  final bool showSocials;
  final double socialFontSize;
  final Color socialColor;
  final Color socialAccentColor;
  final FractionalOffset2 socialsOffset;

  // QR
  final bool showQr;
  final double qrSize;
  final FractionalOffset2 qrOffset;

  // Footer
  final String footerText;
  final double footerFontSize;
  final Color footerColor;

  const PosterStyle({
    this.bgStart = const Color(0xFF003366),
    this.bgEnd = const Color(0xFF00629B),
    this.pattern = 'circuit',
    this.accentColor = const Color(0xFFFFD700),
    this.showLogo = true,
    this.logoBoxColor = const Color(0xFFFFD700),
    this.logoTextColor = const Color(0xFF003366),
    this.logoFontSize = 11.0,
    this.logoOffset = const FractionalOffset2(x: 0.04, y: 0.04),
    this.photoFrameColor = const Color(0xFFFFD700),
    this.photoFrameWidth = 3.0,
    this.photoWidthFraction = 0.32,
    this.photoHeightFraction = 0.38,
    this.photoOffset = const FractionalOffset2(x: 0.34, y: 0.22),
    this.welcomeText = 'Welcome to IEEE',
    this.welcomeStyle = const TextStyle2(
      fontSize: 9.0,
      color: Color(0xFFFFD700),
      letterSpacing: 2.0,
      fontWeight: FontWeight.w500,
    ),
    this.welcomeOffset = const FractionalOffset2(x: 0.05, y: 0.62),
    this.nameStyle = const TextStyle2(
      fontSize: 22.0,
      color: Color(0xFFE8F0FF),
      fontWeight: FontWeight.w700,
      lineHeight: 1.1,
    ),
    this.positionStyle = const TextStyle2(
      fontSize: 10.0,
      color: Color(0xFF7FB9D8),
      letterSpacing: 1.5,
      fontWeight: FontWeight.w500,
    ),
    this.bodyText = '',
    this.bodyStyle = const TextStyle2(
      fontSize: 8.0,
      color: Color(0xFFB0C8E0),
      lineHeight: 1.5,
    ),
    this.showSocials = true,
    this.socialFontSize = 8.0,
    this.socialColor = const Color(0xFF7FB9D8),
    this.socialAccentColor = const Color(0xFF00629B),
    this.socialsOffset = const FractionalOffset2(x: 0.0, y: 0.0),
    this.showQr = true,
    this.qrSize = 0.18,
    this.qrOffset = const FractionalOffset2(x: 0.0, y: 0.0),
    this.footerText = 'IEEE Student Chapter • Inspiring Innovation',
    this.footerFontSize = 7.0,
    this.footerColor = const Color(0xFF7FB9D8),
  });

  PosterStyle copyWith({
    Color? bgStart,
    Color? bgEnd,
    String? pattern,
    Color? accentColor,
    bool? showLogo,
    Color? logoBoxColor,
    Color? logoTextColor,
    double? logoFontSize,
    FractionalOffset2? logoOffset,
    Color? photoFrameColor,
    double? photoFrameWidth,
    double? photoWidthFraction,
    double? photoHeightFraction,
    FractionalOffset2? photoOffset,
    String? welcomeText,
    TextStyle2? welcomeStyle,
    FractionalOffset2? welcomeOffset,
    TextStyle2? nameStyle,
    TextStyle2? positionStyle,
    String? bodyText,
    TextStyle2? bodyStyle,
    bool? showSocials,
    double? socialFontSize,
    Color? socialColor,
    Color? socialAccentColor,
    FractionalOffset2? socialsOffset,
    bool? showQr,
    double? qrSize,
    FractionalOffset2? qrOffset,
    String? footerText,
    double? footerFontSize,
    Color? footerColor,
  }) =>
      PosterStyle(
        bgStart: bgStart ?? this.bgStart,
        bgEnd: bgEnd ?? this.bgEnd,
        pattern: pattern ?? this.pattern,
        accentColor: accentColor ?? this.accentColor,
        showLogo: showLogo ?? this.showLogo,
        logoBoxColor: logoBoxColor ?? this.logoBoxColor,
        logoTextColor: logoTextColor ?? this.logoTextColor,
        logoFontSize: logoFontSize ?? this.logoFontSize,
        logoOffset: logoOffset ?? this.logoOffset,
        photoFrameColor: photoFrameColor ?? this.photoFrameColor,
        photoFrameWidth: photoFrameWidth ?? this.photoFrameWidth,
        photoWidthFraction: photoWidthFraction ?? this.photoWidthFraction,
        photoHeightFraction: photoHeightFraction ?? this.photoHeightFraction,
        photoOffset: photoOffset ?? this.photoOffset,
        welcomeText: welcomeText ?? this.welcomeText,
        welcomeStyle: welcomeStyle ?? this.welcomeStyle,
        welcomeOffset: welcomeOffset ?? this.welcomeOffset,
        nameStyle: nameStyle ?? this.nameStyle,
        positionStyle: positionStyle ?? this.positionStyle,
        bodyText: bodyText ?? this.bodyText,
        bodyStyle: bodyStyle ?? this.bodyStyle,
        showSocials: showSocials ?? this.showSocials,
        socialFontSize: socialFontSize ?? this.socialFontSize,
        socialColor: socialColor ?? this.socialColor,
        socialAccentColor: socialAccentColor ?? this.socialAccentColor,
        socialsOffset: socialsOffset ?? this.socialsOffset,
        showQr: showQr ?? this.showQr,
        qrSize: qrSize ?? this.qrSize,
        qrOffset: qrOffset ?? this.qrOffset,
        footerText: footerText ?? this.footerText,
        footerFontSize: footerFontSize ?? this.footerFontSize,
        footerColor: footerColor ?? this.footerColor,
      );

  Map<String, dynamic> toMap() => {
        'bgStart': bgStart.value,
        'bgEnd': bgEnd.value,
        'pattern': pattern,
        'accentColor': accentColor.value,
        'showLogo': showLogo,
        'logoBoxColor': logoBoxColor.value,
        'logoTextColor': logoTextColor.value,
        'logoFontSize': logoFontSize,
        'logoOffset': logoOffset.toMap(),
        'photoFrameColor': photoFrameColor.value,
        'photoFrameWidth': photoFrameWidth,
        'photoWidthFraction': photoWidthFraction,
        'photoHeightFraction': photoHeightFraction,
        'photoOffset': photoOffset.toMap(),
        'welcomeText': welcomeText,
        'welcomeStyle': welcomeStyle.toMap(),
        'welcomeOffset': welcomeOffset.toMap(),
        'nameStyle': nameStyle.toMap(),
        'positionStyle': positionStyle.toMap(),
        'bodyText': bodyText,
        'bodyStyle': bodyStyle.toMap(),
        'showSocials': showSocials,
        'socialFontSize': socialFontSize,
        'socialColor': socialColor.value,
        'socialAccentColor': socialAccentColor.value,
        'socialsOffset': socialsOffset.toMap(),
        'showQr': showQr,
        'qrSize': qrSize,
        'qrOffset': qrOffset.toMap(),
        'footerText': footerText,
        'footerFontSize': footerFontSize,
        'footerColor': footerColor.value,
      };

  factory PosterStyle.fromMap(Map<String, dynamic> m) => PosterStyle(
        bgStart: Color(m['bgStart'] as int? ?? 0xFF003366),
        bgEnd: Color(m['bgEnd'] as int? ?? 0xFF00629B),
        pattern: m['pattern'] as String? ?? 'circuit',
        accentColor: Color(m['accentColor'] as int? ?? 0xFFFFD700),
        showLogo: m['showLogo'] as bool? ?? true,
        logoBoxColor: Color(m['logoBoxColor'] as int? ?? 0xFFFFD700),
        logoTextColor: Color(m['logoTextColor'] as int? ?? 0xFF003366),
        logoFontSize: (m['logoFontSize'] as num?)?.toDouble() ?? 11.0,
        logoOffset: m['logoOffset'] != null
            ? FractionalOffset2.fromMap(Map<String, dynamic>.from(m['logoOffset']))
            : const FractionalOffset2(x: 0.04, y: 0.04),
        photoFrameColor: Color(m['photoFrameColor'] as int? ?? 0xFFFFD700),
        photoFrameWidth: (m['photoFrameWidth'] as num?)?.toDouble() ?? 3.0,
        photoWidthFraction: (m['photoWidthFraction'] as num?)?.toDouble() ?? 0.32,
        photoHeightFraction: (m['photoHeightFraction'] as num?)?.toDouble() ?? 0.38,
        photoOffset: m['photoOffset'] != null
            ? FractionalOffset2.fromMap(Map<String, dynamic>.from(m['photoOffset']))
            : const FractionalOffset2(x: 0.34, y: 0.22),
        welcomeText: m['welcomeText'] as String? ?? 'Welcome to IEEE',
        welcomeStyle: m['welcomeStyle'] != null
            ? TextStyle2.fromMap(Map<String, dynamic>.from(m['welcomeStyle']))
            : const TextStyle2(fontSize: 9.0, color: Color(0xFFFFD700), letterSpacing: 2.0),
        welcomeOffset: m['welcomeOffset'] != null
            ? FractionalOffset2.fromMap(Map<String, dynamic>.from(m['welcomeOffset']))
            : const FractionalOffset2(x: 0.05, y: 0.62),
        nameStyle: m['nameStyle'] != null
            ? TextStyle2.fromMap(Map<String, dynamic>.from(m['nameStyle']))
            : const TextStyle2(fontSize: 22.0, color: Color(0xFFE8F0FF), fontWeight: FontWeight.w700),
        positionStyle: m['positionStyle'] != null
            ? TextStyle2.fromMap(Map<String, dynamic>.from(m['positionStyle']))
            : const TextStyle2(fontSize: 10.0, color: Color(0xFF7FB9D8), letterSpacing: 1.5),
        bodyText: m['bodyText'] as String? ?? '',
        bodyStyle: m['bodyStyle'] != null
            ? TextStyle2.fromMap(Map<String, dynamic>.from(m['bodyStyle']))
            : const TextStyle2(fontSize: 8.0, color: Color(0xFFB0C8E0), lineHeight: 1.5),
        showSocials: m['showSocials'] as bool? ?? true,
        socialFontSize: (m['socialFontSize'] as num?)?.toDouble() ?? 8.0,
        socialColor: Color(m['socialColor'] as int? ?? 0xFF7FB9D8),
        socialAccentColor: Color(m['socialAccentColor'] as int? ?? 0xFF00629B),
        socialsOffset: m['socialsOffset'] != null
            ? FractionalOffset2.fromMap(Map<String, dynamic>.from(m['socialsOffset']))
            : const FractionalOffset2(x: 0.0, y: 0.0),
        showQr: m['showQr'] as bool? ?? true,
        qrSize: (m['qrSize'] as num?)?.toDouble() ?? 0.18,
        qrOffset: m['qrOffset'] != null
            ? FractionalOffset2.fromMap(Map<String, dynamic>.from(m['qrOffset']))
            : const FractionalOffset2(x: 0.0, y: 0.0),
        footerText: m['footerText'] as String? ?? 'IEEE Student Chapter • Inspiring Innovation',
        footerFontSize: (m['footerFontSize'] as num?)?.toDouble() ?? 7.0,
        footerColor: Color(m['footerColor'] as int? ?? 0xFF7FB9D8),
      );
}
