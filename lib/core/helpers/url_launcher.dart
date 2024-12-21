part of 'helpers.dart';

class UrlLauncher {
  final String url;

  const UrlLauncher(this.url);

  // Attempt to open the link inside the app.
  Future<void> openInternally() async {
    final uri = _removeSpaces();
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppWebView);
    }
  }

  // Attempt to open the link outside of the app.
  Future<void> openExternally() async {
    final uri = _removeSpaces();
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Uri _removeSpaces() {
    var cleanedUrl = url.replaceAll(RegExp('\\s+'), '');
    return Uri.parse(cleanedUrl);
  }
}
