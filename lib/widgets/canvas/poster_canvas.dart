import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../models/member_profile.dart';
import '../../models/poster_style.dart';
import 'pattern_painter.dart';

class PosterCanvas extends StatelessWidget {
  final MemberProfile profile;
  final PosterStyle style;
  final String fontFamily;
  final double width;

  const PosterCanvas({
    super.key,
    required this.profile,
    required this.style,
    required this.fontFamily,
    this.width = 400,
  });

  TextStyle _font(TextStyle2 ts) {
    try {
      return GoogleFonts.getFont(
        fontFamily,
        fontSize: ts.fontSize,
        fontWeight: ts.fontWeight,
        color: ts.color,
        letterSpacing: ts.letterSpacing,
        height: ts.lineHeight,
      );
    } catch (_) {
      return TextStyle(
        fontSize: ts.fontSize,
        fontWeight: ts.fontWeight,
        color: ts.color,
        letterSpacing: ts.letterSpacing,
        height: ts.lineHeight,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final w = width;
        final h = w; // 1:1 aspect ratio
        final scale = w / 400.0;

        return SizedBox(
          width: w,
          height: h,
          child: ClipRect(
            child: Stack(
              children: [
                // ── Layer 1: Gradient background ──
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [style.bgStart, style.bgEnd],
                      ),
                    ),
                  ),
                ),

                // ── Layer 2: Pattern overlay ──
                if (style.pattern != 'none')
                  Positioned.fill(
                    child: CustomPaint(
                      painter: PatternPainter(
                        pattern: style.pattern,
                        color: style.accentColor,
                      ),
                    ),
                  ),

                // ── Layer 3: Top accent bar ──
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 5 * scale,
                    color: style.accentColor,
                  ),
                ),

                // ── Layer 4: Logo box ──
                if (style.showLogo)
                  Positioned(
                    left: style.logoOffset.x * w,
                    top: style.logoOffset.y * h + 5 * scale,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8 * scale, vertical: 4 * scale),
                      decoration: BoxDecoration(
                        color: style.logoBoxColor,
                        borderRadius: BorderRadius.circular(4 * scale),
                      ),
                      child: Text(
                        profile.logoText.isEmpty ? 'IEEE' : profile.logoText,
                        style: _font(
                          style.welcomeStyle.copyWith(
                            fontSize: style.logoFontSize,
                            color: style.logoTextColor,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),

                // ── Layer 5: Chapter + University ──
                Positioned(
                  left: (style.logoOffset.x * w) + 60 * scale,
                  top: style.logoOffset.y * h + 8 * scale,
                  right: 8 * scale,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.chapterName,
                        style: _font(
                          style.positionStyle.copyWith(
                            fontSize: (style.positionStyle.fontSize * 0.9).clamp(6.0, 14.0),
                            color: style.accentColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 2 * scale),
                      Text(
                        profile.university,
                        style: _font(
                          style.positionStyle.copyWith(
                            fontSize: (style.positionStyle.fontSize * 0.8).clamp(5.0, 12.0),
                            color: style.positionStyle.color.withValues(alpha: 0.8),
                            letterSpacing: 0.2,
                          ),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // ── Layer 6: Position badge (top-right) ──
                Positioned(
                  top: 12 * scale,
                  right: 8 * scale,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 6 * scale, vertical: 3 * scale),
                    decoration: BoxDecoration(
                      color: style.accentColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(3 * scale),
                      border: Border.all(
                        color: style.accentColor.withValues(alpha: 0.4),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      profile.position.toUpperCase(),
                      style: _font(
                        style.positionStyle.copyWith(
                          fontSize: (style.positionStyle.fontSize * 0.75).clamp(5.0, 10.0),
                          color: style.accentColor,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Layer 7: Photo frame ──
                Positioned(
                  left: style.photoOffset.x * w,
                  top: style.photoOffset.y * h,
                  child: Container(
                    width: style.photoWidthFraction * w,
                    height: style.photoHeightFraction * h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: style.photoFrameColor,
                        width: style.photoFrameWidth * scale,
                      ),
                      borderRadius: BorderRadius.circular(4 * scale),
                      color: style.bgEnd.withValues(alpha: 0.5),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          (4 * scale - style.photoFrameWidth * scale)
                              .clamp(0, 999)),
                      child: profile.photoPath != null
                          ? Image.file(
                              File(profile.photoPath!),
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  _photoPlaceholder(scale),
                            )
                          : _photoPlaceholder(scale),
                    ),
                  ),
                ),

                // ── Layer 8: Welcome label ──
                Positioned(
                  left: style.welcomeOffset.x * w,
                  top: style.welcomeOffset.y * h,
                  right: 8 * scale,
                  child: Row(
                    children: [
                      Container(
                        width: 6 * scale,
                        height: 6 * scale,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: style.accentColor,
                        ),
                      ),
                      SizedBox(width: 6 * scale),
                      Flexible(
                        child: Text(
                          style.welcomeText,
                          style: _font(style.welcomeStyle),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Layer 9: Member name ──
                Positioned(
                  left: style.welcomeOffset.x * w,
                  top: style.welcomeOffset.y * h + 14 * scale,
                  right: 8 * scale,
                  child: Text(
                    profile.fullName,
                    style: _font(style.nameStyle),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: style.nameStyle.align,
                  ),
                ),

                // ── Layer 10: Position - Chapter ──
                Positioned(
                  left: style.welcomeOffset.x * w,
                  top: style.welcomeOffset.y * h + 50 * scale,
                  right: 8 * scale,
                  child: Text(
                    '${profile.position}  •  ${profile.chapterName}',
                    style: _font(style.positionStyle),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // ── Layer 11: Body text ──
                Positioned(
                  left: style.welcomeOffset.x * w,
                  top: style.welcomeOffset.y * h + 64 * scale,
                  right: 8 * scale,
                  child: Text(
                    style.bodyText.isEmpty
                        ? _autoBody(profile)
                        : style.bodyText,
                    style: _font(style.bodyStyle),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: style.bodyStyle.align,
                  ),
                ),

                // ── Layer 12: Divider ──
                Positioned(
                  left: style.welcomeOffset.x * w,
                  top: style.welcomeOffset.y * h + 100 * scale,
                  right: 8 * scale,
                  child: Container(
                    height: 0.5,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          style.accentColor.withValues(alpha: 0.8),
                          style.accentColor.withValues(alpha: 0.0),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── Layer 13: Social links ──
                if (style.showSocials)
                  _buildSocials(scale, w, h),

                // ── Layer 14: QR code ──
                if (style.showQr && profile.email.isNotEmpty)
                  _buildQr(scale, w, h),

                // ── Layer 15: Footer bar ──
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 6 * scale, horizontal: 10 * scale),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          style.bgStart.withValues(alpha: 0.95),
                          style.bgEnd.withValues(alpha: 0.95),
                        ],
                      ),
                      border: Border(
                        top: BorderSide(
                          color: style.accentColor.withValues(alpha: 0.3),
                          width: 0.5,
                        ),
                      ),
                    ),
                    child: Text(
                      style.footerText,
                      style: _font(
                        style.bodyStyle.copyWith(
                          fontSize: style.footerFontSize,
                          color: style.footerColor,
                          letterSpacing: 0.5,
                        ),
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _photoPlaceholder(double scale) {
    return Center(
      child: Icon(
        Icons.person_outline_rounded,
        size: 48 * scale,
        color: style.photoFrameColor.withValues(alpha: 0.5),
      ),
    );
  }

  String _autoBody(MemberProfile p) {
    return 'Passionate about technology, innovation, and the IEEE mission. '
        'Member of ${p.chapterName}, ${p.university}. '
        'Dedicated to advancing engineering excellence and fostering '
        'collaboration within the global IEEE community.';
  }

  Widget _buildSocials(double scale, double w, double h) {
    final autoX = style.welcomeOffset.x * w;
    final autoY = style.welcomeOffset.y * h + 108 * scale;
    final left = style.socialsOffset.x == 0 && style.socialsOffset.y == 0
        ? autoX
        : style.socialsOffset.x * w;
    final top = style.socialsOffset.x == 0 && style.socialsOffset.y == 0
        ? autoY
        : style.socialsOffset.y * h;

    final items = <_SocialItem>[];
    if (profile.email.isNotEmpty) {
      items.add(_SocialItem(Icons.email_outlined, profile.email, style.socialColor));
    }
    if (profile.linkedin.isNotEmpty) {
      items.add(_SocialItem(Icons.link_rounded, profile.linkedin, style.socialAccentColor));
    }
    if (profile.github.isNotEmpty) {
      items.add(_SocialItem(Icons.code_rounded, profile.github, style.socialColor));
    }

    return Positioned(
      left: left,
      top: top,
      right: style.showQr ? (style.qrSize * w + 16 * scale) : 8 * scale,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) {
          return Padding(
            padding: EdgeInsets.only(bottom: 3 * scale),
            child: Row(
              children: [
                Icon(item.icon,
                    size: style.socialFontSize * scale * 1.2, color: item.color),
                SizedBox(width: 4 * scale),
                Flexible(
                  child: Text(
                    item.text,
                    style: _font(
                      style.bodyStyle.copyWith(
                        fontSize: style.socialFontSize,
                        color: item.color,
                      ),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQr(double scale, double w, double h) {
    final qrPx = style.qrSize * w;
    final autoRight = 8 * scale;
    final autoBottom = 24 * scale;

    double? right;
    double? bottom;
    double? left;
    double? top;

    if (style.qrOffset.x == 0 && style.qrOffset.y == 0) {
      right = autoRight;
      bottom = autoBottom;
    } else {
      left = style.qrOffset.x * w;
      top = style.qrOffset.y * h;
    }

    final qrData = 'mailto:${profile.email}';

    return Positioned(
      right: right,
      bottom: bottom,
      left: left,
      top: top,
      child: Container(
        width: qrPx,
        height: qrPx,
        padding: EdgeInsets.all(3 * scale),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4 * scale),
        ),
        child: QrImageView(
          data: qrData,
          version: QrVersions.auto,
          eyeStyle: const QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: Color(0xFF00629B),
          ),
          dataModuleStyle: const QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Color(0xFF003366),
          ),
        ),
      ),
    );
  }
}

class _SocialItem {
  final IconData icon;
  final String text;
  final Color color;
  _SocialItem(this.icon, this.text, this.color);
}
