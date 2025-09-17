import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/expandable_card.dart';
import '../utils/responsive_helper.dart';
import '../theme.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = {
      AppLocalizations.of(context).skillsCoreTitle: [
        'Flutter', 'Dart', 'Git',
        'REST API', 'Supabase',
      ],
      AppLocalizations.of(context).skillsFrameworksTitle: [
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // NOTE(desktop): فاصله عنوان کارت مهارت تا محتوا در دسکتاپ نهایی شده
                  SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.0)),
                  Wrap(
                    spacing: ResponsiveHelper.getProportionateSpacing(0.8),
                    runSpacing: ResponsiveHelper.getProportionateSpacing(0.8),
                    children: entry.value.map((skill) {
                      // NOTE(desktop): نسبت فونت چیپ مهارت‌ها در دسکتاپ نهایی شده
                      return Chip(
                        label: Text(
                          skill,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getProportionateFontSize(1.2),
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
                ],
              ),
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.0)),
          ],
        );
      }).toList(),
    );
  }
}
