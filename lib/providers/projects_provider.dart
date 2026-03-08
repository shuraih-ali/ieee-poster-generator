import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/saved_project.dart';
import '../core/constants/app_constants.dart';

class ProjectsProvider extends ChangeNotifier {
  List<SavedProject> _projects = [];
  List<SavedProject> get projects => List.unmodifiable(_projects);

  ProjectsProvider() {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(AppConstants.projectsKey) ?? [];
      _projects = jsonList.map((j) => SavedProject.fromJson(j)).toList();
      _projects.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to load projects: $e');
    }
  }

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _projects.map((p) => p.toJson()).toList();
      await prefs.setStringList(AppConstants.projectsKey, jsonList);
    } catch (e) {
      debugPrint('Failed to persist projects: $e');
    }
  }

  Future<void> save(SavedProject project) async {
    final idx = _projects.indexWhere((p) => p.id == project.id);
    if (idx >= 0) {
      _projects[idx] = project;
    } else {
      _projects.insert(0, project);
    }
    notifyListeners();
    await _persist();
  }

  Future<void> delete(String id) async {
    _projects.removeWhere((p) => p.id == id);
    notifyListeners();
    await _persist();
  }
}
