# ساختار پروژه رزومه با اتصال به دیتابیس

## 📁 ساختار فایل‌ها

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
│   ├── projects_section.dart          # بخش پروژه‌ها (با اتصال به دیتابیس)
│   └── skills_section.dart            # بخش مهارت‌ها
├── widgets/
│   ├── expandable_card.dart           # کارت قابل گسترش
│   ├── experience_item.dart           # آیتم تجربه
│   └── project_item.dart              # آیتم پروژه
└── utils/
    └── responsive_helper.dart         # کمک‌رسان responsive
```

## 🔧 ویژگی‌های پیاده‌سازی شده

### 1. **مدیریت State با Provider**
- `ProjectProvider` برای مدیریت state پروژه‌ها
- Loading states، error handling، و empty states
- فیلتر کردن پروژه‌ها بر اساس تکنولوژی

### 2. **مدل داده پروژه**
- `ProjectModel` با تمام فیلدهای مورد نیاز
- تبدیل JSON به مدل و بالعکس
- متدهای `copyWith` و `toString`

### 3. **سرویس‌های داده**
- `SupabaseService` برای اتصال واقعی به Supabase
- `MockProjectService` برای تست و توسعه
- قابلیت تعویض آسان بین سرویس‌ها

### 4. **UI/UX بهبود یافته**
- Loading indicator هنگام بارگذاری
- Error state با دکمه تلاش مجدد
- Empty state برای زمانی که پروژه‌ای وجود ندارد
- Responsive design برای تمام اندازه‌های صفحه

## 🚀 نحوه استفاده

### اجرای برنامه (Mock Mode)
```bash
flutter run
```

### اتصال به Supabase
1. فایل `lib/services/supabase_service.dart` را باز کنید
2. URL و کلید Supabase خود را وارد کنید:
```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```
3. در `lib/providers/project_provider.dart`، `MockProjectService` را با `SupabaseService` جایگزین کنید

### اضافه کردن پروژه جدید
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

## 📊 دیتابیس Supabase

### جدول `projects`
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

### نمونه داده‌ها
```sql
INSERT INTO projects (title, description, image_url, technologies, links) VALUES
(
  'همین رزومه ای که دارید مشاهده میکنید',
  'وب اپ',
  'assets/images/1752648209158.png',
  ARRAY['Flutter', 'GetX', 'Dart'],
  '{"اتصال مستقیم": "https://github.com/your-username/resume"}'
);
```

## 🎨 تم و رنگ‌ها

### رنگ‌های اصلی
- **سبز کارت‌ها**: `#E8F5E8` (روشن) / `#1B5E20` (تاریک)
- **خاکستری پروژه‌ها**: `#F0F0F0` (روشن) / `#3A3A3A` (تاریک)
- **متن اصلی**: `#333333` (روشن) / `#FFFFFF` (تاریک)

### Responsive Design
- استفاده از `ResponsiveHelper` برای اندازه‌های نسبی
- پشتیبانی از موبایل، تبلت و دسکتاپ
- قفل شدن به حالت عمودی

## 🔄 State Management

### ProjectProvider Methods
- `loadProjects()`: بارگذاری پروژه‌ها
- `refreshProjects()`: بارگذاری مجدد
- `addProject(project)`: اضافه کردن پروژه
- `updateProject(project)`: به‌روزرسانی پروژه
- `deleteProject(id)`: حذف پروژه
- `filterProjectsByTechnology(tech)`: فیلتر بر اساس تکنولوژی

### State Properties
- `projects`: لیست پروژه‌ها
- `isLoading`: وضعیت بارگذاری
- `error`: پیام خطا
- `hasError`: وجود خطا
- `projectCount`: تعداد پروژه‌ها

## 📱 UI Components

### ProjectsSection
- `_buildLoadingWidget()`: نمایش loading
- `_buildErrorWidget()`: نمایش خطا
- `_buildEmptyWidget()`: نمایش خالی
- `_buildProjectsList()`: نمایش لیست پروژه‌ها

### ProjectItem
- نمایش اطلاعات پروژه
- دکمه‌های اتصال
- تگ‌های تکنولوژی
- تصویر پروژه

## 🛠️ توسعه و نگهداری

### اضافه کردن ویژگی جدید
1. مدل داده را در `ProjectModel` اضافه کنید
2. سرویس را در `MockProjectService` یا `SupabaseService` به‌روزرسانی کنید
3. Provider را برای مدیریت state جدید تغییر دهید
4. UI را برای نمایش ویژگی جدید به‌روزرسانی کنید

### تست
- از `MockProjectService` برای تست استفاده کنید
- تمام state ها را تست کنید (loading، error، empty، success)
- UI را در اندازه‌های مختلف تست کنید

## 📝 نکات مهم

1. **امنیت**: کلیدهای API را در متغیرهای محیطی نگهداری کنید
2. **Performance**: از lazy loading برای تصاویر استفاده کنید
3. **Error Handling**: تمام خطاها را به درستی مدیریت کنید
4. **Responsive**: UI را در تمام اندازه‌ها تست کنید
5. **Accessibility**: از semantic labels استفاده کنید
