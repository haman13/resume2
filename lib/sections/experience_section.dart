import 'package:flutter/material.dart';
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
          title: ' تجربیات شغلی پیش از آشنایی با برنامه نویسی',
          initiallyExpanded: false,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: Column(
            children: [
              const ExperienceItem(
                role: 'بازایاب بیمه عمر',
                company: 'شرکت بیمه پاسارگاد',
                duration: '1390 - 1392',
                description: 'مشاوره و فروش بیمه عمر به افراد و سازمانها ',
                achievements: [
                  'فروش حدود 400 بیمه عمر به افراد مختلف ',
                ],
              ),
              Divider(height: ResponsiveHelper.getProportionateSpacing(3.2)),
              const ExperienceItem(
                role: 'بازاریاب شرکت های نتورک مارکتینگ و شبکه ای',
                company: 'شرکت های بادران و بیز',
                duration: '1392 - 1396',
                description: 'مشاوره و معرفی محصولات و پلن درآمد زایی شرکت برای بازاریابان جدید',
                achievements: [
                  'ایجاد شبکه ی فروش بالای 7 هزار نفری',
                ],
              ),
              Divider(height: ResponsiveHelper.getProportionateSpacing(3.2)),
              const ExperienceItem(
                role: 'کارشناس فروش امور سازمانی و دولتی',
                company: '(کندو SMS)شرکت فرهنگ و توسعه کندو',
                duration: '1396 - اکنون',
                description: 'فروش سیستم های پیامکی به شرکتها و سازمانهای دولتی',
                achievements: [
                  'همکاری با بیش از 20 شرکت دولتی آب و برق و گاز در زمینه ارسال پیامک قبوض',
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.0)),
        ExpandableCard(
          title: ' تجربیات شغلی در زمینه برنامه نویسی',
          initiallyExpanded: true,
          backgroundColor: AppTheme.greenCardBackground(context),
          child: const Column(
            children: [
              ExperienceItem(
                role: 'تازه کار حوزه برنامه نویسی',
                company: 'آزاد کار میکنم',
                duration: '1403 - اکنون',
                description: 'توسعه و نگهداری اپلیکیشن‌های موبایل و وب',
                achievements: [
                  'نمونه کد هام توی قسمت پروژه ها هست',
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
