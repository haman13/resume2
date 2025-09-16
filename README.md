# 🚀 رزومه آنلاین هامان درویش

یک رزومه تعاملی و responsive که با Flutter ساخته شده و از Supabase برای مدیریت داده‌ها استفاده می‌کند.

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)](https://supabase.com/)
[![GitHub Pages](https://img.shields.io/badge/GitHub%20Pages-222222?style=for-the-badge&logo=github&logoColor=white)](https://pages.github.com/)

## 🌐 مشاهده آنلاین

[**🔗 مشاهده رزومه آنلاین**](https://haman13.github.io/resume/)

## ✨ ویژگی‌ها

- 📱 **Responsive Design** - سازگار با تمام اندازه‌های صفحه
- 🌙 **Dark/Light Theme** - پشتیبانی از تم روشن و تاریک
- 🗄️ **Dynamic Data** - اتصال به Supabase برای مدیریت پروژه‌ها
- 🎨 **Modern UI** - طراحی مدرن و زیبا
- ⚡ **Fast Loading** - بهینه‌سازی شده برای سرعت
- 📱 **PWA** - قابلیت نصب روی موبایل
- 🔍 **SEO Optimized** - بهینه‌سازی شده برای موتورهای جستجو
- 🌍 **Multi-language** - پشتیبانی از فارسی و انگلیسی
- 📊 **Real-time Data** - داده‌های زنده از دیتابیس

## 🛠️ تکنولوژی‌های استفاده شده

- **Frontend**: Flutter Web
- **Backend**: Supabase (PostgreSQL)
- **State Management**: Provider
- **Icons**: Material Icons
- **Deployment**: GitHub Pages
- **CI/CD**: GitHub Actions

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

#




### سایر پلتفرم‌ها
- **Netlify**: Drag & drop پوشه `build/web`
- **Vercel**: `npx vercel --prod`
- **Firebase**: `firebase deploy`



## 📊 Performance

- **Lighthouse Score**: 90+
- **First Contentful Paint**: < 2s
- **Largest Contentful Paint**: < 2.5s
- **Cumulative Layout Shift**: < 0.1

## 🤝 مشارکت

## 📄 لایسنس

این پروژه تحت لایسنس MIT منتشر شده است. برای جزئیات بیشتر فایل `LICENSE` را مطالعه کنید.

## 📞 تماس

- **GitHub**: [@haman13](https://github.com/haman13)
- **Email**: hamancodes@example.com
- **LinkedIn**: https://www.linkedin.com/in/haman-darvish-6a489a25a/

---

⭐ اگر این پروژه برایتان مفید بود، یک ستاره بدهید!



داریم روی قسمت اندازه ها کار میکنیم فعلا روی اندازه حالت دسکتاپ رو داریم مرتب میکنیم.