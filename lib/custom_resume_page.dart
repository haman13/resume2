// ignore_for_file: prefer_final_fields, unused_field, prefer_const_constructors, no_leading_underscores_for_local_identifiers, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'utils/responsive_helper.dart';
import 'theme.dart';
import 'providers/locale_provider.dart';

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
  String _selectedSection = 'aboutMe'; // پیش‌فرض انتخاب شده
  double? _headerHeightMobileEstimate; // برآورد ارتفاع هدر در موبایل
  double headerIconSize = 24.0; // اندازه آیکون هدر (قابل تنظیم)

  String _getLocalizedTitle(String key) {
    final localizations = AppLocalizations.of(context);
    switch (key) {
      case 'aboutMe':
        return localizations.aboutMe;
      case 'skills':
        return localizations.skills;
      case 'experience':
        return localizations.experience;
      case 'projects':
        return localizations.projects;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    // مقداردهی اولیه ResponsiveHelper
    ResponsiveHelper.init(context);

    final localeProvider = Provider.of<LocaleProvider>(context);
    return Directionality(
      textDirection: localeProvider.locale.languageCode == 'fa'
          ? TextDirection.rtl
          : TextDirection.ltr,
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
        ResponsiveHelper.isDesktop(context)
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: SingleChildScrollView(
                    padding:
                        ResponsiveHelper.getProportionatePadding(vertical: 2.4),
                    child: _buildSideMenu(),
                  ),
                ),
              )
            : Expanded(
                flex: ResponsiveHelper.getSideMenuFlex(),
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: SingleChildScrollView(
                    padding:
                        ResponsiveHelper.getProportionatePadding(vertical: 2.4),
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
      'aboutMe',
      'skills',
      'experience',
      'projects',
    ];

    return menuItems.map((item) => _buildMobileMenuItem(item)).toList();
  }

  Widget _buildMobileMenuItem(String title) {
    final isSelected = _selectedSection == title;
    final localizedTitle = _getLocalizedTitle(title);
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _selectedFontSize = _screenWidth * 0.035; // 4.5% عرض صفحه
    final double _normalFontSize = _screenWidth * 0.030;   // 4% عرض صفحه

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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        Directionality.of(context) == TextDirection.rtl
                            ? AppTheme.radiusPill
                            : AppTheme.radiusSmall),
                    topRight: Radius.circular(
                        Directionality.of(context) == TextDirection.rtl
                            ? AppTheme.radiusSmall
                            : AppTheme.radiusPill),
                    bottomLeft: Radius.circular(AppTheme.radiusPill),
                    bottomRight: Radius.circular(AppTheme.radiusSmall),
                  ),
                ),
                child: Text(
                  localizedTitle,
                  style: TextStyle(
                    fontSize: _selectedFontSize,
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
                    localizedTitle,
                    style: TextStyle(
                      fontSize: _normalFontSize,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.87),
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
      // NOTE(desktop): ارتفاع هدر برای دسکتاپ نهایی شده؛ برای موبایل/تبلت تغییر ندهید
      height: ResponsiveHelper.isDesktop(context)
          ? ResponsiveHelper.getProportionateScreenHeight(15.0)
          : null,
      padding: ResponsiveHelper.isDesktop(context)
          ? const EdgeInsets.only(top: 10, right: 25, left: 10, bottom: 0)
          : ResponsiveHelper.getProportionatePadding(
              horizontal: 2.4,
              vertical: 2.4,
            ),
      child: Stack(
        children: [
          // محاسبه و ذخیره برآورد ارتفاع هدر در موبایل بر اساس اجزای داخلی
          if (ResponsiveHelper.isMobile(context))
            Builder(
              builder: (context) {
                final double profileSize = ResponsiveHelper.getProfileImageSize();
                final double spacingAboveName = ResponsiveHelper.getProportionateSpacing(1.5);
                final double nameFontSize = ResponsiveHelper.getProportionateFontSize(2.0) * MediaQuery.of(context).textScaleFactor;
                const double nameLineHeightFactor = 1.2;
                final double nameTextHeight = nameFontSize * nameLineHeightFactor;
                final double spacingBelowName = ResponsiveHelper.getProportionateSpacing(2.0);
                final double btnFontSize = ResponsiveHelper.getProportionateFontSize(1.6) * MediaQuery.of(context).textScaleFactor;
                final double btnIconSize = ResponsiveHelper.getProportionateFontSize(2.0);
                final double btnVerticalPad = ResponsiveHelper.getProportionateSpacing(1.2);
                final double connectButtonsHeight = (btnVerticalPad * 2) + (btnFontSize > btnIconSize ? btnFontSize : btnIconSize);
                final double headerVerticalPadEach = ResponsiveHelper.getProportionateSpacing(2.4);
                final double headerVerticalPaddingTotal = headerVerticalPadEach * 2;
                _headerHeightMobileEstimate = headerVerticalPaddingTotal + profileSize + spacingAboveName + nameTextHeight + spacingBelowName + connectButtonsHeight;
                headerIconSize = (_headerHeightMobileEstimate ?? 0) / 5;
                return const SizedBox.shrink();
              },
            ),
          // محتوای اصلی هدر
          ResponsiveHelper.isMobile(context)
              ? _buildMobileHeader()
              : _buildDesktopHeader(),
          // دکمه‌های تغییر تم و زبان - موقعیت پویا بر اساس جهت متن
          Positioned(
            top: 0,
            left: Directionality.of(context) == TextDirection.rtl ? 0 : null,
            right: Directionality.of(context) == TextDirection.rtl ? null : 0,
            child: ResponsiveHelper.isMobile(context)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContactButton(),
                      SizedBox(height: ResponsiveHelper.getProportionateSpacing(headerIconSize/5)),
                      _buildThemeToggleButton(),
                      SizedBox(height: ResponsiveHelper.getProportionateSpacing(headerIconSize/5)),
                      _buildLanguageToggleButton(),
                    ],
                  )
                : Row(
                    children: [
                      _buildContactButton(),
                      const SizedBox(width: 8),
                      _buildThemeToggleButton(),
                      const SizedBox(width: 8),
                      _buildLanguageToggleButton(),
                      const SizedBox(width: 8),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
  
// حذف شد: اندازه آیکون هدر به صورت داینامیک از headerIconSize محاسبه می‌شود
  // دکمه تماس
  Widget _buildContactButton() {
    if (ResponsiveHelper.isMobile(context)) {
      return IconButton(
        onPressed: _showContactDialog,
        icon: Icon(
          Icons.contact_phone,
          color: Theme.of(context).colorScheme.onSurface,
          size: headerIconSize,
        ),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        constraints: const BoxConstraints(),
        tooltip: 'Contact',
      );
    }
    return Container(
      margin: ResponsiveHelper.isDesktop(context)
          ? EdgeInsets.zero
          : const EdgeInsets.all(8),
      child: IconButton(
        onPressed: _showContactDialog,
        icon: Icon(
          Icons.contact_phone,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24,
        ),
        style: IconButton.styleFrom(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(8),
        ),
        tooltip: 'Contact',
      ),
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Contact',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.phone),
                title: const Text('09120069744'),
                onTap: () async {
                  final uri = Uri.parse('tel:+989120069744');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.email_outlined),
                title: const Text('hamancodes@gmail.com'),
                onTap: () async {
                  final uri = Uri.parse('mailto:hamancodes@gmail.com');
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // دکمه تغییر تم
  Widget _buildThemeToggleButton() {
    if (ResponsiveHelper.isMobile(context)) {
      return IconButton(
        onPressed: widget.onThemeToggle,
        icon: Icon(
          widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: Theme.of(context).colorScheme.onSurface,
          size: headerIconSize,
        ),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        constraints: const BoxConstraints(),
        tooltip: widget.isDarkMode
            ? AppLocalizations.of(context).lightTheme
            : AppLocalizations.of(context).darkTheme,
      );
    }
    return Container(
      margin: ResponsiveHelper.isDesktop(context)
          ? EdgeInsets.zero
          : const EdgeInsets.all(8),
      child: IconButton(
        onPressed: widget.onThemeToggle,
        icon: Icon(
          widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24,
        ),
        style: IconButton.styleFrom(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(8),
        ),
        tooltip: widget.isDarkMode
            ? AppLocalizations.of(context).lightTheme
            : AppLocalizations.of(context).darkTheme,
      ),
    );
  }

  Widget _buildLanguageToggleButton() {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        if (ResponsiveHelper.isMobile(context)) {
          return IconButton(
            onPressed: () => localeProvider.toggleLocale(),
            icon: Icon(
              localeProvider.locale.languageCode == 'fa'
                  ? Icons.language
                  : Icons.translate,
              color: Theme.of(context).colorScheme.onSurface,
              size: headerIconSize,
            ),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(),
            tooltip: AppLocalizations.of(context).changeLanguage,
          );
        }
        return Container(
          margin: ResponsiveHelper.isDesktop(context)
              ? EdgeInsets.zero
              : const EdgeInsets.all(8),
          child: IconButton(
            onPressed: () => localeProvider.toggleLocale(),
            icon: Icon(
              localeProvider.locale.languageCode == 'fa'
                  ? Icons.language
                  : Icons.translate,
              color: Theme.of(context).colorScheme.onSurface,
              size: 24,
            ),
            style: IconButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.surface.withOpacity(0.8),
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(8),
            ),
            tooltip: AppLocalizations.of(context).changeLanguage,
          ),
        );
      },
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
          AppLocalizations.of(context).personName,
          style: TextStyle(
            fontSize: ResponsiveHelper.getProportionateFontSize(4.0),
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
              label: AppLocalizations.of(context).connectGithub,
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
            SizedBox(width: ResponsiveHelper.getProportionateSpacing(3.0)),
            _ConnectButton(
              icon: FontAwesomeIcons.linkedin,
              label: AppLocalizations.of(context).connectLinkedin,
              color: AppTheme.linkedIn,
              onPressed: () async {
                final url = Uri.parse(
                    'https://www.linkedin.com/in/haman-darvish-6a489a25a/');
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
            SizedBox(height: 0),
            Text(
              AppLocalizations.of(context).personName,
              style: TextStyle(
                fontSize: ResponsiveHelper.getProportionateFontSize(1.0),
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
        // دکمه‌های اتصال - سمت چپ
        Expanded(
          child: Padding(
            // NOTE(desktop): فاصله عمودی ردیف دکمه‌های اتصال برای دسکتاپ نهایی شده
            padding: EdgeInsets.only(
              top: ResponsiveHelper.getProportionateSpacing(1.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _ConnectButton(
                  icon: FontAwesomeIcons.github,
                  label: AppLocalizations.of(context).connectGithub,
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
              // NOTE(desktop): فاصله بین دکمه‌های اتصال در دسکتاپ نهایی شده
              SizedBox(width: ResponsiveHelper.getProportionateSpacing(1.0)),
                _ConnectButton(
                  icon: FontAwesomeIcons.linkedin,
                  label: AppLocalizations.of(context).connectLinkedin,
                  color: AppTheme.linkedIn,
                  onPressed: () async {
                    final url = Uri.parse(
                        'https://www.linkedin.com/in/haman-darvish-6a489a25a/');
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
        ),
      ],
    );
  }

  Widget _buildSideMenu() {
    final menuItems = [
      'aboutMe',
      'skills',
      'experience',
      'projects',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: menuItems.map((item) => _buildMenuItem(item)).toList(),
    );
  }

  Widget _buildMenuItem(String title) {
    final isSelected = _selectedSection == title;
    final localizedTitle = _getLocalizedTitle(title);

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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                        Directionality.of(context) == TextDirection.rtl
                            ? 200
                            : 8),
                    topRight: Radius.circular(
                        Directionality.of(context) == TextDirection.rtl
                            ? 8
                            : 200),
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: Text(
                  localizedTitle,
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
                    localizedTitle,
                    style: TextStyle(
                      fontSize: ResponsiveHelper.getProportionateFontSize(1.2),
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
    Widget content;
    switch (_selectedSection) {
      case 'aboutMe':
        content = const AboutSection();
        break;
      case 'skills':
        content = const SkillsSection();
        break;
      case 'experience':
        content = const ExperienceSection();
        break;
      case 'projects':
        content = const ProjectsSection();
        break;
      default:
        content = const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: AppTheme.normal,
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(0.03, 0),
          end: Offset.zero,
        ).animate(animation);
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: offsetAnimation,
            child: child,
          ),
        );
      },
      child: KeyedSubtree(
        key: ValueKey('${_selectedSection}_${MediaQuery.of(context).size.width.round()}_${MediaQuery.of(context).size.height.round()}'),
        child: content,
      ),
    );
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
    final bool _isDesktop = ResponsiveHelper.isDesktop(context);

    // محاسبه حداقل ارتفاع برای جلوگیری از خیلی کوچک شدن دکمه در دسکتاپ
    final double _fontSize = _isDesktop
        ? ResponsiveHelper.getProportionateFontSize(1.0)
        : ResponsiveHelper.getProportionateFontSize(1.6);
    final double _iconSize = _isDesktop
        ? ResponsiveHelper.getProportionateFontSize(1.2)
        : ResponsiveHelper.getProportionateFontSize(2.0);
    final double _verticalPad = _isDesktop
        ? ResponsiveHelper.getProportionateSpacing(0.6)
        : ResponsiveHelper.getProportionateSpacing(1.2);
    final double _estimatedHeight =
        (_verticalPad * 2) + (_fontSize > _iconSize ? _fontSize : _iconSize);
    final double _minHeight = _isDesktop ? _estimatedHeight * 0.5 : 0.0;

    return Material(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          constraints:
              _isDesktop ? BoxConstraints(minHeight: _minHeight) : null,
          padding: ResponsiveHelper.isDesktop(context)
              ? ResponsiveHelper.getProportionatePadding(
                  horizontal: 1.2,
                  vertical: 0.6,
                )
              : ResponsiveHelper.getProportionatePadding(
                  horizontal: 2.4,
                  vertical: 1.2,
                ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: ResponsiveHelper.isDesktop(context)
                      ? ResponsiveHelper.getProportionateFontSize(1.0)
                      : ResponsiveHelper.getProportionateFontSize(3.0),
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: ResponsiveHelper.isDesktop(context)
                    ? ResponsiveHelper.getProportionateSpacing(1.0)
                    : ResponsiveHelper.getProportionateSpacing(1.6),
              ),
              Icon(
                icon,
                color: color,
                size: ResponsiveHelper.isDesktop(context)
                    ? ResponsiveHelper.getProportionateFontSize(1.2)
                    : ResponsiveHelper.getProportionateFontSize(3.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
