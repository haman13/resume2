# راهنمای سیستم ریسپانسیو رزومه

## مقدمه
این پروژه از یک سیستم ریسپانسیو پیشرفته استفاده می‌کند که تمام المان‌ها را براساس اندازه صفحه تنظیم می‌کند.

## کلاس ResponsiveHelper

### مقداردهی اولیه
```dart
@override
Widget build(BuildContext context) {
  ResponsiveHelper.init(context);
  // ... rest of the code
}
```

### متدهای اصلی

#### 1. تشخیص نوع دستگاه
```dart
if (ResponsiveHelper.isMobile(context)) {
  // کد مخصوص موبایل
} else if (ResponsiveHelper.isTablet(context)) {
  // کد مخصوص تبلت
} else {
  // کد مخصوص دسکتاپ
}
```

#### 2. محاسبه سایزهای نسبی
```dart
// عرض نسبی (براساس درصد)
double width = ResponsiveHelper.getProportionateScreenWidth(30); // 30% of screen width

// ارتفاع نسبی (براساس درصد)
double height = ResponsiveHelper.getProportionateScreenHeight(20); // 20% of screen height

// فونت نسبی
double fontSize = ResponsiveHelper.getProportionateFontSize(2.0); // 2% of screen width

// فاصله نسبی
double spacing = ResponsiveHelper.getProportionateSpacing(2.0); // 2% of screen width
```

#### 3. Padding و Margin نسبی
```dart
// Padding نسبی
EdgeInsets padding = ResponsiveHelper.getProportionatePadding(
  horizontal: 2.0, // 2% of screen width
  vertical: 1.5,   // 1.5% of screen height
);

// Margin نسبی
EdgeInsets margin = ResponsiveHelper.getProportionateMargin(
  horizontal: 3.0, // 3% of screen width
  vertical: 2.0,   // 2% of screen height
);
```

#### 4. Flex برای ستون‌ها
```dart
// منوی کناری
Expanded(
  flex: ResponsiveHelper.getSideMenuFlex(),
  child: SideMenu(),
),

// محتوای اصلی
Expanded(
  flex: ResponsiveHelper.getMainContentFlex(),
  child: MainContent(),
),
```

#### 5. اندازه عکس پروفایل
```dart
Container(
  width: ResponsiveHelper.getProfileImageSize(),
  height: ResponsiveHelper.getProfileImageSize(),
  // ...
)
```

## برک‌پوینت‌ها

- **موبایل**: کمتر از 600px
- **تبلت**: 600px تا 900px  
- **دسکتاپ**: بیشتر از 900px

## مثال‌های کاربردی

### 1. لایه‌بندی تطبیقی
```dart
Widget build(BuildContext context) {
  return ResponsiveHelper.isMobile(context)
      ? _buildMobileLayout()
      : _buildDesktopLayout();
}
```

### 2. فونت‌های ریسپانسیو
```dart
Text(
  'عنوان',
  style: TextStyle(
    fontSize: ResponsiveHelper.getProportionateFontSize(2.0),
    fontWeight: FontWeight.bold,
  ),
)
```

### 3. فاصله‌های نسبی
```dart
Column(
  children: [
    Widget1(),
    SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.0)),
    Widget2(),
  ],
)
```

### 4. کانتینرهای نسبی
```dart
Container(
  width: ResponsiveHelper.getProportionateScreenWidth(90), // 90% of screen width
  padding: ResponsiveHelper.getProportionatePadding(
    horizontal: 2.0,
    vertical: 2.0,
  ),
  child: Content(),
)
```

## نکات مهم

1. **همیشه ResponsiveHelper.init(context) را در ابتدای build فراخوانی کنید**
2. **از سایزهای ثابت استفاده نکنید**
3. **برای موبایل از لایه‌بندی عمودی استفاده کنید**
4. **برای دسکتاپ از لایه‌بندی افقی استفاده کنید**
5. **از SafeArea برای جلوگیری از تداخل با نوار وضعیت استفاده کنید**

## مزایای این سیستم

- ✅ کاملاً ریسپانسیو
- ✅ سازگار با تمام اندازه‌های صفحه
- ✅ مدیریت آسان سایزها
- ✅ کد تمیز و قابل نگهداری
- ✅ عملکرد بهینه
