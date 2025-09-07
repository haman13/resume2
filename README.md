# رزومه حرفه‌ای - هامان

یک رزومه تعاملی و responsive که با Flutter ساخته شده و از Supabase برای مدیریت داده‌ها استفاده می‌کند.

## 🌐 مشاهده آنلاین

[**مشاهده رزومه آنلاین**](https://haman13.github.io/resume/)

## ✨ ویژگی‌ها

- 📱 **Responsive Design** - سازگار با تمام اندازه‌های صفحه
- 🌙 **Dark/Light Theme** - پشتیبانی از تم روشن و تاریک
- 🗄️ **Dynamic Data** - اتصال به Supabase برای مدیریت پروژه‌ها
- 🎨 **Modern UI** - طراحی مدرن و زیبا
- ⚡ **Fast Loading** - بهینه‌سازی شده برای سرعت
- 📱 **PWA** - قابلیت نصب روی موبایل
- 🔍 **SEO Optimized** - بهینه‌سازی شده برای موتورهای جستجو

## 🛠️ تکنولوژی‌های استفاده شده

- **Frontend**: Flutter Web
- **Backend**: Supabase
- **State Management**: Provider
- **Icons**: Font Awesome
- **Deployment**: GitHub Pages

## 🚀 اجرای محلی

### پیش‌نیازها
- Flutter SDK (3.2.0+)
- Dart SDK
- Git

### نصب و اجرا
```bash
# کلون کردن پروژه
git clone https://github.com/haman13/resume.git
cd resume

# نصب dependencies
flutter pub get

# اجرای برنامه
flutter run -d chrome
```

## 📁 ساختار پروژه

```
lib/
├── main.dart                          # نقطه ورود برنامه
├── theme.dart                         # مدیریت تم و رنگ‌ها
├── custom_resume_page.dart            # صفحه اصلی رزومه
├── models/
│   └── project_model.dart             # مدل داده پروژه‌ها
├── services/
│   ├── supabase_service.dart          # سرویس اتصال به Supabase
│   └── mock_project_service.dart      # سرویس Mock برای تست
├── providers/
│   └── project_provider.dart          # Provider برای مدیریت state
├── sections/
│   ├── about_section.dart             # بخش درباره من
│   ├── experience_section.dart        # بخش تجربیات
│   ├── projects_section.dart          # بخش پروژه‌ها
│   └── skills_section.dart            # بخش مهارت‌ها
├── widgets/
│   ├── expandable_card.dart           # کارت قابل گسترش
│   ├── experience_item.dart           # آیتم تجربه
│   └── project_item.dart              # آیتم پروژه
└── utils/
    └── responsive_helper.dart         # کمک‌رسان responsive
```

## 🔧 تنظیمات

### اتصال به Supabase
1. فایل `lib/services/supabase_service.dart` را باز کنید
2. URL و کلید Supabase خود را وارد کنید:
```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

### ساختار دیتابیس
جدول `projects` در Supabase:
```sql
CREATE TABLE projects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  image_url TEXT NOT NULL,
  technologies TEXT[] NOT NULL,
  links JSONB NOT NULL DEFAULT '{}',
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

## 📱 انتشار

### GitHub Pages
```bash
# Build کردن برای وب
flutter build web --release

# کپی کردن فایل‌ها به docs
cp -r build/web/* docs/

# Commit و Push
git add docs/
git commit -m "Deploy to GitHub Pages"
git push origin main
```

### سایر پلتفرم‌ها
- **Netlify**: Drag & drop پوشه `build/web`
- **Vercel**: `npx vercel --prod`
- **Firebase**: `firebase deploy`

## 🎨 سفارشی‌سازی

### تغییر رنگ‌ها
فایل `lib/theme.dart` را ویرایش کنید:
```dart
static const Color primary = Color(0xFF2196F3);
static const Color secondary = Color(0xFF03DAC6);
```

### اضافه کردن بخش جدید
1. فایل جدید در `lib/sections/` ایجاد کنید
2. در `custom_resume_page.dart` اضافه کنید
3. منو را به‌روزرسانی کنید

## 📊 Performance

- **Lighthouse Score**: 90+
- **First Contentful Paint**: < 2s
- **Largest Contentful Paint**: < 2.5s
- **Cumulative Layout Shift**: < 0.1

## 🤝 مشارکت

1. Fork کنید
2. Branch جدید ایجاد کنید (`git checkout -b feature/amazing-feature`)
3. تغییرات را commit کنید (`git commit -m 'Add amazing feature'`)
4. Push کنید (`git push origin feature/amazing-feature`)
5. Pull Request ایجاد کنید

## 📄 لایسنس

این پروژه تحت لایسنس MIT منتشر شده است. برای جزئیات بیشتر فایل `LICENSE` را مطالعه کنید.

## 📞 تماس

- **GitHub**: [@haman13](https://github.com/haman13)
- **Email**: your-email@example.com
- **LinkedIn**: [Your LinkedIn Profile](https://linkedin.com/in/your-profile)

---

⭐ اگر این پروژه برایتان مفید بود، یک ستاره بدهید!