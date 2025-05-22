// link_button.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkButton extends StatelessWidget {
  final String url;
  // final String buttonText;

  const LinkButton({
    super.key,
    required this.url,
    // required this.buttonText,
  });

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _launchURL,
      child: Text('Click on the Screen.'),
    );
  }
}
