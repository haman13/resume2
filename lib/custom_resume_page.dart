// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'utils/responsive_helper.dart';
import 'theme.dart';

class CustomResumePage extends StatefulWidget {
  final VoidCallback? onThemeToggle;
  final bool isDarkMode;
  
  const CustomResumePage({
    super.key,
    this.onThemeToggle,
    this.isDarkMode = false,
  });

  @override
  State<CustomResumePage> createState() => _CustomResumePageState();
}

class _CustomResumePageState extends State<CustomResumePage> {
  String _selectedSection = 'درباره من'; // پیش‌فرض انتخاب شده


  @override
  Widget build(BuildContext context) {
    // مقداردهی اولیه ResponsiveHelper
    ResponsiveHelper.init(context);
    
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ResponsiveHelper.isMobile(context) 
                    ? _buildMobileLayout()
                    : _buildDesktopLayout(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // لایه‌بندی موبایل (عمودی)
  Widget _buildMobileLayout() {
    return Column(
      children: [
        // منوی کناری موبایل (افقی)
        Container(
          color: Theme.of(context).cardColor,
          padding: ResponsiveHelper.getProportionatePadding(vertical: 1.5),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildMobileMenuItems(),
            ),
          ),
        ),
        // محتوای اصلی
        Expanded(
          child: SingleChildScrollView(
            padding: ResponsiveHelper.getProportionatePadding(
              horizontal: 3.0,
              vertical: 2.0,
            ),
            child: _buildMainContent(),
          ),
        ),
      ],
    );
  }

