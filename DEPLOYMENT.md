# 🚀 راهنمای Deployment

این راهنما برای deploy کردن رزومه آنلاین روی GitHub Pages است.

## 📋 پیش‌نیازها

- حساب GitHub
- Flutter SDK نصب شده
- دسترسی به repository

## 🔧 مراحل Deployment

### 1. تنظیم GitHub Pages

1. وارد repository خود شوید
2. به بخش **Settings** بروید
3. در منوی سمت چپ، **Pages** را انتخاب کنید
4. در بخش **Source**، **GitHub Actions** را انتخاب کنید

### 2. فعال‌سازی GitHub Actions

فایل `.github/workflows/deploy.yml` قبلاً ایجاد شده است. این فایل به صورت خودکار:
- کد را build می‌کند
- تست‌ها را اجرا می‌کند
- روی GitHub Pages deploy می‌کند

### 3. تنظیم Repository

```bash
# کلون کردن repository
git clone https://github.com/haman13/resume.git
cd resume

# اضافه کردن remote
git remote add origin https://github.com/haman13/resume.git

# push کردن کد
git add .
git commit -m "Initial commit"
git push -u origin main
```

### 4. Build محلی (اختیاری)

```bash
# نصب dependencies
flutter pub get

# build برای web
flutter build web --release --base-href /resume/

# اجرای محلی
flutter run -d web-server --web-port 3000
```

## 🌐 URL نهایی

بعد از deployment موفق، رزومه شما در آدرس زیر در دسترس خواهد بود:

**https://haman13.github.io/resume/**

## 🔄 به‌روزرسانی

برای به‌روزرسانی رزومه:

1. تغییرات را در کد اعمال کنید
2. تغییرات را commit کنید:
   ```bash
   git add .
   git commit -m "Update resume"
   git push origin main
   ```
3. GitHub Actions به صورت خودکار build و deploy می‌کند

## 🛠️ تنظیمات پیشرفته

### تغییر Base URL

اگر می‌خواهید base URL را تغییر دهید:

1. فایل `.github/workflows/deploy.yml` را ویرایش کنید
2. `--base-href /resume/` را به URL مورد نظر تغییر دهید
3. فایل `web/index.html` را نیز به‌روزرسانی کنید

### دامنه سفارشی

برای استفاده از دامنه سفارشی:

1. فایل `web/CNAME` را ویرایش کنید
2. دامنه خود را وارد کنید
3. DNS records را تنظیم کنید

### محیط‌های مختلف

برای محیط‌های مختلف (development, staging, production):

1. فایل‌های `.env` مختلف ایجاد کنید
2. در GitHub Actions، environment variables تنظیم کنید

## 🐛 عیب‌یابی

### مشکلات رایج

1. **Build ناموفق**: بررسی کنید که Flutter SDK نصب باشد
2. **404 Error**: بررسی کنید که `base-href` درست تنظیم شده باشد
3. **تصاویر نمایش داده نمی‌شوند**: بررسی کنید که URL های تصاویر درست باشند

### لاگ‌ها

برای مشاهده لاگ‌های deployment:
1. وارد repository شوید
2. به بخش **Actions** بروید
3. workflow مورد نظر را انتخاب کنید

## 📞 پشتیبانی

اگر مشکلی داشتید:
- Issue در GitHub ایجاد کنید
- با من تماس بگیرید: [haman13@github](https://github.com/haman13)

---

**نکته**: این راهنما برای GitHub Pages است. برای پلتفرم‌های دیگر، تنظیمات متفاوت خواهد بود.
