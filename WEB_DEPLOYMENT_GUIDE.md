# راهنمای انتشار وب اپلیکیشن رزومه

## 🚀 مراحل انتشار

### 1. **Build کردن برنامه**
```bash
flutter build web --release
```

### 2. **فایل‌های آماده شده**
فایل‌های build شده در پوشه `build/web/` قرار دارند:
- `index.html` - صفحه اصلی
- `main.dart.js` - کد JavaScript
- `flutter.js` - Flutter runtime
- `assets/` - تصاویر و فونت‌ها
- `icons/` - آیکون‌های PWA

## 🌐 گزینه‌های انتشار

### **گزینه 1: GitHub Pages (رایگان)**

1. **ایجاد Repository:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/username/resume.git
   git push -u origin main
   ```

2. **فعال‌سازی GitHub Pages:**
   - به Settings > Pages بروید
   - Source را روی "Deploy from a branch" تنظیم کنید
   - Branch را "main" و folder را "/docs" انتخاب کنید

3. **آپلود فایل‌ها:**
   ```bash
   # کپی کردن فایل‌های build به پوشه docs
   cp -r build/web/* docs/
   git add docs/
   git commit -m "Deploy to GitHub Pages"
   git push
   ```

### **گزینه 2: Netlify (رایگان)**

1. **آپلود مستقیم:**
   - به [netlify.com](https://netlify.com) بروید
   - روی "Deploy manually" کلیک کنید
   - پوشه `build/web` را drag & drop کنید

2. **اتصال به GitHub:**
   - Repository را به Netlify متصل کنید
   - Build command: `flutter build web --release`
   - Publish directory: `build/web`

### **گزینه 3: Vercel (رایگان)**

1. **نصب Vercel CLI:**
   ```bash
   npm i -g vercel
   ```

2. **Deploy:**
   ```bash
   cd build/web
   vercel --prod
   ```

### **گزینه 4: Firebase Hosting (رایگان)**

1. **نصب Firebase CLI:**
   ```bash
   npm install -g firebase-tools
   ```

2. **راه‌اندازی:**
   ```bash
   firebase login
   firebase init hosting
   # Select build/web as public directory
   ```

3. **Deploy:**
   ```bash
   flutter build web --release
   firebase deploy
   ```

## ⚙️ تنظیمات پیش‌رفته

### **بهینه‌سازی SEO**

1. **Sitemap.xml:**
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
     <url>
       <loc>https://your-domain.com/</loc>
       <lastmod>2024-01-01</lastmod>
       <changefreq>weekly</changefreq>
       <priority>1.0</priority>
     </url>
   </urlset>
   ```

2. **Google Analytics:**
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

### **بهینه‌سازی Performance**

1. **Compression:**
   - Gzip compression فعال کنید
   - Brotli compression برای سرعت بیشتر

2. **Caching:**
   ```html
   <!-- در web/index.html -->
   <meta http-equiv="Cache-Control" content="max-age=31536000">
   ```

3. **CDN:**
   - از Cloudflare یا AWS CloudFront استفاده کنید

## 🔧 تنظیمات دامنه

### **دامنه سفارشی**

1. **DNS Settings:**
   ```
   Type: CNAME
   Name: www
   Value: your-netlify-app.netlify.app
   ```

2. **SSL Certificate:**
   - به صورت خودکار فعال می‌شود
   - Let's Encrypt رایگان است

### **HTTPS Redirect**
```javascript
// در web/index.html
if (location.protocol !== 'https:') {
  location.replace('https:' + window.location.href.substring(window.location.protocol.length));
}
```

## 📱 PWA Features

### **Service Worker**
```javascript
// در web/index.html
if ('serviceWorker' in navigator) {
  window.addEventListener('flutter-first-frame', function () {
    navigator.serviceWorker.register('flutter_service_worker.js');
  });
}
```

### **Offline Support**
- فایل‌های static در cache ذخیره می‌شوند
- تصاویر و فونت‌ها offline در دسترس هستند

## 🚀 مراحل نهایی

### **1. تست محلی:**
```bash
cd build/web
python -m http.server 8000
# یا
npx serve .
```

### **2. تست Production:**
- سرعت بارگذاری را بررسی کنید
- Mobile responsiveness را تست کنید
- SEO را با Google PageSpeed Insights بررسی کنید

### **3. Monitoring:**
- Google Analytics
- Google Search Console
- Performance monitoring

## 📊 آمار و Analytics

### **Google Analytics 4:**
```html
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

### **Hotjar (User Behavior):**
```html
<script>
  (function(h,o,t,j,a,r){
    h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
    h._hjSettings={hjid:YOUR_HOTJAR_ID,hjsv:6};
    a=o.getElementsByTagName('head')[0];
    r=o.createElement('script');r.async=1;
    r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
    a.appendChild(r);
  })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');
</script>
```

## 🔒 امنیت

### **Content Security Policy:**
```html
<meta http-equiv="Content-Security-Policy" content="default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';">
```

### **Security Headers:**
```html
<meta http-equiv="X-Content-Type-Options" content="nosniff">
<meta http-equiv="X-Frame-Options" content="DENY">
<meta http-equiv="X-XSS-Protection" content="1; mode=block">
```

## 📈 بهینه‌سازی

### **Lighthouse Score:**
- Performance: 90+
- Accessibility: 90+
- Best Practices: 90+
- SEO: 90+

### **Core Web Vitals:**
- LCP (Largest Contentful Paint): < 2.5s
- FID (First Input Delay): < 100ms
- CLS (Cumulative Layout Shift): < 0.1

## 🎯 نتیجه

پس از انجام این مراحل، رزومه شما:
- ✅ به صورت آنلاین در دسترس خواهد بود
- ✅ SEO بهینه شده
- ✅ PWA قابلیت‌ها دارد
- ✅ Mobile responsive است
- ✅ Performance بالا دارد

**URL نهایی:** `https://your-domain.com`
