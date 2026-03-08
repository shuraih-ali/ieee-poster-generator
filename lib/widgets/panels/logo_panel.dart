import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/poster_style.dart';
import '../../providers/editor_provider.dart';
import '../common/helpers.dart';

class LogoPanel extends StatelessWidget {
  const LogoPanel({super.key});

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
          PanelSection(title: 'Logo Visibility', children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Show Logo Box'),
              value: s.showLogo,
              onChanged: (v) => upd(s.copyWith(showLogo: v)),
            ),
          ]),
          if (s.showLogo) ...[
            PanelSection(title: 'Logo Appearance', children: [
              ColorSwatch2(
                label: 'Box Fill Color',
                color: s.logoBoxColor,
                onChanged: (c) => upd(s.copyWith(logoBoxColor: c)),
              ),
              ColorSwatch2(
                label: 'Text Color',
                color: s.logoTextColor,
                onChanged: (c) => upd(s.copyWith(logoTextColor: c)),
              ),
              SliderRow(
                label: 'Font Size',
                value: s.logoFontSize,
                min: 6,
                max: 20,
                onChanged: (v) => upd(s.copyWith(logoFontSize: v)),
              ),
            ]),
            PanelSection(title: 'Position', children: [
              SliderRow(
                label: 'X Offset',
                value: s.logoOffset.x,
                min: 0,
                max: 0.5,
                divisions: 50,
                format: (v) => v.toStringAsFixed(2),
                onChanged: (v) =>
                    upd(s.copyWith(logoOffset: s.logoOffset.copyWith(x: v))),
              ),
              SliderRow(
                label: 'Y Offset',
                value: s.logoOffset.y,
                min: 0,
                max: 0.3,
                divisions: 30,
                format: (v) => v.toStringAsFixed(2),
                onChanged: (v) =>
                    upd(s.copyWith(logoOffset: s.logoOffset.copyWith(y: v))),
              ),
            ]),
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                'Note: Logo text content is edited in the Profile tab → Logo Text field.',
                style: TextStyle(fontSize: 11, color: Color(0xFF4A7A9B)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
