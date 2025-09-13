# راهنمای انتشار روی GitHub Pages

## 🚀 مراحل کامل انتشار

### **مرحله 1: ایجاد Repository در GitHub**

1. به [GitHub.com](https://github.com) بروید
2. روی **"New repository"** کلیک کنید
3. نام repository را `resume` قرار دهید
4. **Public** انتخاب کنید
5. روی **"Create repository"** کلیک کنید

### **مرحله 2: اتصال به GitHub**

```bash
# اضافه کردن remote origin
git remote add origin https://github.com/YOUR_USERNAME/resume.git

# Push کردن به GitHub
git branch -M main
git push -u origin main
```

### **مرحله 3: فعال‌سازی GitHub Pages**

1. به repository خود بروید
2. روی **"Settings"** کلیک کنید
3. در منوی سمت چپ، **"Pages"** را انتخاب کنید
4. در بخش **"Source"**:
   - **"Deploy from a branch"** را انتخاب کنید
   - **Branch**: `main`
   - **Folder**: `/docs`
5. روی **"Save"** کلیک کنید

### **مرحله 4: انتظار برای Deploy**

- GitHub Pages معمولاً 5-10 دقیقه طول می‌کشد
- URL شما: `https://YOUR_USERNAME.github.io/resume/`

## 🔄 به‌روزرسانی برنامه

### **هر بار که تغییراتی دادید:**

```bash
# Build کردن مجدد
flutter build web --release

# کپی کردن فایل‌های جدید
xcopy build\web\* docs\ /E /H /Y

# Commit و Push
git add docs/
git commit -m "Update resume"
git push origin main
```

## ⚙️ تنظیمات پیش‌رفته

### **Custom Domain (اختیاری)**

1. دامنه خود را خریداری کنید
2. در GitHub Pages:
   - **Custom domain** را وارد کنید
   - **Enforce HTTPS** را فعال کنید
3. DNS settings:
   ```
   Type: CNAME
   Name: www
   Value: YOUR_USERNAME.github.io
   ```

### **GitHub Actions (خودکارسازی)**

فایل `.github/workflows/deploy.yml` ایجاد کنید:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.16.0'
        
    - name: Install dependencies
      run: flutter pub get
      
    - name: Build web
      run: flutter build web --release
      
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./build/web
```

## 📊 نظارت و آمار

### **GitHub Insights**
- **Traffic**: تعداد بازدیدکنندگان
- **Clones**: تعداد کلون‌ها
- **Forks**: تعداد فورک‌ها

### **Google Analytics**
```html
<!-- در web/index.html اضافه کنید -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

## 🔧 عیب‌یابی

### **مشکلات رایج:**

1. **صفحه سفید نمایش داده می‌شود:**
   - Console را بررسی کنید
   - CORS settings را چک کنید
   - Supabase URL و Key را بررسی کنید

2. **تصاویر نمایش داده نمی‌شوند:**
   - مسیر تصاویر را بررسی کنید
   - `assets/images/` را چک کنید

3. **GitHub Pages کار نمی‌کند:**
   - Repository public است؟
   - فایل‌ها در پوشه `docs/` هستند؟
   - Branch `main` انتخاب شده؟

### **بررسی عملکرد:**
```bash
# تست محلی
cd docs
python -m http.server 8000
# سپس به http://localhost:8000 بروید
```

## 📱 PWA Features

### **نصب روی موبایل:**
- مرورگر Chrome را باز کنید
- به سایت بروید
- روی **"Add to Home Screen"** کلیک کنید

### **Offline Support:**
- Service Worker خودکار فعال می‌شود
- فایل‌های static در cache ذخیره می‌شوند

## 🎯 نتیجه نهایی

پس از انجام این مراحل:
- ✅ رزومه شما آنلاین خواهد بود
- ✅ URL: `https://YOUR_USERNAME.github.io/resume/`
- ✅ PWA قابلیت‌ها فعال
- ✅ SEO بهینه‌سازی شده
- ✅ Mobile responsive

## 📞 پشتیبانی

اگر مشکلی داشتید:
1. Console errors را بررسی کنید
2. Network tab را چک کنید
3. GitHub Pages logs را مطالعه کنید
4. Issue در GitHub ایجاد کنید

---

**🎉 تبریک! رزومه شما حالا آنلاین است!**
