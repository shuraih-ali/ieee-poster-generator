import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../core/constants/app_colors.dart';

// ── SLabel ────────────────────────────────────────────────────────────────────
class SLabel extends StatelessWidget {
  final String text;
  const SLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ── SliderRow ─────────────────────────────────────────────────────────────────
class SliderRow extends StatelessWidget {
  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;
  final String Function(double)? format;

  const SliderRow({
    super.key,
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    this.divisions = 100,
    required this.onChanged,
    this.format,
  });

  @override
  Widget build(BuildContext context) {
    final displayVal = format != null
        ? format!(value)
        : value.toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SLabel(label),
            Text(displayVal,
                style: const TextStyle(
                    fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
        SizedBox(
          height: 32,
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

// ── ColorSwatch2 ──────────────────────────────────────────────────────────────
class ColorSwatch2 extends StatelessWidget {
  final String label;
  final Color color;
  final ValueChanged<Color> onChanged;

  const ColorSwatch2({
    super.key,
    required this.label,
    required this.color,
    required this.onChanged,
  });

  void _open(BuildContext context) {
    Color current = color;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.panelSurface,
        title: Text(label,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 14)),
        content: SingleChildScrollView(
          child: HueRingPicker(
            pickerColor: current,
            onColorChanged: (c) => current = c,
            enableAlpha: false,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () {
              onChanged(current);
              Navigator.pop(context);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SLabel(label),
        GestureDetector(
          onTap: () => _open(context),
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: AppColors.textMuted.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                Text(
                  '#${color.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                  style: TextStyle(
                    fontSize: 12,
                    color: color.computeLuminance() > 0.4
                        ? Colors.black87
                        : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Icon(Icons.colorize_rounded,
                    color: color.computeLuminance() > 0.4
                        ? Colors.black54
                        : Colors.white70,
                    size: 16),
                const SizedBox(width: 8),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// ── WeightDropdown ────────────────────────────────────────────────────────────
class WeightDropdown extends StatelessWidget {
  final FontWeight value;
  final ValueChanged<FontWeight> onChanged;

  const WeightDropdown(
      {super.key, required this.value, required this.onChanged});

  static const _items = <FontWeight>[
    FontWeight.w300,
    FontWeight.w400,
    FontWeight.w500,
    FontWeight.w600,
    FontWeight.w700,
    FontWeight.w800,
    FontWeight.w900,
  ];

  static final _labels = {
    FontWeight.w300: 'Light 300',
    FontWeight.w400: 'Regular 400',
    FontWeight.w500: 'Medium 500',
    FontWeight.w600: 'SemiBold 600',
    FontWeight.w700: 'Bold 700',
    FontWeight.w800: 'ExtraBold 800',
    FontWeight.w900: 'Black 900',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SLabel('Font Weight'),
        DropdownButtonFormField<FontWeight>(
          initialValue: value,
          dropdownColor: AppColors.panelSurface,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
          items: _items.map((w) {
            return DropdownMenuItem(
              value: w,
              child: Text(_labels[w]!),
            );
          }).toList(),
          onChanged: (v) => v != null ? onChanged(v) : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// ── AlignDropdown ─────────────────────────────────────────────────────────────
class AlignDropdown extends StatelessWidget {
  final TextAlign value;
  final ValueChanged<TextAlign> onChanged;

  const AlignDropdown(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SLabel('Alignment'),
        DropdownButtonFormField<TextAlign>(
          initialValue: value,
          dropdownColor: AppColors.panelSurface,
          style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
          items: const [
            DropdownMenuItem(value: TextAlign.left, child: Text('Left')),
            DropdownMenuItem(value: TextAlign.center, child: Text('Center')),
            DropdownMenuItem(value: TextAlign.right, child: Text('Right')),
          ],
          onChanged: (v) => v != null ? onChanged(v) : null,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

// ── Section heading ───────────────────────────────────────────────────────────
class PanelSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const PanelSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            fontSize: 10,
            color: AppColors.textMuted,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 6),
        Divider(
            color: AppColors.primary.withValues(alpha: 0.3), height: 1),
        const SizedBox(height: 8),
        ...children,
      ],
    );
  }
}
