import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/constants/app_colors.dart';
import '../../models/poster_style.dart';
import '../../providers/editor_provider.dart';
import '../common/helpers.dart';

class PhotoPanel extends StatefulWidget {
  const PhotoPanel({super.key});

  @override
  State<PhotoPanel> createState() => _PhotoPanelState();
}

class _PhotoPanelState extends State<PhotoPanel> {
  bool _loading = false;
  final _picker = ImagePicker();

  Future<void> _pick(ImageSource source) async {
    Permission perm;
    if (source == ImageSource.camera) {
      perm = Permission.camera;
    } else {
      // Android 13+ uses photos permission, older uses storage
      perm = Platform.isAndroid ? Permission.photos : Permission.photos;
    }

    final status = await perm.request();
    if (!mounted) return;

    if (status.isPermanentlyDenied) {
      _showSettingsDialog(
          source == ImageSource.camera ? 'Camera' : 'Photos');
      return;
    }
    if (!status.isGranted) return;

    setState(() => _loading = true);
    try {
      final xf = await _picker.pickImage(
          source: source, maxWidth: 1200, imageQuality: 90);
      if (!mounted) return;
      if (xf != null) {
        final prov = context.read<EditorProvider>();
        prov.updateProfile(prov.profile.copyWith(photoPath: xf.path));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showSettingsDialog(String permName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.panelSurface,
        title: Text('$permName Permission',
            style: const TextStyle(color: AppColors.textPrimary)),
        content: Text(
          '$permName access is required. Please open Settings to grant permission.',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: AppColors.textMuted))),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Open Settings')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EditorProvider>();
    final s = prov.style;
    final profile = prov.profile;
    void upd(PosterStyle ns) => context.read<EditorProvider>().updateStyle(ns);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Preview
          Center(
            child: Container(
              width: 160,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(color: s.photoFrameColor, width: s.photoFrameWidth),
                borderRadius: BorderRadius.circular(8),
                color: AppColors.panelSurface,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: profile.photoPath != null
                    ? Image.file(File(profile.photoPath!),
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                            Icons.person_outline_rounded,
                            color: AppColors.textMuted,
                            size: 48))
                    : const Icon(Icons.person_outline_rounded,
                        color: AppColors.textMuted, size: 48),
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else ...[
            ElevatedButton.icon(
              onPressed: () => _pick(ImageSource.gallery),
              icon: const Icon(Icons.photo_library_outlined),
              label: const Text('Choose from Gallery'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 44)),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _pick(ImageSource.camera),
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Take a Photo'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepBlue,
                  minimumSize: const Size(double.infinity, 44)),
            ),
            if (profile.photoPath != null) ...[
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () {
                  context.read<EditorProvider>().updateProfile(
                        profile.copyWith(clearPhoto: true),
                      );
                },
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remove Photo'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    minimumSize: const Size(double.infinity, 44)),
              ),
            ],
          ],
          const SizedBox(height: 16),
          PanelSection(title: 'Frame', children: [
            ColorSwatch2(
              label: 'Frame Color',
              color: s.photoFrameColor,
              onChanged: (c) => upd(s.copyWith(photoFrameColor: c)),
            ),
            SliderRow(
              label: 'Frame Width',
              value: s.photoFrameWidth,
              min: 0,
              max: 8,
              onChanged: (v) => upd(s.copyWith(photoFrameWidth: v)),
            ),
          ]),
          PanelSection(title: 'Size & Position', children: [
            SliderRow(
              label: 'Photo Width',
              value: s.photoWidthFraction,
              min: 0.1,
              max: 0.5,
              divisions: 40,
              format: (v) => '${(v * 100).round()}%',
              onChanged: (v) => upd(s.copyWith(photoWidthFraction: v)),
            ),
            SliderRow(
              label: 'Photo Height',
              value: s.photoHeightFraction,
              min: 0.1,
              max: 0.6,
              divisions: 50,
              format: (v) => '${(v * 100).round()}%',
              onChanged: (v) => upd(s.copyWith(photoHeightFraction: v)),
            ),
            SliderRow(
              label: 'X Offset',
              value: s.photoOffset.x,
              min: 0,
              max: 0.5,
              divisions: 50,
              format: (v) => v.toStringAsFixed(2),
              onChanged: (v) =>
                  upd(s.copyWith(photoOffset: s.photoOffset.copyWith(x: v))),
            ),
            SliderRow(
              label: 'Y Offset',
              value: s.photoOffset.y,
              min: 0,
              max: 0.7,
              divisions: 70,
              format: (v) => v.toStringAsFixed(2),
              onChanged: (v) =>
                  upd(s.copyWith(photoOffset: s.photoOffset.copyWith(y: v))),
            ),
          ]),
        ],
      ),
    );
  }
}
