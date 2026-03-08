import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../models/member_profile.dart';
import '../../providers/editor_provider.dart';
import '../../widgets/canvas/poster_canvas.dart';

class BatchScreen extends StatefulWidget {
  const BatchScreen({super.key});

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  final _csvCtrl = TextEditingController();
  List<MemberProfile> _previews = [];
  bool _generated = false;

  void _generate() {
    final lines = _csvCtrl.text
        .trim()
        .split('\n')
        .where((l) => l.trim().isNotEmpty)
        .toList();

    final profiles = <MemberProfile>[];
    for (final line in lines) {
      final parts = line.split(',').map((s) => s.trim()).toList();
      if (parts.length < 2) continue;
      profiles.add(MemberProfile(
        fullName: parts.isNotEmpty ? parts[0] : 'Member Name',
        position: parts.length > 1 ? parts[1] : 'Member',
        chapterName: parts.length > 2 ? parts[2] : 'IEEE Student Chapter',
        university: parts.length > 3 ? parts[3] : 'University Name',
        email: parts.length > 4 ? parts[4] : 'member@ieee.org',
      ));
    }

    setState(() {
      _previews = profiles;
      _generated = true;
    });
  }

  @override
  void dispose() {
    _csvCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EditorProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Batch Generator')),
      body: Column(
        children: [
          // Info + input
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.cardSurface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CSV Format:',
                          style: TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600)),
                      SizedBox(height: 4),
                      Text(
                        'Name,Position,Chapter,University,Email',
                        style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            color: AppColors.gold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _csvCtrl,
                  maxLines: 5,
                  style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    hintText:
                        'Alice Smith,Chairperson,IEEE UTAD,University A,alice@ieee.org\nBob Jones,Secretary,IEEE UTAD,University A,bob@ieee.org',
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _generate,
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Generate Previews'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 44)),
                ),
              ],
            ),
          ),
          // Previews grid
          Expanded(
            child: _generated && _previews.isEmpty
                ? const Center(
                    child: Text('No valid rows found. Check CSV format.',
                        style: TextStyle(color: AppColors.textMuted)),
                  )
                : _previews.isEmpty
                    ? const Center(
                        child: Text('Enter CSV data above and tap Generate',
                            style:
                                TextStyle(color: AppColors.textMuted)),
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.all(16),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.0,
                        ),
                        itemCount: _previews.length,
                        itemBuilder: (context, i) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: PosterCanvas(
                              profile: _previews[i],
                              style: prov.style,
                              fontFamily: prov.fontFamily,
                              width: 200,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
