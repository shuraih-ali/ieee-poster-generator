class MemberProfile {
  final String fullName;
  final String position;
  final String chapterName;
  final String university;
  final String email;
  final String linkedin;
  final String github;
  final String membershipId;
  final String? photoPath;
  final String logoText;

  const MemberProfile({
    this.fullName = 'Member Name',
    this.position = 'Chairperson',
    this.chapterName = 'IEEE Student Chapter',
    this.university = 'University Name',
    this.email = 'member@ieee.org',
    this.linkedin = 'linkedin.com/in/member',
    this.github = 'github.com/member',
    this.membershipId = '',
    this.photoPath,
    this.logoText = 'IEEE',
  });

  MemberProfile copyWith({
    String? fullName,
    String? position,
    String? chapterName,
    String? university,
    String? email,
    String? linkedin,
    String? github,
    String? membershipId,
    String? photoPath,
    bool clearPhoto = false,
    String? logoText,
  }) =>
      MemberProfile(
        fullName: fullName ?? this.fullName,
        position: position ?? this.position,
        chapterName: chapterName ?? this.chapterName,
        university: university ?? this.university,
        email: email ?? this.email,
        linkedin: linkedin ?? this.linkedin,
        github: github ?? this.github,
        membershipId: membershipId ?? this.membershipId,
        photoPath: clearPhoto ? null : (photoPath ?? this.photoPath),
        logoText: logoText ?? this.logoText,
      );

  Map<String, dynamic> toMap() => {
        'fullName': fullName,
        'position': position,
        'chapterName': chapterName,
        'university': university,
        'email': email,
        'linkedin': linkedin,
        'github': github,
        'membershipId': membershipId,
        'photoPath': photoPath,
        'logoText': logoText,
      };

  factory MemberProfile.fromMap(Map<String, dynamic> m) => MemberProfile(
        fullName: m['fullName'] as String? ?? 'Member Name',
        position: m['position'] as String? ?? 'Chairperson',
        chapterName: m['chapterName'] as String? ?? 'IEEE Student Chapter',
        university: m['university'] as String? ?? 'University Name',
        email: m['email'] as String? ?? 'member@ieee.org',
        linkedin: m['linkedin'] as String? ?? 'linkedin.com/in/member',
        github: m['github'] as String? ?? 'github.com/member',
        membershipId: m['membershipId'] as String? ?? '',
        photoPath: m['photoPath'] as String?,
        logoText: m['logoText'] as String? ?? 'IEEE',
      );
}
