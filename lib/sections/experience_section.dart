import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/expandable_card.dart';
import '../widgets/experience_item.dart';
import '../utils/responsive_helper.dart';
import '../theme.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpandableCard(
          title: AppLocalizations.of(context).expPrevTitle,
          initiallyExpanded: false,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            children: [
              ExperienceItem(
                role: AppLocalizations.of(context).expPrevItem1Role,
                company: AppLocalizations.of(context).expPrevItem1Company,
                duration: AppLocalizations.of(context).expPrevItem1Duration,
                description: AppLocalizations.of(context).expPrevItem1Desc,
                achievements: [
                  AppLocalizations.of(context).expPrevItem1Ach1,
                ],
              ),
              Divider(height: ResponsiveHelper.getProportionateSpacing(3.2)),
              ExperienceItem(
                role: AppLocalizations.of(context).expPrevItem2Role,
                company: AppLocalizations.of(context).expPrevItem2Company,
                duration: AppLocalizations.of(context).expPrevItem2Duration,
                description: AppLocalizations.of(context).expPrevItem2Desc,
                achievements: [
                  AppLocalizations.of(context).expPrevItem2Ach1,
                ],
              ),
              Divider(height: ResponsiveHelper.getProportionateSpacing(3.2)),
              ExperienceItem(
                role: AppLocalizations.of(context).expPrevItem3Role,
                company: AppLocalizations.of(context).expPrevItem3Company,
                duration: AppLocalizations.of(context).expPrevItem3Duration,
                description: AppLocalizations.of(context).expPrevItem3Desc,
                achievements: [
                  AppLocalizations.of(context).expPrevItem3Ach1,
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.0)),
        ExpandableCard(
          title: AppLocalizations.of(context).expCurrTitle,
          initiallyExpanded: true,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            children: [
              ExperienceItem(
                role: AppLocalizations.of(context).expCurrItem1Role,
                company: AppLocalizations.of(context).expCurrItem1Company,
                duration: AppLocalizations.of(context).expCurrItem1Duration,
                description: AppLocalizations.of(context).expCurrItem1Desc,
                achievements: [
                  AppLocalizations.of(context).expCurrItem1Ach1,
                ],
              ),
              // Divider(height: ResponsiveHelper.getProportionateSpacing(3.2)),
              // ExperienceItem(
              //   role: 'توسعه‌دهنده فلاتر',
              //   company: 'شرکت ب',
              //   duration: '۱۳۹۹ - ۱۴۰۱',
              //   description: 'همکاری در پروژه‌های مختلف موبایل',
              //   achievements: [
              //     'توسعه ۳ اپلیکیشن موفق با بیش از ۱۰۰۰۰ کاربر',
              //     'پیاده‌سازی رابط کاربری پیشرفته و انیمیشن',
              //   ],
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
