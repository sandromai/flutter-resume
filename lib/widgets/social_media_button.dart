import 'package:business_card/models/social_media.dart';
import 'package:flutter/material.dart';
import 'package:business_card/utils/app_colors.dart';
import 'package:business_card/utils/link_helper.dart';

class SocialMediaButton extends StatefulWidget {
  final SocialMedia socialMedia;

  const SocialMediaButton({super.key, required this.socialMedia});

  @override
  State<SocialMediaButton> createState() => _SocialMediaButtonState();
}

class _SocialMediaButtonState extends State<SocialMediaButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: () =>
          LinkHelper.launchNativeUrl(nativeUrl: widget.socialMedia.url, webUrl: widget.socialMedia.webUrl),

      child: AnimatedScale(
        scale: _isPressed ? .9 : 1,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        child: AnimatedOpacity(
          opacity: _isPressed ? .5 : 1,
          duration: const Duration(milliseconds: 200),
          child: SizedBox.square(
            dimension: 32,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .06),
                    blurRadius: 4,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Center(child: Icon(widget.socialMedia.icon, size: 24, color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}
