import 'package:flutter/material.dart';

class InstructorCard extends StatelessWidget {
  final String name;
  final String? tagline;
  final String imageUrl;
  final String? experience;

  const InstructorCard({
    super.key,
    required this.name,
    required this.imageUrl,
    this.tagline,
    this.experience,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
               ( imageUrl.isNotEmpty || imageUrl == null)
                    ? imageUrl
                    : 'https://api.dicebear.com/6.x/initials/svg?seed=$name}',
              ),
            ),

            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (tagline != null && tagline!.isNotEmpty)
                    Text(
                      tagline!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  if (experience != null && experience!.isNotEmpty)
                    Text(
                      experience!,
                      style: textTheme.bodySmall?.copyWith(
                        color: Colors.blueGrey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

