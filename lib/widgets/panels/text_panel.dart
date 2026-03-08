import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_constants.dart';
import '../../providers/editor_provider.dart';
import '../../models/poster_style.dart';
import '../common/helpers.dart';

class TextPanel extends StatefulWidget {
  const TextPanel({super.key});

  @override
  State<TextPanel> createState() => _TextPanelState();
}

class _TextPanelState extends State<TextPanel>
    with SingleTickerProviderStateMixin {
  late TabController _tab;
  late TextEditingController _welcomeCtrl;
  late TextEditingController _bodyCtrl;
  late TextEditingController _footerCtrl;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 5, vsync: this);
    final s = context.read<EditorProvider>().style;
    _welcomeCtrl = TextEditingController(text: s.welcomeText);
    _bodyCtrl = TextEditingController(text: s.bodyText);
    _footerCtrl = TextEditingController(text: s.footerText);
  }

  @override
  void dispose() {
    _tab.dispose();
    _welcomeCtrl.dispose();
    _bodyCtrl.dispose();
    _footerCtrl.dispose();
    super.dispose();
  }

  void _upd(PosterStyle s) => context.read<EditorProvider>().updateStyle(s);

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<EditorProvider>();
    final s = prov.style;

    return Column(
      children: [
        // Font family selector
        Container(
          color: AppColors.panelSurface,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SLabel('Font Family (All Text)'),
              DropdownButtonFormField<String>(
                initialValue: AppConstants.fontFamilies.contains(prov.fontFamily)
                    ? prov.fontFamily
                    : 'Montserrat',
                dropdownColor: AppColors.panelSurface,
                style: const TextStyle(
                    color: AppColors.textPrimary, fontSize: 13),
                items: AppConstants.fontFamilies
                    .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) context.read<EditorProvider>().setFont(v);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
        // Sub-tabs
        TabBar(
          controller: _tab,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Welcome'),
            Tab(text: 'Name'),
            Tab(text: 'Position'),
            Tab(text: 'Body'),
            Tab(text: 'Footer'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tab,
            children: [
              // Welcome tab
              _scrollPad([
                const SLabel('Welcome Text'),
                TextField(
                  controller: _welcomeCtrl,
                  style: const TextStyle(
                      color: AppColors.textPrimary, fontSize: 13),
                  onChanged: (v) => _upd(s.copyWith(welcomeText: v)),
                  decoration:
                      const InputDecoration(hintText: 'Welcome to IEEE'),
                ),
                const SizedBox(height: 10),
                SliderRow(
                  label: 'Font Size',
                  value: s.welcomeStyle.fontSize,
                  min: 5,
                  max: 22,
                  onChanged: (v) => _upd(s.copyWith(
                      welcomeStyle: s.welcomeStyle.copyWith(fontSize: v))),
                ),
                SliderRow(
                  label: 'Letter Spacing',
                  value: s.welcomeStyle.letterSpacing,
                  min: 0,
                  max: 8,
                  onChanged: (v) => _upd(s.copyWith(
                      welcomeStyle: s.welcomeStyle.copyWith(letterSpacing: v))),
                ),
                WeightDropdown(
                  value: s.welcomeStyle.fontWeight,
                  onChanged: (v) => _upd(s.copyWith(
                      welcomeStyle: s.welcomeStyle.copyWith(fontWeight: v))),
                ),
                ColorSwatch2(
                  label: 'Color',
                  color: s.welcomeStyle.color,
                  onChanged: (c) => _upd(s.copyWith(
                      welcomeStyle: s.welcomeStyle.copyWith(color: c))),
                ),
              ]),
              // Name tab
              _scrollPad([
                SliderRow(
                  label: 'Font Size',
                  value: s.nameStyle.fontSize,
                  min: 12,
                  max: 36,
                  onChanged: (v) => _upd(s.copyWith(
                      nameStyle: s.nameStyle.copyWith(fontSize: v))),
                ),
                SliderRow(
                  label: 'Line Height',
                  value: s.nameStyle.lineHeight,
                  min: 0.9,
                  max: 2.0,
                  divisions: 110,
                  onChanged: (v) => _upd(s.copyWith(
                      nameStyle: s.nameStyle.copyWith(lineHeight: v))),
                ),
                WeightDropdown(
                  value: s.nameStyle.fontWeight,
                  onChanged: (v) => _upd(s.copyWith(
                      nameStyle: s.nameStyle.copyWith(fontWeight: v))),
                ),
                AlignDropdown(
                  value: s.nameStyle.align,
                  onChanged: (v) => _upd(s.copyWith(
                      nameStyle: s.nameStyle.copyWith(align: v))),
                ),
                ColorSwatch2(
                  label: 'Color',
                  color: s.nameStyle.color,
                  onChanged: (c) => _upd(s.copyWith(
                      nameStyle: s.nameStyle.copyWith(color: c))),
                ),
              ]),
              // Position tab
              _scrollPad([
                SliderRow(
                  label: 'Font Size',
                  value: s.positionStyle.fontSize,
                  min: 6,
                  max: 20,
                  onChanged: (v) => _upd(s.copyWith(
                      positionStyle: s.positionStyle.copyWith(fontSize: v))),
                ),
                SliderRow(
                  label: 'Letter Spacing',
                  value: s.positionStyle.letterSpacing,
                  min: 0,
                  max: 6,
                  onChanged: (v) => _upd(s.copyWith(
                      positionStyle:
                          s.positionStyle.copyWith(letterSpacing: v))),
                ),
                WeightDropdown(
                  value: s.positionStyle.fontWeight,
                  onChanged: (v) => _upd(s.copyWith(
                      positionStyle: s.positionStyle.copyWith(fontWeight: v))),
                ),
                ColorSwatch2(
                  label: 'Color',
                  color: s.positionStyle.color,
                  onChanged: (c) => _upd(s.copyWith(
                      positionStyle: s.positionStyle.copyWith(color: c))),
                ),
              ]),
              // Body tab
              _scrollPad([
                const SLabel('Body Text (blank = auto)'),
                TextField(
                  controller: _bodyCtrl,
                  style: const TextStyle(
                      color: AppColors.textPrimary, fontSize: 13),
                  maxLines: 4,
                  onChanged: (v) => _upd(s.copyWith(bodyText: v)),
                  decoration: const InputDecoration(
                      hintText: 'Leave blank for auto-generated body text'),
                ),
                const SizedBox(height: 10),
                SliderRow(
                  label: 'Font Size',
                  value: s.bodyStyle.fontSize,
                  min: 6,
                  max: 16,
                  onChanged: (v) => _upd(s.copyWith(
                      bodyStyle: s.bodyStyle.copyWith(fontSize: v))),
                ),
                SliderRow(
                  label: 'Line Height',
                  value: s.bodyStyle.lineHeight,
                  min: 1.0,
                  max: 2.0,
                  onChanged: (v) => _upd(s.copyWith(
                      bodyStyle: s.bodyStyle.copyWith(lineHeight: v))),
                ),
                WeightDropdown(
                  value: s.bodyStyle.fontWeight,
                  onChanged: (v) => _upd(s.copyWith(
                      bodyStyle: s.bodyStyle.copyWith(fontWeight: v))),
                ),
                ColorSwatch2(
                  label: 'Color',
                  color: s.bodyStyle.color,
                  onChanged: (c) => _upd(s.copyWith(
                      bodyStyle: s.bodyStyle.copyWith(color: c))),
                ),
              ]),
              // Footer tab
              _scrollPad([
                const SLabel('Footer Text'),
                TextField(
                  controller: _footerCtrl,
                  style: const TextStyle(
                      color: AppColors.textPrimary, fontSize: 13),
                  onChanged: (v) => _upd(s.copyWith(footerText: v)),
                  decoration: const InputDecoration(
                      hintText: 'IEEE Student Chapter • Inspiring Innovation'),
                ),
                const SizedBox(height: 10),
                SliderRow(
                  label: 'Font Size',
                  value: s.footerFontSize,
                  min: 5,
                  max: 14,
                  onChanged: (v) => _upd(s.copyWith(footerFontSize: v)),
                ),
                ColorSwatch2(
                  label: 'Footer Color',
                  color: s.footerColor,
                  onChanged: (c) => _upd(s.copyWith(footerColor: c)),
                ),
              ]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _scrollPad(List<Widget> children) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}
