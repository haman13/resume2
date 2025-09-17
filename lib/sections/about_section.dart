// ignore_for_file: prefer_final_fields, unused_field, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/expandable_card.dart';
import '../utils/responsive_helper.dart';
import '../theme.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  @override
  Widget build(BuildContext context) {
    final bool _isMobile = ResponsiveHelper.isMobile(context);
    final double _screenWidth = MediaQuery.of(context).size.width;
    // عنوان کارت توسط خود ExpandableCard تنظیم می‌شود
    final double _normalFontSize = _screenWidth * 0.030;   // متن کارت
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandableCard(
          title: AppLocalizations.of(context).aboutIntroTitle,
          initiallyExpanded: true,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            children: [
              // NOTE(desktop): نسبت فونت کارت معرفی در دسکتاپ نهایی شده
              Text(
                AppLocalizations.of(context).aboutIntroP1,
                style: TextStyle(
                  fontSize: _isMobile ? _normalFontSize : ResponsiveHelper.getProportionateFontSize(1.2),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.2)),
              // NOTE(desktop): نسبت فونت کارت معرفی در دسکتاپ نهایی شده
              Text(
                AppLocalizations.of(context).aboutIntroP2,
                style: TextStyle(
                  fontSize: _isMobile ? _normalFontSize : ResponsiveHelper.getProportionateFontSize(1.2),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.4)),
        ExpandableCard(
          title: AppLocalizations.of(context).aboutEducationTitle,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NOTE(desktop): نسبت فونت کارت تحصیلات در دسکتاپ نهایی شده
              Text(
                AppLocalizations.of(context).aboutEducationP1,
                style: TextStyle(
                  fontSize: _isMobile ? _normalFontSize : ResponsiveHelper.getProportionateFontSize(1.2),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.2)),
              // NOTE(desktop): نسبت فونت کارت تحصیلات در دسکتاپ نهایی شده
              Text(
                AppLocalizations.of(context).aboutEducationP2,
                style: TextStyle(
                  fontSize: _isMobile ? _normalFontSize : ResponsiveHelper.getProportionateFontSize(1.2),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.4)),
        ExpandableCard(
          title: AppLocalizations.of(context).aboutMitbTitle,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NOTE(desktop): نسبت فونت کارت MITB در دسکتاپ نهایی شده
              Text(
                AppLocalizations.of(context).aboutMitbP1,
                style: TextStyle(
                  fontSize: _isMobile ? _normalFontSize : ResponsiveHelper.getProportionateFontSize(1.2),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.2)),
              
            ],
          ),
        ),
      ],
    );
  }
}

