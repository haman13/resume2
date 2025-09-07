// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';

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
          title: 'معرفی',
          initiallyExpanded: true,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            children: [
              Text(
                'من یه تازه کار حوزه فلاتر و علاقه مند به یادگیری تکنولوژی های جدید و حل مسائل پیچیده هستم.',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.2)),
              Text(
                'علاقه خاصی به بازی و ریاضی و حل سوالات مفهومی و ریاضی دارم',
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
          title: 'تحصیلات',
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'دوران مدرک تحصیلی تموم شده الان باید ببینی چی بلدی و در چه مرحله ای هستی.',
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary(context),
                ),
              ),
              SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.2)),
              Text(
                'اما صرفا جهت ثبت کارشناسی الکترونیک دارم اما الان دارم کد نویسی میکنم و میخوام همین مسیر رو ادامه بدم',
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
          title: 'MITB test',
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'وظیفه شناس، قاطع و منطقی، مفهوم گرا،تحلیل گر،فعال، پر انرژی، مطمئن،تشخیص منطقی نقاط ضعف و اشکالات، برنامه ریز،استدلال کننده،بیانگر،صریح،هدف گرا،منصف،حلال مسائل، منتقد',
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

