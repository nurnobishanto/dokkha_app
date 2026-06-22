import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialLinksScreen extends StatelessWidget {
  const SocialLinksScreen({super.key});

  void _launchURL(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  static const List<Map<String, dynamic>> socialLinks = [
    {
      'icon': Icons.facebook,
      'color': const Color(0xFF1877F2),
      'url': 'https://www.facebook.com/lokkhabd',
      'title': 'Facebook Page',
    },
    {
      'icon': Icons.groups,
      'color': const Color(0xFF1877F2),
      'url': 'https://www.facebook.com/groups/lokkha',
      'title': 'Facebook Group',
    },
    {
      'icon': Icons.play_circle_fill,
      'color': Colors.red,
      'url': 'https://www.youtube.com/@lokkhabd',
      'title': 'YouTube Channel',
    },
    {
      'icon': Icons.chat,
      'color': const Color(0xFF25D366),
      'url': 'https://wa.me/8801332804290',
      'title': 'WhatsApp',
    },
    {
      'icon': Icons.alternate_email,
      'color': Colors.black,
      'url': 'https://twitter.com/lokkhabd',
      'title': 'X (Twitter)',
    },
    {
      'icon': Icons.business,
      'color': const Color(0xFF0A66C2),
      'url': 'https://www.linkedin.com/in/lokkho-job-preparation-92b745362/',
      'title': 'LinkedIn',
    },
    {
      'icon': Icons.camera_alt,
      'color': const Color(0xFFE1306C),
      'url': 'https://www.instagram.com/lokkhabd',
      'title': 'Instagram',
    },
    {
      'icon': Icons.email,
      'color': Colors.grey,
      'url': 'mailto:info.lokkha@gmail.com',
      'title': 'Email',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: socialLinks.length,
      itemBuilder: (context, index) {
        final link = socialLinks[index];
        return InkWell(
          onTap: () => _launchURL(link['url']),
          borderRadius: BorderRadius.circular(12),
          child: CircleAvatar(
            backgroundColor: link['color'],
            radius: 22,
            child: Icon(
              link['icon'],
              color: Colors.white,
              size: 18,
            ),
          ),
        );
      },
    );
  }
}
