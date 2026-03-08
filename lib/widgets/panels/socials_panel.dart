import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/poster_style.dart';
import '../../providers/editor_provider.dart';
import '../common/helpers.dart';

class SocialsPanel extends StatelessWidget {
  const SocialsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EditorProvider>();
    final s = prov.style;
    void upd(PosterStyle ns) => context.read<EditorProvider>().updateStyle(ns);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PanelSection(title: 'Social Links', children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show Social Links'),
              value: s.showSocials,
              onChanged: (v) => upd(s.copyWith(showSocials: v)),
            ),
            if (s.showSocials) ...[
              ColorSwatch2(
                label: 'Text Color (Email / GitHub)',
                color: s.socialColor,
                onChanged: (c) => upd(s.copyWith(socialColor: c)),
              ),
              ColorSwatch2(
                label: 'LinkedIn Accent Color',
                color: s.socialAccentColor,
                onChanged: (c) => upd(s.copyWith(socialAccentColor: c)),
              ),
              SliderRow(
                label: 'Font Size',
                value: s.socialFontSize,
                min: 6,
                max: 14,
                onChanged: (v) => upd(s.copyWith(socialFontSize: v)),
              ),
              SliderRow(
                label: 'X Offset (0 = auto)',
                value: s.socialsOffset.x,
                min: 0,
                max: 0.6,
                divisions: 60,
                format: (v) => v.toStringAsFixed(2),
                onChanged: (v) =>
                    upd(s.copyWith(socialsOffset: s.socialsOffset.copyWith(x: v))),
              ),
              SliderRow(
                label: 'Y Offset (0 = auto)',
                value: s.socialsOffset.y,
                min: 0,
                max: 1.0,
                divisions: 100,
                format: (v) => v.toStringAsFixed(2),
                onChanged: (v) =>
                    upd(s.copyWith(socialsOffset: s.socialsOffset.copyWith(y: v))),
              ),
            ],
          ]),
          PanelSection(title: 'QR Code', children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show QR Code'),
              value: s.showQr,
              onChanged: (v) => upd(s.copyWith(showQr: v)),
            ),
            if (s.showQr) ...[
              SliderRow(
                label: 'QR Size',
                value: s.qrSize,
                min: 0.08,
                max: 0.30,
                divisions: 22,
                format: (v) => '${(v * 100).round()}%',
                onChanged: (v) => upd(s.copyWith(qrSize: v)),
              ),
              SliderRow(
                label: 'X Offset (0 = auto right)',
                value: s.qrOffset.x,
                min: 0,
                max: 0.8,
                divisions: 80,
                format: (v) => v.toStringAsFixed(2),
                onChanged: (v) =>
                    upd(s.copyWith(qrOffset: s.qrOffset.copyWith(x: v))),
              ),
              SliderRow(
                label: 'Y Offset (0 = auto bottom)',
                value: s.qrOffset.y,
                min: 0,
                max: 1.0,
                divisions: 100,
                format: (v) => v.toStringAsFixed(2),
                onChanged: (v) =>
                    upd(s.copyWith(qrOffset: s.qrOffset.copyWith(y: v))),
              ),
            ],
          ]),
        ],
      ),
    );
  }
}
