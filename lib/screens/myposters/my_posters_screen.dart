import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/editor_provider.dart';
import '../../providers/projects_provider.dart';
import '../../widgets/canvas/poster_canvas.dart';
import '../editor/editor_screen.dart';

class MyPostersScreen extends StatelessWidget {
  const MyPostersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = context.watch<ProjectsProvider>().projects;

    if (projects.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Posters')),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.photo_library_outlined,
                  size: 64, color: AppColors.textMuted),
              SizedBox(height: 16),
              Text('No saved posters yet',
                  style: TextStyle(color: AppColors.textSecondary)),
              SizedBox(height: 8),
              Text('Create a poster and tap "Save Editable Project"',
                  style:
                      TextStyle(fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Posters (${projects.length})'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemCount: projects.length,
        itemBuilder: (context, i) {
          final project = projects[i];

          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  context.read<EditorProvider>().loadProject(project);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const EditorScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.textMuted.withValues(alpha: 0.2),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(11),
                    child: Column(
                      children: [
                        Expanded(
                          child: PosterCanvas(
                            profile: project.profile,
                            style: project.style,
                            fontFamily: project.fontFamily,
                            width: 200,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          color: AppColors.cardSurface,
                          child: Column(
                            children: [
                              Text(
                                project.profile.fullName,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                project.profile.position,
                                style: const TextStyle(
                                    fontSize: 9,
                                    color: AppColors.textMuted),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Delete button
              Positioned(
                top: 6,
                right: 6,
                child: GestureDetector(
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: AppColors.panelSurface,
                        title: const Text('Delete Project',
                            style: TextStyle(color: AppColors.textPrimary)),
                        content: Text(
                          'Delete poster for ${project.profile.fullName}?',
                          style: const TextStyle(
                              color: AppColors.textSecondary),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: AppColors.textMuted)),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, true),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade700),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true && context.mounted) {
                      await context
                          .read<ProjectsProvider>()
                          .delete(project.id);
                    }
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.red.shade700,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close,
                        color: Colors.white, size: 14),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
