import 'package:kobo_kobo/core/core.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHandler {
  static Future<void> launchUrlHandler(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch');
    }
  }

  static Future<void> launchEmailHandler(MailModel mail) async {
    final emailLaunchUri = Uri(
      scheme: 'mailto',
      path: mail.email,
      query: mail.toEmailString(),
    );

    await launchUrl(emailLaunchUri);
  }
}
