import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkHelper {
  static Future<void> launchNativeUrl({required String nativeUrl, String? webUrl}) async {
    try {
      final Uri nativeUri = Uri.parse(nativeUrl);

      if (await canLaunchUrl(nativeUri)) {
        await launchUrl(nativeUri, mode: LaunchMode.externalNonBrowserApplication);
      } else {
        await launchWebUrl(webUrl ?? nativeUrl);
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error launching URL: $e');
      }
    }
  }

  static Future<void> launchWebUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);

      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (kDebugMode) {
          debugPrint('Could not launch $url');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Error launching URL: $e');
      }
    }
  }
}
