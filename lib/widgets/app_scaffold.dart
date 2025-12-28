import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:business_card/utils/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Color backgroundColor;
  final Brightness statusBarIconBrightness;
  final Color navigationBarColor;
  final Brightness navigationBarIconBrightness;

  const AppScaffold({
    super.key,
    required this.body,
    this.backgroundColor = AppColors.background,
    this.statusBarIconBrightness = Brightness.light,
    this.navigationBarColor = AppColors.background,
    this.navigationBarIconBrightness = Brightness.dark,
  });

  @override
  Widget build(BuildContext context) {
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: statusBarIconBrightness,
        statusBarBrightness: statusBarIconBrightness == Brightness.light ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: navigationBarIconBrightness,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Column(
            children: [
              Expanded(child: body),

              ColoredBox(
                color: navigationBarColor,
                child: SizedBox(height: navigationBarHeight, width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
