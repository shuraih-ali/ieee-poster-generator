import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/editor_provider.dart';
import '../../widgets/canvas/poster_canvas.dart';
import '../../widgets/panels/profile_panel.dart';
import '../../widgets/panels/text_panel.dart';
import '../../widgets/panels/background_panel.dart';
import '../../widgets/panels/photo_panel.dart';
import '../../widgets/panels/logo_panel.dart';
import '../../widgets/panels/socials_panel.dart';
import '../../widgets/panels/export_panel.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  final GlobalKey _canvasKey = GlobalKey();

  static const _tabs = [
    (EditorPanel.profile,    Icons.person_outline,        'Profile'),
    (EditorPanel.text,       Icons.text_fields_outlined,  'Text'),
    (EditorPanel.background, Icons.palette_outlined,      'Background'),
    (EditorPanel.photo,      Icons.photo_camera_outlined, 'Photo'),
    (EditorPanel.logo,       Icons.star_outline_rounded,  'Logo'),
    (EditorPanel.links,      Icons.link_outlined,         'Links'),
    (EditorPanel.export,     Icons.download_outlined,     'Export'),
  ];

  Widget _panelFor(EditorPanel panel) {
    switch (panel) {
      case EditorPanel.profile:    return const ProfilePanel();
      case EditorPanel.text:       return const TextPanel();
      case EditorPanel.background: return const BackgroundPanel();
      case EditorPanel.photo:      return const PhotoPanel();
      case EditorPanel.logo:       return const LogoPanel();
      case EditorPanel.links:      return const SocialsPanel();
      case EditorPanel.export:     return ExportPanel(canvasKey: _canvasKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EditorProvider>();
    final isWide = MediaQuery.of(context).size.width > 700;

    final canvas = RepaintBoundary(
      key: _canvasKey,
      child: LayoutBuilder(
        builder: (ctx, constraints) => PosterCanvas(
          profile: prov.profile,
          style: prov.style,
          fontFamily: prov.fontFamily,
          width: constraints.maxWidth,
        ),
      ),
    );

    final tabBar = Container(
      height: 60,
      color: AppColors.cardSurface,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.map((t) {
            final (panel, icon, label) = t;
            final active = prov.activePanel == panel;
            return GestureDetector(
              onTap: () => context.read<EditorProvider>().setPanel(panel),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 72,
                decoration: BoxDecoration(
                  color: active
                      ? AppColors.primary.withValues(alpha: 0.15)
                      : Colors.transparent,
                  border: Border(
                    bottom: BorderSide(
                      color: active ? AppColors.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon,
                        size: 20,
                        color: active ? AppColors.primary : AppColors.textMuted),
                    const SizedBox(height: 3),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 9,
                        color: active ? AppColors.primary : AppColors.textMuted,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );

    if (isWide) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('IEEE Poster Studio'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                prov.profile.fullName,
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
            ),
          ],
        ),
        body: Row(
          children: [
            SizedBox(
              width: 320,
              child: Column(
                children: [
                  tabBar,
                  Expanded(child: _panelFor(prov.activePanel)),
                ],
              ),
            ),
            const VerticalDivider(width: 1),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: AspectRatio(aspectRatio: 1, child: canvas),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('IEEE Poster Studio')),
        body: Column(
          children: [
            AspectRatio(aspectRatio: 1, child: canvas),
            tabBar,
            Expanded(child: _panelFor(prov.activePanel)),
          ],
        ),
      );
    }
  }
}