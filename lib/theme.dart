import 'package:flutter/material.dart';

/// کلاس مدیریت تم و رنگ‌های برنامه
/// 
/// این کلاس شامل تمام رنگ‌ها، فونت‌ها و استایل‌های مورد استفاده در برنامه است.
/// تمام رنگ‌ها و فونت‌ها باید از این کلاس استفاده کنند تا یکپارچگی حفظ شود.
class AppTheme {
  // ==================== رنگ‌های اصلی ====================
  
  /// رنگ پایه تم (تعیین‌کننده ColorScheme) 
  /// استفاده: در ThemeData.light/dark برای تولید ColorScheme
  /// مکان: main.dart در MaterialApp
  static const Color seed = Color(0xFF2196F3); // آبی روشن و زیبا
  
  /// رنگ برند گیت‌هاب 
  /// استفاده: دکمه‌های اتصال به گیت‌هاب در custom_resume_page.dart
  /// مکان: _ConnectButton برای GitHub
  static const Color github = Color(0xFF333333);

  /// رنگ گیت‌هاب برای تم تاریک
  /// استفاده: دکمه‌های اتصال به گیت‌هاب در تم تاریک
  /// مکان: _ConnectButton برای GitHub در تم تاریک
  static Color githubForDarkTheme(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFFE0E0E0) : github; // روشن برای تم تاریک
  }
  
  /// رنگ برند لینکدین 
  /// استفاده: دکمه‌های اتصال به لینکدین در custom_resume_page.dart
  /// مکان: _ConnectButton برای LinkedIn
  static const Color linkedIn = Color(0xFF0A66C2);
  
  // ==================== رنگ‌های ثانویه ====================
  
  /// رنگ بنفش تیره برای انتخاب‌ها و هایلایت
  /// استفاده: متن انتخاب‌شده در منو، چیپ پروژه‌ها
  /// مکان: _buildMenuItem در custom_resume_page.dart، project_item.dart
  static const Color deepPurple = Color(0xFF673AB7);
  
  /// رنگ خاکستری متوسط برای متن‌های ثانویه
  /// استفاده: متن‌های کم‌اهمیت، آیکون‌ها
  /// مکان: experience_item.dart، expandable_card.dart
  static const Color grey = Color(0xFF9E9E9E);
  
  /// رنگ خاکستری روشن برای border ها
  /// استفاده: حاشیه آیتم‌ها و کارت‌ها
  /// مکان: project_item.dart
  static const Color greyLight = Color(0xFFE0E0E0);
  
  /// رنگ مشکی با شفافیت 87% برای متن‌های ثانویه
  /// استفاده: متن‌های کم‌اهمیت در تم روشن
  /// مکان: theme.dart در textSecondarySolid
  static const Color black87 = Color(0xDD000000);
  
  /// رنگ پس‌زمینه آیتم‌های انتخاب‌شده
  /// استفاده: پس‌زمینه منوهای انتخاب‌شده
  /// مکان: _buildMenuItem و _buildMobileMenuItem در custom_resume_page.dart
  static const Color selectedBackground = Color(0xFFE3F2FD);

  // ==================== اندازه‌ها و فاصله‌ها ====================
  
  /// شعاع گوشه کوچک برای آیتم‌های منو
  /// استفاده: منوهای موبایل و دسکتاپ
  /// مکان: _buildMenuItem و _buildMobileMenuItem در custom_resume_page.dart
  static const double radiusSmall = 8;
  
  /// شعاع گوشه قرصی برای حالت انتخاب منو در موبایل
  /// استفاده: منوی موبایل در حالت انتخاب‌شده
  /// مکان: _buildMobileMenuItem در custom_resume_page.dart
  static const double radiusPill = 30;

  /// واحد فاصله پایه (در صورت نیاز به استفاده ثابت)
  /// استفاده: بیشتر فاصله‌ها با ResponsiveHelper تنظیم می‌شوند
  /// مکان: در صورت نیاز در فایل‌های مختلف
  static const double unit = 8;

  // ==================== انیمیشن‌ها ====================
  
  /// Duration سریع برای انیمیشن‌های سبک
  /// استفاده: انیمیشن‌های کوچک و سریع
  /// مکان: در صورت نیاز در فایل‌های مختلف
  static const Duration fast = Duration(milliseconds: 150);
  
  /// Duration استاندارد برای انیمیشن‌ها
  /// استفاده: انیمیشن‌های معمولی
  /// مکان: در صورت نیاز در فایل‌های مختلف
  static const Duration normal = Duration(milliseconds: 850);

  // ==================== متدهای رنگ پویا ====================
  
  /// رنگ پس‌زمینه هدر
  /// استفاده: بخش هدر در custom_resume_page.dart
  /// مکان: _buildHeader در custom_resume_page.dart
  static Color headerBackground(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return scheme.secondaryContainer;
  }

  /// رنگ پس‌زمینه آیتم انتخاب‌شده منو
  /// استفاده: منوهای انتخاب‌شده در custom_resume_page.dart
  /// مکان: _buildMenuItem و _buildMobileMenuItem در custom_resume_page.dart
  static Color selectedContainer(BuildContext context) {
    return selectedBackground;
  }

  /// رنگ پس‌زمینه صفحه‌ها
  /// استفاده: پس‌زمینه اصلی صفحات
  /// مکان: custom_resume_page.dart به‌جای Colors.grey[100]
  static Color pageBackground(BuildContext context) {
    return Theme.of(context).colorScheme.surface;
  }

  /// رنگ پس‌زمینه کارت‌ها
  /// استفاده: پس‌زمینه کارت‌های expandable
  /// مکان: expandable_card.dart
  static Color cardBackgroundColor(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  /// رنگ پس‌زمینه کارت‌های سبز
  /// استفاده: کارت‌های "معرفی" و "تحصیلات" در about_section.dart
  /// مکان: about_section.dart
  static Color greenCardBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF1B5E20) : const Color(0xFFE8F5E8); // سبز تیره/روشن
  }

  /// رنگ پس‌زمینه کارت پروژه‌ها
  /// استفاده: کارت "پروژه‌ها" در projects_section.dart
  /// مکان: projects_section.dart
  static Color projectCardBackground(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF0F0F0); // خاکستری روشن‌تر برای تم تاریک
  }

  /// رنگ کارت/باکس‌ها
  /// استفاده: منوی بالای موبایل و سایدبار دسکتاپ
  /// مکان: custom_resume_page.dart در _buildMobileLayout و _buildDesktopLayout
  static Color cardBackground(BuildContext context) {
    return Theme.of(context).cardColor;
  }

  /// رنگ متن اصلی
  /// استفاده: جایگزین Colors.black در تمام فایل‌ها
  /// مکان: تمام فایل‌هایی که از Colors.black استفاده می‌کنند
  static Color textPrimary(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface;
  }

  /// رنگ متن ثانویه با شفافیت
  /// استفاده: جایگزین Colors.black87 در تمام فایل‌ها
  /// مکان: تمام فایل‌هایی که از Colors.black87 استفاده می‌کنند
  static Color textSecondaryOpacity(BuildContext context) {
    return Theme.of(context).colorScheme.onSurface.withOpacity(0.87);
  }

  /// رنگ پس‌زمینه تصویر پروفایل
  /// استفاده: هدر در custom_resume_page.dart
  /// مکان: _buildMobileHeader و _buildDesktopHeader در custom_resume_page.dart
  static Color profileImageBackground(BuildContext context) {
    return Theme.of(context).colorScheme.primaryContainer;
  }

  /// رنگ آیکون‌های کم‌اهمیت/خاکستری
  /// استفاده: آیکون‌های کم‌اهمیت در expandable_card.dart
  /// مکان: expandable_card.dart برای آیکون expand
  static Color iconMuted(BuildContext context) {
    return grey;
  }

  /// رنگ پس‌زمینه چیپ مهارت‌ها
  /// استفاده: چیپ‌های مهارت در skills_section.dart
  /// مکان: skills_section.dart در Chip widget
  static Color chipBackground(BuildContext context) {
    return Theme.of(context).colorScheme.primary.withOpacity(0.1);
  }
  
  /// رنگ متن خاکستری
  /// استفاده: جایگزین Colors.grey در تمام فایل‌ها
  /// مکان: experience_item.dart، expandable_card.dart
  static Color textGrey(BuildContext context) {
    return grey;
  }
  
  /// رنگ متن ثانویه بدون شفافیت (ثابت)
  /// استفاده: متن‌های ثانویه در تم روشن
  /// مکان: در صورت نیاز در فایل‌های مختلف
  static Color textSecondarySolid(BuildContext context) {
    return black87;
  }
  
  /// رنگ پس‌زمینه چیپ پروژه‌ها
  /// استفاده: چیپ‌های تکنولوژی در project_item.dart
  /// مکان: project_item.dart در Chip widget
  static Color projectChipBackground(BuildContext context) {
    return deepPurple.withOpacity(0.1);
  }
  
  /// رنگ متن انتخاب‌شده
  /// استفاده: متن انتخاب‌شده در منوها
  /// مکان: _buildMenuItem در custom_resume_page.dart
  static Color textSelected(BuildContext context) {
    return deepPurple;
  }
  
  /// رنگ border آیتم‌ها
  /// استفاده: حاشیه آیتم‌ها و کارت‌ها
  /// مکان: project_item.dart برای border کارت‌ها
  static Color borderColor(BuildContext context) {
    return greyLight;
  }

  // ==================== تم‌های برنامه ====================
  
  /// تم روشن برنامه
  /// استفاده: تم پیش‌فرض در main.dart
  /// مکان: main.dart در MaterialApp به‌عنوان theme
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ).copyWith(
          // سفارشی‌سازی رنگ‌ها برای ظاهر بهتر
          surface: const Color.fromARGB(255, 176, 188, 233), // پس‌زمینه روشن با ته‌مایه آبی
          primaryContainer: const Color(0xFFE3F2FD), // کانتینر اصلی روشن
          secondaryContainer: const Color(0xFFF3E5F5), // کانتینر ثانویه روشن
          onSurface: const Color(0xFF212121), // متن اصلی تیره‌تر
          onSurfaceVariant: const Color(0xFF757575), // متن ثانویه
        ),
        textTheme: const TextTheme(
          // فونت‌های اصلی برای عناوین
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF212121)),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF212121)),
          // فونت‌های متن
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF424242)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF757575)),
        ),
        cardTheme: const CardTheme(
          margin: EdgeInsets.only(bottom: 16),
          color: Color(0xFFFFFFFF), // کارت‌ها سفید
          elevation: 2,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 176, 188, 233),  // پس‌زمینه اصلی با ته‌مایه آبی
      );

  /// تم تاریک برنامه
  /// استفاده: تم تاریک در main.dart
  /// مکان: main.dart در MaterialApp به‌عنوان darkTheme
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ).copyWith(
          // سفارشی‌سازی رنگ‌ها برای ظاهر بهتر در تم دارک
          surface: const Color(0xFF1E1E1E), // پس‌زمینه روشن‌تر از سیاه کامل
          primaryContainer: const Color(0xFF1A237E), // کانتینر اصلی
          secondaryContainer: const Color(0xFF4A148C), // کانتینر ثانویه
          onSurface: const Color(0xFFE0E0E0), // متن اصلی روشن‌تر
          onSurfaceVariant: const Color(0xFFB0B0B0), // متن ثانویه
        ),
        textTheme: const TextTheme(
          // فونت‌های اصلی برای عناوین در تم تاریک
          headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFE0E0E0)),
          headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFFE0E0E0)),
          // فونت‌های متن در تم تاریک
          bodyLarge: TextStyle(fontSize: 16, color: Color(0xFFB0B0B0)),
          bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF9E9E9E)),
        ),
        cardTheme: const CardTheme(
          margin: EdgeInsets.only(bottom: 16),
          color: Color(0xFF2D2D2D), // کارت‌ها خاکستری تیره
          elevation: 4,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212), // پس‌زمینه اصلی (تیره‌تر)
      );
}


