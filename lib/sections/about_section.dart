// ignore_for_file: prefer_final_fields, unused_field

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ExpandableCard(
          title: AppLocalizations.of(context).aboutIntroTitle,
          initiallyExpanded: true,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context).aboutIntroP1,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.2)),
              Text(
                AppLocalizations.of(context).aboutIntroP2,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
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
              Text(
                AppLocalizations.of(context).aboutEducationP1,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.2)),
              Text(
                AppLocalizations.of(context).aboutEducationP2,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
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
              Text(
                AppLocalizations.of(context).aboutMitbP1,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
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

