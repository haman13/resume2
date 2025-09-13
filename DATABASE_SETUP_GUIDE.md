# راهنمای تنظیم دیتابیس Supabase

## مراحل تنظیم

### 1. ایجاد جدول در Supabase

1. وارد پنل Supabase شوید
2. به بخش **SQL Editor** بروید
3. محتوای فایل `database_setup.sql` را کپی و اجرا کنید

### 2. بررسی جدول ایجاد شده

جدول `projects` با ساختار زیر ایجاد می‌شود:

```sql
-- ستون‌های اصلی
id (UUID) - شناسه یکتا
title (VARCHAR) - عنوان فارسی
description (TEXT) - توضیح فارسی
title_en (VARCHAR) - عنوان انگلیسی
description_en (TEXT) - توضیح انگلیسی
image_url (TEXT) - آدرس تصویر
technologies (TEXT[]) - آرایه تکنولوژی‌ها
links (JSONB) - لینک‌های پروژه
created_at (TIMESTAMP) - تاریخ ایجاد
updated_at (TIMESTAMP) - تاریخ به‌روزرسانی
is_active (BOOLEAN) - وضعیت فعال/غیرفعال
```

### 3. تنظیم RLS (Row Level Security)

برای امنیت بیشتر، RLS را فعال کنید:

```sql
-- فعال کردن RLS
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- ایجاد پالیسی برای خواندن عمومی
CREATE POLICY "Enable read access for all users" ON projects
FOR SELECT USING (is_active = true);

-- ایجاد پالیسی برای نوشتن (فقط برای ادمین‌ها)
CREATE POLICY "Enable insert for authenticated users only" ON projects
FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Enable update for authenticated users only" ON projects
FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Enable delete for authenticated users only" ON projects
FOR DELETE USING (auth.role() = 'authenticated');
```

### 4. تست اتصال

برای تست اتصال، از کد زیر استفاده کنید:

```dart
// در main.dart یا هر جای مناسب
final projectProvider = context.read<ProjectProvider>();
final isConnected = await projectProvider.testDatabaseConnection();
print('اتصال به دیتابیس: ${isConnected ? "موفق" : "ناموفق"}');
```

### 5. اضافه کردن پروژه جدید

برای اضافه کردن پروژه جدید:

```dart
final newProject = ProjectModel(
  id: '', // خالی بگذارید تا UUID خودکار تولید شود
  title: 'عنوان پروژه',
  description: 'توضیح پروژه',
  titleEn: 'Project Title',
  descriptionEn: 'Project Description',
  imageUrl: 'https://example.com/image.jpg',
  technologies: ['Flutter', 'Dart', 'Supabase'],
  links: {
    'github': 'https://github.com/username/project',
    'demo': 'https://demo.example.com',
  },
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  isActive: true,
);

await projectProvider.addProject(newProject);
```

### 6. مدیریت زبان‌ها

سیستم به صورت خودکار بر اساس زبان انتخابی کاربر:
- **فارسی**: نمایش `title` و `description`
- **انگلیسی**: نمایش `title_en` و `description_en` (اگر موجود باشد)

### 7. نکات مهم

- همیشه `title` و `description` را پر کنید (اجباری)
- `title_en` و `description_en` اختیاری هستند
- اگر ترجمه انگلیسی موجود نباشد، متن فارسی نمایش داده می‌شود
- فیلد `technologies` آرایه‌ای از رشته‌ها است
- فیلد `links` یک JSON object است

### 8. عیب‌یابی

اگر مشکلی پیش آمد:

1. **بررسی اتصال**: از `testDatabaseConnection()` استفاده کنید
2. **بررسی لاگ‌ها**: در کنسول Flutter لاگ‌ها را بررسی کنید
3. **بررسی Supabase**: در پنل Supabase لاگ‌ها را بررسی کنید
4. **بررسی RLS**: مطمئن شوید RLS درست تنظیم شده است
