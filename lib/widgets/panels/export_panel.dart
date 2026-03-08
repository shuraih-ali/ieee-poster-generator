import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/editor_provider.dart';
import '../../providers/projects_provider.dart';
import '../common/helpers.dart';

class ExportPanel extends StatefulWidget {
  final GlobalKey canvasKey;
  const ExportPanel({super.key, required this.canvasKey});

  @override
  State<ExportPanel> createState() => _ExportPanelState();
}

class _ExportPanelState extends State<ExportPanel> {
  bool _busy = false;

  Future<File?> _capture() async {
    try {
      final ctx = widget.canvasKey.currentContext;
      if (ctx == null) throw Exception('Canvas not found');
      final boundary = ctx.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) throw Exception('Failed to encode image');
      final bytes = byteData.buffer.asUint8List();
      final dir = await getTemporaryDirectory();
      final prov = context.read<EditorProvider>();
      final name = prov.profile.fullName.replaceAll(' ', '_');
      final ts = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/ieee_poster_${name}_$ts.png');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Capture error: $e'), backgroundColor: Colors.red),
        );
      }
      return null;
    }
  }

  Future<void> _saveGallery() async {
    setState(() => _busy = true);
    try {
      final hasAccess = await Gal.hasAccess();
      if (!hasAccess) await Gal.requestAccess();
      final file = await _capture();
      if (file == null) throw Exception('Capture failed');
      await Gal.putImage(file.path);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Poster saved to gallery!'), backgroundColor: Colors.green),
      );
      await file.delete();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _share() async {
    setState(() => _busy = true);
    try {
      final file = await _capture();
      if (file == null) throw Exception('Capture failed');
      await Share.shareXFiles([XFile(file.path)], text: 'My IEEE Poster');
      if (!mounted) return;
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Share failed: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _saveToFiles() async {
    setState(() => _busy = true);
    try {
      final file = await _capture();
      if (file == null) throw Exception('Capture failed');
      final dir = await getApplicationDocumentsDirectory();
      final prov = context.read<EditorProvider>();
      final name = prov.profile.fullName.replaceAll(' ', '_');
      final ts = DateTime.now().millisecondsSinceEpoch;
      final dest = File('${dir.path}/ieee_poster_${name}_$ts.png');
      await file.copy(dest.path);
      await file.delete();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved to: ${dest.path}'), backgroundColor: AppColors.primary),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _saveProject() async {
    setState(() => _busy = true);
    try {
      final prov = context.read<EditorProvider>();
      final project = prov.snapshot(null);
      await context.read<ProjectsProvider>().save(project);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Project saved!'), backgroundColor: Colors.orange),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Save failed: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _btn(String label, IconData icon, Color color, VoidCallback onTap) {
    return Opacity(
      opacity: _busy ? 0.5 : 1.0,
      child: ElevatedButton.icon(
        onPressed: _busy ? null : onTap,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          minimumSize: const Size(double.infinity, 48),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EditorProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_busy)
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: LinearProgressIndicator(),
            ),
          PanelSection(title: 'Export Actions', children: [
            _btn('Save to Gallery', Icons.photo_library_outlined, Colors.green.shade700, _saveGallery),
            const SizedBox(height: 8),
            _btn('Share Poster', Icons.share_outlined, Colors.cyan.shade700, _share),
            const SizedBox(height: 8),
            _btn('Save to App Files', Icons.folder_outlined, AppColors.primary, _saveToFiles),
            const SizedBox(height: 8),
            _btn('Save Editable Project', Icons.save_outlined, Colors.orange.shade700, _saveProject),
          ]),
          PanelSection(title: 'Export Ratios', children: [
            const Text(
              'Instagram Post (1:1) — 1080×1080',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            _btn('Export Instagram (1:1)', Icons.camera_alt_outlined, AppColors.primary, _saveGallery),
            const SizedBox(height: 16),
            const Text(
              'LinkedIn Post (~1.91:1) — 1200×628',
              style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            _btn('Export LinkedIn (Wide)', Icons.business_center_outlined, AppColors.deepBlue, _saveGallery),
          ]),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.panelSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.textMuted.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Profile',
                    style: TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(prov.profile.fullName,
                    style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                Text('${prov.profile.position} • ${prov.profile.chapterName}',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}