import 'package:flutter/material.dart';
import 'package:business_card/utils/app_colors.dart';

class TextCard extends StatelessWidget {
  final Widget child;

  const TextCard(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(color: AppColors.cardBackground, borderRadius: BorderRadius.circular(10)),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), child: child),
      ),
    );
  }
}
