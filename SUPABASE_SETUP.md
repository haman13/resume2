# راهنمای تنظیم Supabase برای پروژه رزومه

## 1. ایجاد پروژه در Supabase

1. به [supabase.com](https://supabase.com) بروید
2. حساب کاربری ایجاد کنید یا وارد شوید
3. روی "New Project" کلیک کنید
4. نام پروژه و رمز عبور دیتابیس را وارد کنید
5. منطقه جغرافیایی را انتخاب کنید
6. روی "Create new project" کلیک کنید

## 2. ایجاد جدول پروژه‌ها

در SQL Editor، کد زیر را اجرا کنید:

```sql
-- ایجاد جدول projects
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

-- ایجاد فانکشن برای به‌روزرسانی updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- ایجاد تریگر برای به‌روزرسانی خودکار updated_at
CREATE TRIGGER update_projects_updated_at 
    BEFORE UPDATE ON projects 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- اضافه کردن داده‌های نمونه
INSERT INTO projects (title, description, image_url, technologies, links) VALUES
(
  'همین رزومه ای که دارید مشاهده میکنید',
  'وب اپ',
  'assets/images/1752648209158.png',
  ARRAY['Flutter', 'GetX', 'Dart'],
  '{"اتصال مستقیم": "https://github.com/your-username/resume"}'
),
(
  'بازی حدس عدد',
  'وب اپ',
  'assets/images/1752648209158.png',
  ARRAY['Flutter', 'GetX', 'Dart'],
  '{"اتصال مستقیم": "https://github.com/your-username/number-guessing-game"}'
),
(
  'برنامه نوبت دهی',
  'وب اپ',
  'assets/images/1752648209158.png',
  ARRAY['Flutter', 'GetX', 'Dart'],
  '{"اتصال مستقیم": "https://github.com/your-username/appointment-booking"}'
),
(
  'فروشگاه آنلاین',
  'وب اپ',
  'assets/images/1752648209158.png',
  ARRAY['Flutter', 'GetX', 'Dart'],
  '{"اتصال مستقیم": "https://github.com/your-username/online-store"}'
),
(
  'ماشین حساب',
  'وب اپ',
  'assets/images/1752648209158.png',
  ARRAY['Flutter', 'GetX', 'Dart'],
  '{"اتصال مستقیم": "https://github.com/your-username/calculator"}'
);
```

## 3. تنظیم مجوزها

در Authentication > Policies، policy زیر را اضافه کنید:

```sql
-- اجازه خواندن برای همه (عمومی)
CREATE POLICY "Enable read access for all users" ON projects
FOR SELECT USING (true);

-- اجازه اضافه کردن برای کاربران احراز هویت شده
CREATE POLICY "Enable insert for authenticated users only" ON projects
FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- اجازه به‌روزرسانی برای کاربران احراز هویت شده
CREATE POLICY "Enable update for authenticated users only" ON projects
FOR UPDATE USING (auth.role() = 'authenticated');

-- اجازه حذف برای کاربران احراز هویت شده
CREATE POLICY "Enable delete for authenticated users only" ON projects
FOR DELETE USING (auth.role() = 'authenticated');
```

## 4. دریافت کلیدهای API

1. به Settings > API بروید
2. URL پروژه را کپی کنید
3. کلید `anon` (public) را کپی کنید

## 5. تنظیم کد Flutter

در فایل `lib/services/supabase_service.dart`:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL', // URL پروژه شما
  anonKey: 'YOUR_SUPABASE_ANON_KEY', // کلید عمومی شما
);
```

## 6. نصب پکیج‌ها

```bash
flutter pub get
```

## 7. اجرای برنامه

```bash
flutter run
```

## 8. مدیریت پروژه‌ها

### اضافه کردن پروژه جدید:
```dart
final project = ProjectModel(
  id: '',
  title: 'نام پروژه',
  description: 'توضیحات پروژه',
  imageUrl: 'assets/images/project.png',
  technologies: ['Flutter', 'Dart'],
  links: {'GitHub': 'https://github.com/username/project'},
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

await context.read<ProjectProvider>().addProject(project);
```

### به‌روزرسانی پروژه:
```dart
final updatedProject = existingProject.copyWith(
  title: 'نام جدید',
  description: 'توضیحات جدید',
);

await context.read<ProjectProvider>().updateProject(updatedProject);
```

### حذف پروژه:
```dart
await context.read<ProjectProvider>().deleteProject(projectId);
```

## 9. ویژگی‌های اضافی

- **فیلتر بر اساس تکنولوژی**: `filterProjectsByTechnology('Flutter')`
- **بارگذاری مجدد**: `refreshProjects()`
- **مدیریت خطا**: نمایش پیام‌های خطا و دکمه تلاش مجدد
- **Loading State**: نمایش انیمیشن بارگذاری
- **Empty State**: نمایش پیام زمانی که پروژه‌ای وجود ندارد

## 10. نکات مهم

- همیشه URL و کلیدهای API را در متغیرهای محیطی نگهداری کنید
- برای تولید، از کلیدهای مخصوص production استفاده کنید
- تصاویر پروژه‌ها را در پوشه `assets/images/` قرار دهید
- لینک‌های پروژه‌ها باید معتبر باشند