  // لایه‌بندی دسکتاپ و تبلت (افقی)
  Widget _buildDesktopLayout() {
    return Row(
      children: [
        // منوی کناری - سمت راست
        Expanded(
          flex: ResponsiveHelper.getSideMenuFlex(),
          child: Container(
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              padding: ResponsiveHelper.getProportionatePadding(vertical: 2.4),
              child: _buildSideMenu(),
            ),
          ),
        ),
        // محتوای اصلی - سمت چپ
        Expanded(
          flex: ResponsiveHelper.getMainContentFlex(),
          child: SingleChildScrollView(
            padding: ResponsiveHelper.getProportionatePadding(
              horizontal: 2.4,
              vertical: 2.4,
            ),
            child: _buildMainContent(),
          ),
        ),
      ],
    );
  }

  // آیتم‌های منوی موبایل
  List<Widget> _buildMobileMenuItems() {
    final menuItems = [
      'درباره من',
      'مهارت‌ها',
      'سوابق',
      'پروژه‌ها',
    ];

    return menuItems.map((item) => _buildMobileMenuItem(item)).toList();
  }

  Widget _buildMobileMenuItem(String title) {
    final isSelected = _selectedSection == title;
    
    return Container(
      margin: ResponsiveHelper.getProportionateMargin(horizontal: 1.0),
      child: isSelected 
        ? GestureDetector(
            onTap: () => _onMenuSelected(title),
            child: Container(
              padding: ResponsiveHelper.getProportionatePadding(
                horizontal: 2.0,
                vertical: 1.0,
              ),
              decoration: BoxDecoration(
                color: AppTheme.selectedContainer(context),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppTheme.radiusPill),
                  topRight: Radius.circular(AppTheme.radiusSmall),
                  bottomLeft: Radius.circular(AppTheme.radiusPill),
                  bottomRight: Radius.circular(AppTheme.radiusSmall),
                ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onMenuSelected(title),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
              child: Container(
                padding: ResponsiveHelper.getProportionatePadding(
                  horizontal: 2.0,
                  vertical: 1.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.87),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: AppTheme.headerBackground(context),
      padding: ResponsiveHelper.getProportionatePadding(
        horizontal: 2.4,
        vertical: 2.4,
      ),
      child: Stack(
        children: [
          // محتوای اصلی هدر
          ResponsiveHelper.isMobile(context)
              ? _buildMobileHeader()
              : _buildDesktopHeader(),
          // دکمه تغییر تم در گوشه بالا سمت چپ
          Positioned(
            top: 0,
            left: 0,
            child: _buildThemeToggleButton(),
          ),
        ],
      ),
    );
  }

  // دکمه تغییر تم
  Widget _buildThemeToggleButton() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: IconButton(
        onPressed: widget.onThemeToggle,
        icon: Icon(
          widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24,
        ),
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(8),
        ),
        tooltip: widget.isDarkMode ? 'تغییر به تم روشن' : 'تغییر به تم تاریک',
      ),
    );
  }

  // هدر موبایل (عمودی)
  Widget _buildMobileHeader() {
    return Column(
      children: [
        // عکس پروفایل
        Container(
          width: ResponsiveHelper.getProfileImageSize(),
          height: ResponsiveHelper.getProfileImageSize(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primaryContainer,
            image: const DecorationImage(
              image: AssetImage('assets/images/1752648209158.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.5)),
        // نام
        Text(
          'هامان درویش',
          style: TextStyle(
            fontSize: ResponsiveHelper.getProportionateFontSize(2.0),
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.0)),
        // دکمه‌های اتصال
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ConnectButton(
              icon: FontAwesomeIcons.github,
              label: 'اتصال به گیت‌هاب',
              color: AppTheme.githubForDarkTheme(context),
              onPressed: () async {
                final url = Uri.parse('https://github.com/haman13');
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                    webOnlyWindowName: '_blank',
                  );
                }
              },
            ),
            SizedBox(width: ResponsiveHelper.getProportionateSpacing(1.5)),
            _ConnectButton(
              icon: FontAwesomeIcons.linkedin,
              label: 'اتصال به لینکدین',
              color: AppTheme.linkedIn,
              onPressed: () async {
                final url = Uri.parse('https://www.linkedin.com/in/haman-darvish-6a489a25a/');
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                    webOnlyWindowName: '_blank',
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  // هدر دسکتاپ (افقی)
  Widget _buildDesktopHeader() {
    return Row(
      children: [
        // عکس پروفایل - سمت راست
        Column(
          children: [
            Container(
              width: ResponsiveHelper.getProfileImageSize(),
              height: ResponsiveHelper.getProfileImageSize(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
                image: const DecorationImage(
                  image: AssetImage('assets/images/1752648209158.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.0)),
            Text(
              'هامان درویش',
              style: TextStyle(
                fontSize: ResponsiveHelper.getProportionateFontSize(2.0),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        // دکمه‌های اتصال - سمت چپ
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _ConnectButton(
                icon: FontAwesomeIcons.github,
                label: 'اتصال به گیت‌هاب',
                color: AppTheme.githubForDarkTheme(context),
                onPressed: () async {
                  final url = Uri.parse('https://github.com/haman13');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                      webOnlyWindowName: '_blank',
                    );
                  }
                },
              ),
              SizedBox(width: ResponsiveHelper.getProportionateSpacing(1.6)),
              _ConnectButton(
                icon: FontAwesomeIcons.linkedin,
                label: 'اتصال به لینکدین',
                color: AppTheme.linkedIn,
                onPressed: () async {
                  final url = Uri.parse('https://www.linkedin.com/in/haman-darvish-6a489a25a/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                      webOnlyWindowName: '_blank',
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSideMenu() {
    final menuItems = [
      'درباره من',
      'مهارت‌ها',
      'سوابق',
      'پروژه‌ها',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: menuItems.map((item) => _buildMenuItem(item)).toList(),
    );
  }

  Widget _buildMenuItem(String title) {
    final isSelected = _selectedSection == title;
    
    return Padding(
      padding: ResponsiveHelper.getProportionatePadding(
        horizontal: 1.6,
        vertical: 0.4,
      ),
      child: isSelected 
        ? GestureDetector(
            onTap: () => _onMenuSelected(title),
            child: Container(
              padding: ResponsiveHelper.getProportionatePadding(
                vertical: 1.2,
                horizontal: 1.6,
              ),
              decoration: BoxDecoration(
                color: AppTheme.selectedContainer(context),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(200),      // گوشه بالا چپ - نصف اندازه
                  topRight: Radius.circular(8),     // گوشه بالا راست - همان اندازه
                  bottomLeft: Radius.circular(8),   // گوشه پایین چپ - نصف اندازه
                  bottomRight: Radius.circular(8),  // گوشه پایین راست - همان اندازه
                ),
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
                  color: AppTheme.textSelected(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _onMenuSelected(title),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: ResponsiveHelper.getProportionatePadding(
                  vertical: 1.2,
                  horizontal: 1.6,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: ResponsiveHelper.getProportionateFontSize(1.6),
                    color: AppTheme.textSecondaryOpacity(context),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
    );
  }

  void _onMenuSelected(String section) {
    setState(() {
      _selectedSection = section;
    });
  }

  Widget _buildMainContent() {
    switch (_selectedSection) {
      case 'درباره من':
        return const AboutSection();
      case 'مهارت‌ها':
        return const SkillsSection();
      case 'سوابق':
        return const ExperienceSection();
      case 'پروژه‌ها':
        return const ProjectsSection();
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ConnectButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ConnectButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: ResponsiveHelper.getProportionatePadding(
            horizontal: 2.4,
            vertical: 1.2,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: ResponsiveHelper.getProportionateFontSize(1.4),
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: ResponsiveHelper.getProportionateSpacing(1.2)),
              Icon(
                icon, 
                color: color,
                size: ResponsiveHelper.getProportionateFontSize(1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




