import 'package:flutter/material.dart';
import '../widgets/expandable_card.dart';
import '../utils/responsive_helper.dart';
import '../theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = {
      'مهارت‌های اصلی': [
        'Flutter', 'Dart', 'Git',
        'REST API', 'Supabase',
      ],
      'فریم‌ورک‌ها و کتابخانه‌ها': [
        'GetX', 'Provider', 'Bloc',
        'Dio', 'Hive',
      ],
      // 'آشنایی با': [
      //   'Clean Architecture', 'SOLID',
      //   'Unit Testing', 'CI/CD',
      // ],
    };

    return Column(
      children: skills.entries.map((entry) {
        return Column(
          children: [
            ExpandableCard(
              title: entry.key,
              backgroundColor: AppTheme.greenCardBackground(context),
              child: Wrap(
                spacing: ResponsiveHelper.getProportionateSpacing(0.8),
                runSpacing: ResponsiveHelper.getProportionateSpacing(0.8),
                children: entry.value.map((skill) {
                  return Chip(
                    label: Text(
                      skill,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getProportionateFontSize(1.4),
                        color: AppTheme.textPrimary(context),
                      ),
                    ),
                    backgroundColor: AppTheme.chipBackground(context),
                    padding: ResponsiveHelper.getProportionatePadding(
                      horizontal: 0.8,
                      vertical: 0.4,
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.0)),
          ],
        );
      }).toList(),
    );
  }
}
