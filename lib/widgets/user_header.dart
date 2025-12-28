import 'package:business_card/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:business_card/utils/app_colors.dart';
import 'dart:ui';

class UserHeader extends SliverPersistentHeaderDelegate {
  static const double coverHeight = 56;
  static const double avatarExpandedSize = 80;
  static const double avatarCollapsedSize = 40;
  static const double coverPaddingBottom = 8;
  static const double avatarNameSpacing = 8;
  static const double avatarLeftPadding = 8;

  final String name;
  final String avatar;
  final double statusBarHeight;
  final (double, double) nameTextDimensions;

  UserHeader({required this.name, required this.avatar, required this.statusBarHeight})
    : nameTextDimensions = _getTextDimensions(name, AppTextStyles.h1);

  @override
  double get minExtent => statusBarHeight + coverHeight;

  @override
  double get maxExtent => statusBarHeight + (coverHeight * 2) + coverPaddingBottom + nameTextDimensions.$2;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final double centerX = MediaQuery.of(context).size.width / 2;
    final double linearPercent = (shrinkOffset / (maxExtent - minExtent)).clamp(0, 1);
    final double easeOutPercent = Curves.easeOutCubic.transform(linearPercent);
    final double easeInPercent = Curves.easeInCubic.transform(linearPercent);

    final double avatarSize = lerpDouble(avatarExpandedSize, avatarCollapsedSize, easeOutPercent)!;

    final double fontSize = lerpDouble(
      AppTextStyles.h1.fontSize,
      AppTextStyles.h1.fontSize! / 1.5,
      easeInPercent,
    )!;

    final TextStyle nameStyle = AppTextStyles.h1.copyWith(
      fontSize: fontSize,
      color: Color.lerp(AppColors.textMain, Colors.white, easeInPercent),
    );

    final double nameHeight = _getTextDimensions(name, nameStyle).$2;

    return Stack(
      children: [
        Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .12),
                    blurRadius: 8,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: SizedBox(width: double.infinity, height: coverHeight + statusBarHeight),
            ),
            ColoredBox(
              color: Colors.transparent,
              child: SizedBox(
                width: double.infinity,
                height: lerpDouble(coverHeight + coverPaddingBottom, 0, linearPercent),
              ),
            ),
          ],
        ),

        Positioned(
          left: lerpDouble(centerX - (avatarSize / 2), avatarLeftPadding, easeOutPercent),
          top: lerpDouble(
            (coverHeight + statusBarHeight) - (avatarSize / 2),
            ((coverHeight - avatarSize) / 2) + statusBarHeight,
            easeOutPercent,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: .12),
                  blurRadius: 8,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: CircleAvatar(radius: avatarSize / 2, backgroundImage: AssetImage(avatar)),
          ),
        ),

        Positioned(
          left: lerpDouble(
            centerX - (nameTextDimensions.$1 / 2),
            avatarSize + avatarLeftPadding + avatarNameSpacing,
            easeInPercent,
          ),
          top: lerpDouble(
            (coverHeight * 2) + statusBarHeight,
            ((coverHeight - nameHeight) / 2) + statusBarHeight,
            easeOutPercent,
          ),
          child: Text(name, style: nameStyle),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => true;

  static (double, double) _getTextDimensions(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();

    return (textPainter.size.width, textPainter.size.height);
  }
}
