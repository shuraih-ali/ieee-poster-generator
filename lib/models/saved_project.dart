import 'dart:convert';
import 'member_profile.dart';
import 'poster_style.dart';

class SavedProject {
  final String id;
  final MemberProfile profile;
  final PosterStyle style;
  final String fontFamily;
  final DateTime createdAt;

  const SavedProject({
    required this.id,
    required this.profile,
    required this.style,
    required this.fontFamily,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'profile': profile.toMap(),
        'style': style.toMap(),
        'fontFamily': fontFamily,
        'createdAt': createdAt.toIso8601String(),
      };

  factory SavedProject.fromMap(Map<String, dynamic> m) => SavedProject(
        id: m['id'] as String,
        profile: MemberProfile.fromMap(Map<String, dynamic>.from(m['profile'])),
        style: PosterStyle.fromMap(Map<String, dynamic>.from(m['style'])),
        fontFamily: m['fontFamily'] as String? ?? 'Montserrat',
        createdAt: DateTime.parse(m['createdAt'] as String),
      );

  String toJson() => jsonEncode(toMap());

  factory SavedProject.fromJson(String json) =>
      SavedProject.fromMap(Map<String, dynamic>.from(jsonDecode(json)));
}
