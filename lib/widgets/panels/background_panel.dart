import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../models/poster_template.dart';
import '../../providers/editor_provider.dart';
import '../common/helpers.dart';

class BackgroundPanel extends StatelessWidget {
  const BackgroundPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EditorProvider>();
    final s = prov.style;

    void upd(s2) => context.read<EditorProvider>().updateStyle(s2);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PanelSection(title: 'Quick Templates', children: [
            SizedBox(
              height: 80,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: builtInTemplates.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final t = builtInTemplates[i];
                  return GestureDetector(
                    onTap: () =>
                        context.read<EditorProvider>().applyTemplate(t),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [t.style.bgStart, t.style.bgEnd],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: t.style.accentColor.withValues(alpha: 0.6),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          t.name,
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ]),
          PanelSection(title: 'Gradient', children: [
            ColorSwatch2(
              label: 'Gradient Start',
              color: s.bgStart,
              onChanged: (c) => upd(s.copyWith(bgStart: c)),
            ),
            ColorSwatch2(
              label: 'Gradient End',
              color: s.bgEnd,
              onChanged: (c) => upd(s.copyWith(bgEnd: c)),
            ),
            ColorSwatch2(
              label: 'Accent Color',
              color: s.accentColor,
              onChanged: (c) => upd(s.copyWith(accentColor: c)),
            ),
          ]),
          PanelSection(title: 'Pattern', children: [
            Wrap(
              spacing: 8,
              children: ['none', 'circuit', 'dots', 'grid'].map((p) {
                final active = s.pattern == p;
                return GestureDetector(
                  onTap: () => upd(s.copyWith(pattern: p)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.primary
                          : AppColors.panelSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: active
                            ? AppColors.primary
                            : AppColors.textMuted.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      p[0].toUpperCase() + p.substring(1),
                      style: TextStyle(
                        fontSize: 12,
                        color: active
                            ? Colors.white
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ]),
        ],
      ),
    );
  }
}
