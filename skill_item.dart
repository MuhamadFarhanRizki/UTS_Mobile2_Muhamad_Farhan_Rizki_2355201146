import 'package:flutter/material.dart';

class SkillItem extends StatefulWidget {
  final String skill;
  final VoidCallback? onTap;
  const SkillItem({super.key, required this.skill, this.onTap});

  @override
  State<SkillItem> createState() => _SkillItemState();
}

class _SkillItemState extends State<SkillItem> {
  double _scale = 1.0;

  void _doTap() async {
    setState(() => _scale = 0.88);
    await Future.delayed(const Duration(milliseconds: 120));
    setState(() => _scale = 1.0);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: _doTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: cs.primary.withOpacity(0.08),
            border: Border.all(color: cs.primary.withOpacity(0.18)),
          ),
          child: Text(widget.skill,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}
