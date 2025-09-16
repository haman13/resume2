import 'package:flutter/material.dart';
import 'package:resume/utils/responsive_helper.dart';
import '../theme.dart';

class ExperienceItem extends StatelessWidget {
  final String role;
  final String company;
  final String duration;
  final String description;
  final List<String> achievements;

  const ExperienceItem({
    super.key,
    required this.role,
    required this.company,
    required this.duration,
    required this.description,
    this.achievements = const [],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getProportionateFontSize(1.2),
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    company,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getProportionateFontSize(1.2),
                      color: AppTheme.textGrey(context),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              duration,
              style: TextStyle(
                color: AppTheme.textGrey(context),
                fontSize: ResponsiveHelper.getProportionateFontSize(1.2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            color: AppTheme.textPrimary(context),
            fontSize: ResponsiveHelper.getProportionateFontSize(1.2),
          ),
        ),
        if (achievements.isNotEmpty) ...[
          const SizedBox(height: 8),
          ...achievements.map((achievement) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(
                        color: AppTheme.textPrimary(context),
                        fontSize: 14,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        achievement,
                        style: TextStyle(
                          color: AppTheme.textPrimary(context),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ],
    );
  }
}
