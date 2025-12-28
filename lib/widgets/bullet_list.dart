import 'package:flutter/material.dart';
import 'package:business_card/utils/app_text_styles.dart';
import 'package:business_card/utils/app_colors.dart';

class BulletList extends StatelessWidget {
  final List<String> items;
  final bool horizontal;

  const BulletList(this.items, {super.key, this.horizontal = false});

  @override
  Widget build(BuildContext context) {
    return horizontal
        ? Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 16,
            runSpacing: 8,
            children: items.map((item) => _buildBulletItem(item)).toList(),
          )
        : Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items.map((item) => _buildBulletItem(item)).toList(),
          );
  }

  Widget _buildBulletItem(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const ClipOval(
          child: ColoredBox(color: AppColors.primary, child: SizedBox(width: 4, height: 4)),
        ),
        const SizedBox(width: 4),
        Text(text, style: AppTextStyles.text),
      ],
    );
  }
}
