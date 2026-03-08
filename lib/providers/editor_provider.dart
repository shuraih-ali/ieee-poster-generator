import 'package:flutter/material.dart';
import '../models/member_profile.dart';
import '../models/poster_style.dart';
import '../models/poster_template.dart';
import '../models/saved_project.dart';
import 'package:uuid/uuid.dart';

enum EditorPanel {
  profile,
  text,
  background,
  photo,
  logo,
  links,
  export,
}

class EditorProvider extends ChangeNotifier {
  MemberProfile _profile = const MemberProfile();
  PosterStyle _style = const PosterStyle();
  String _fontFamily = 'Montserrat';
  EditorPanel _activePanel = EditorPanel.profile;

  MemberProfile get profile => _profile;
  PosterStyle get style => _style;
  String get fontFamily => _fontFamily;
  EditorPanel get activePanel => _activePanel;

  void updateProfile(MemberProfile profile) {
    _profile = profile;
    notifyListeners();
  }

  void updateStyle(PosterStyle style) {
    _style = style;
    notifyListeners();
  }

  void setFont(String font) {
    _fontFamily = font;
    notifyListeners();
  }

  void setPanel(EditorPanel panel) {
    _activePanel = panel;
    notifyListeners();
  }

  void applyTemplate(PosterTemplate template) {
    _style = template.style;
    _fontFamily = template.fontFamily;
    notifyListeners();
  }

  void loadProject(SavedProject project) {
    _profile = project.profile;
    _style = project.style;
    _fontFamily = project.fontFamily;
    notifyListeners();
  }

  SavedProject snapshot(String? existingId) => SavedProject(
        id: existingId ?? const Uuid().v4(),
        profile: _profile,
        style: _style,
        fontFamily: _fontFamily,
        createdAt: DateTime.now(),
      );
}
