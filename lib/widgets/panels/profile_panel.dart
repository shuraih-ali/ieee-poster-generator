import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/editor_provider.dart';
import '../common/helpers.dart';

class ProfilePanel extends StatefulWidget {
  const ProfilePanel({super.key});

  @override
  State<ProfilePanel> createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> {
  late TextEditingController _nameCtrl;
  late TextEditingController _chapterCtrl;
  late TextEditingController _universityCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _linkedinCtrl;
  late TextEditingController _githubCtrl;
  late TextEditingController _memberIdCtrl;
  late TextEditingController _logoTextCtrl;

  @override
  void initState() {
    super.initState();
    final p = context.read<EditorProvider>().profile;
    _nameCtrl = TextEditingController(text: p.fullName);
    _chapterCtrl = TextEditingController(text: p.chapterName);
    _universityCtrl = TextEditingController(text: p.university);
    _emailCtrl = TextEditingController(text: p.email);
    _linkedinCtrl = TextEditingController(text: p.linkedin);
    _githubCtrl = TextEditingController(text: p.github);
    _memberIdCtrl = TextEditingController(text: p.membershipId);
    _logoTextCtrl = TextEditingController(text: p.logoText);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _chapterCtrl.dispose();
    _universityCtrl.dispose();
    _emailCtrl.dispose();
    _linkedinCtrl.dispose();
    _githubCtrl.dispose();
    _memberIdCtrl.dispose();
    _logoTextCtrl.dispose();
    super.dispose();
  }

  void _update() {
    final prov = context.read<EditorProvider>();
    prov.updateProfile(prov.profile.copyWith(
      fullName: _nameCtrl.text,
      chapterName: _chapterCtrl.text,
      university: _universityCtrl.text,
      email: _emailCtrl.text,
      linkedin: _linkedinCtrl.text,
      github: _githubCtrl.text,
      membershipId: _memberIdCtrl.text,
      logoText: _logoTextCtrl.text,
    ));
  }

  Widget _field(String label, TextEditingController ctrl,
      {String? hint, int maxLines = 1, TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SLabel(label),
        TextField(
          controller: ctrl,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(
              color: AppColors.textPrimary, fontSize: 13),
          decoration: InputDecoration(hintText: hint),
          onChanged: (_) => _update(),
        ),
        const SizedBox(height: 10),
      ],
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
          PanelSection(title: 'Personal Info', children: [
            _field('Full Name', _nameCtrl, hint: 'Member Name'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SLabel('IEEE Position'),
                DropdownButtonFormField<String>(
                  initialValue: AppConstants.ieeePositions
                          .contains(prov.profile.position)
                      ? prov.profile.position
                      : AppConstants.ieeePositions.first,
                  dropdownColor: AppColors.panelSurface,
                  style: const TextStyle(
                      color: AppColors.textPrimary, fontSize: 13),
                  items: AppConstants.ieeePositions
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) {
                      context
                          .read<EditorProvider>()
                          .updateProfile(prov.profile.copyWith(position: v));
                    }
                  },
                ),
                const SizedBox(height: 10),
              ],
            ),
            _field('Chapter Name', _chapterCtrl,
                hint: 'IEEE Student Chapter'),
            _field('University', _universityCtrl, hint: 'University Name'),
          ]),
          PanelSection(title: 'Contact & Social', children: [
            _field('Email', _emailCtrl,
                hint: 'member@ieee.org',
                keyboardType: TextInputType.emailAddress),
            _field('LinkedIn URL', _linkedinCtrl,
                hint: 'linkedin.com/in/username'),
            _field('GitHub URL', _githubCtrl, hint: 'github.com/username'),
          ]),
          PanelSection(title: 'IEEE Identity', children: [
            _field('IEEE Member ID (optional)', _memberIdCtrl,
                hint: '12345678',
                keyboardType: TextInputType.number),
            _field('Logo Text', _logoTextCtrl, hint: 'IEEE'),
          ]),
        ],
      ),
    );
  }
}
