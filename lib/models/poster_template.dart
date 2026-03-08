import 'package:flutter/material.dart';
import 'poster_style.dart';

class PosterTemplate {
  final String name;
  final PosterStyle style;
  final String fontFamily;

  const PosterTemplate({
    required this.name,
    required this.style,
    this.fontFamily = 'Montserrat',
  });
}

final List<PosterTemplate> builtInTemplates = [
const PosterTemplate(
    name: 'IEEE Dark Blue',
    fontFamily: 'Montserrat',
    style: PosterStyle(
      bgStart: Color(0xFF003366),
      bgEnd: Color(0xFF00629B),
      pattern: 'circuit',
      accentColor: Color(0xFFFFD700),
      logoBoxColor: Color(0xFFFFD700),
      logoTextColor: Color(0xFF003366),
      welcomeStyle: TextStyle2(
        fontSize: 9.0,
        color: Color(0xFFFFD700),
        letterSpacing: 2.0,
        fontWeight: FontWeight.w500,
      ),
      nameStyle: TextStyle2(
        fontSize: 22.0,
        color: Color(0xFFE8F0FF),
        fontWeight: FontWeight.w700,
        lineHeight: 1.1,
      ),
      positionStyle: TextStyle2(
        fontSize: 10.0,
        color: Color(0xFF7FB9D8),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
      ),
      bodyStyle: TextStyle2(
        fontSize: 8.0,
        color: Color(0xFFB0C8E0),
        lineHeight: 1.5,
      ),
      socialColor: Color(0xFF7FB9D8),
      socialAccentColor: Color(0xFF00629B),
      footerColor: Color(0xFF7FB9D8),
    ),
  ),
  const PosterTemplate(
    name: 'Minimal White',
    fontFamily: 'DM Sans',
    style: PosterStyle(
      bgStart: Color(0xFFF8FAFF),
      bgEnd: Color(0xFFE8F0FE),
      pattern: 'dots',
      accentColor: Color(0xFF003366),
      logoBoxColor: Color(0xFF003366),
      logoTextColor: Color(0xFFFFFFFF),
      welcomeStyle: TextStyle2(
        fontSize: 9.0,
        color: Color(0xFF003366),
        letterSpacing: 2.0,
        fontWeight: FontWeight.w500,
      ),
      nameStyle: TextStyle2(
        fontSize: 22.0,
        color: Color(0xFF080E1A),
        fontWeight: FontWeight.w700,
        lineHeight: 1.1,
      ),
      positionStyle: TextStyle2(
        fontSize: 10.0,
        color: Color(0xFF00629B),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
      ),
      bodyStyle: TextStyle2(
        fontSize: 8.0,
        color: Color(0xFF4A7A9B),
        lineHeight: 1.5,
      ),
      socialColor: Color(0xFF4A7A9B),
      socialAccentColor: Color(0xFF003366),
      footerColor: Color(0xFF4A7A9B),
      photoFrameColor: Color(0xFF003366),
    ),
  ),
  const PosterTemplate(
    name: 'Corporate Tech',
    fontFamily: 'Space Grotesk',
    style: PosterStyle(
      bgStart: Color(0xFF0F0C29),
      bgEnd: Color(0xFF24243E),
      pattern: 'grid',
      accentColor: Color(0xFF00D4FF),
      logoBoxColor: Color(0xFF00D4FF),
      logoTextColor: Color(0xFF0F0C29),
      welcomeStyle: TextStyle2(
        fontSize: 9.0,
        color: Color(0xFF00D4FF),
        letterSpacing: 2.0,
        fontWeight: FontWeight.w500,
      ),
      nameStyle: TextStyle2(
        fontSize: 22.0,
        color: Color(0xFFE8F0FF),
        fontWeight: FontWeight.w700,
        lineHeight: 1.1,
      ),
      positionStyle: TextStyle2(
        fontSize: 10.0,
        color: Color(0xFF00D4FF),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
      ),
      bodyStyle: TextStyle2(
        fontSize: 8.0,
        color: Color(0xFFB0C8E0),
        lineHeight: 1.5,
      ),
      socialColor: Color(0xFF00D4FF),
      socialAccentColor: Color(0xFF00A0CC),
      photoFrameColor: Color(0xFF00D4FF),
      footerColor: Color(0xFF7FB9D8),
    ),
  ),
  const PosterTemplate(
    name: 'University Welcome',
    fontFamily: 'Raleway',
    style: PosterStyle(
      bgStart: Color(0xFF1A237E),
      bgEnd: Color(0xFF0D47A1),
      pattern: 'circuit',
      accentColor: Color(0xFFFFAB00),
      logoBoxColor: Color(0xFFFFAB00),
      logoTextColor: Color(0xFF1A237E),
      welcomeStyle: TextStyle2(
        fontSize: 9.0,
        color: Color(0xFFFFAB00),
        letterSpacing: 2.0,
        fontWeight: FontWeight.w500,
      ),
      nameStyle: TextStyle2(
        fontSize: 22.0,
        color: Color(0xFFE8F0FF),
        fontWeight: FontWeight.w700,
        lineHeight: 1.1,
      ),
      positionStyle: TextStyle2(
        fontSize: 10.0,
        color: Color(0xFFBBD6FF),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
      ),
      bodyStyle: TextStyle2(
        fontSize: 8.0,
        color: Color(0xFFBBD6FF),
        lineHeight: 1.5,
      ),
      socialColor: Color(0xFFBBD6FF),
      socialAccentColor: Color(0xFF0D47A1),
      photoFrameColor: Color(0xFFFFAB00),
      footerColor: Color(0xFFBBD6FF),
    ),
  ),
  const PosterTemplate(
    name: 'Modern Gradient',
    fontFamily: 'Poppins',
    style: PosterStyle(
      bgStart: Color(0xFF667EEA),
      bgEnd: Color(0xFF6B73FF),
      pattern: 'dots',
      accentColor: Color(0xFFFFD700),
      logoBoxColor: Color(0xFFFFD700),
      logoTextColor: Color(0xFF667EEA),
      welcomeStyle: TextStyle2(
        fontSize: 9.0,
        color: Color(0xFFFFD700),
        letterSpacing: 2.0,
        fontWeight: FontWeight.w500,
      ),
      nameStyle: TextStyle2(
        fontSize: 22.0,
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w700,
        lineHeight: 1.1,
      ),
      positionStyle: TextStyle2(
        fontSize: 10.0,
        color: Color(0xFFE0E8FF),
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
      ),
      bodyStyle: TextStyle2(
        fontSize: 8.0,
        color: Color(0xFFE0E8FF),
        lineHeight: 1.5,
      ),
      socialColor: Color(0xFFE0E8FF),
      socialAccentColor: Color(0xFF5568D8),
      photoFrameColor: Color(0xFFFFD700),
      footerColor: Color(0xFFE0E8FF),
    ),
  ),
];
