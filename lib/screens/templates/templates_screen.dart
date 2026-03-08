import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../models/poster_template.dart';
import '../../providers/editor_provider.dart';
import '../../widgets/canvas/poster_canvas.dart';
import '../editor/editor_screen.dart';

class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EditorProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Templates')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: builtInTemplates.length,
        itemBuilder: (context, i) {
          final t = builtInTemplates[i];
          final active = prov.style.bgStart == t.style.bgStart &&
              prov.style.bgEnd == t.style.bgEnd;

          return GestureDetector(
            onTap: () {
              context.read<EditorProvider>().applyTemplate(t);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const EditorScreen()),
              );
            },
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: active
                          ? AppColors.primary
                          : AppColors.textMuted.withValues(alpha: 0.2),
                      width: active ? 2 : 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Column(
                      children: [
                        Expanded(
                          child: PosterCanvas(
                            profile: prov.profile,
                            style: t.style,
                            fontFamily: t.fontFamily,
                            width: 200,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          color: AppColors.cardSurface,
                          child: Text(
                            t.name,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (active)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check,
                          color: Colors.white, size: 12),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
