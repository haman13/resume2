-- ایجاد جدول projects در Supabase
CREATE TABLE IF NOT EXISTS projects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  
  -- اطلاعات فارسی
  title VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  
  -- اطلاعات انگلیسی
  title_en VARCHAR(255),
  description_en TEXT,
  
  -- اطلاعات مشترک
  image_url TEXT NOT NULL,
  technologies TEXT[] NOT NULL DEFAULT '{}',
  links JSONB NOT NULL DEFAULT '{}',
  
  -- متادیتا
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  is_active BOOLEAN DEFAULT true,
  
  -- محدودیت‌ها
  CONSTRAINT projects_title_check CHECK (char_length(title) > 0),
  CONSTRAINT projects_description_check CHECK (char_length(description) > 0)
);

-- ایندکس‌ها برای بهبود عملکرد
CREATE INDEX IF NOT EXISTS idx_projects_active ON projects(is_active);
CREATE INDEX IF NOT EXISTS idx_projects_created_at ON projects(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_projects_technologies ON projects USING GIN(technologies);

-- تریگر برای به‌روزرسانی خودکار updated_at
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

DROP TRIGGER IF EXISTS update_projects_updated_at ON projects;
CREATE TRIGGER update_projects_updated_at 
    BEFORE UPDATE ON projects 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- داده‌های نمونه
INSERT INTO projects (title, description, title_en, description_en, image_url, technologies, links) VALUES
(
  'سیستم مدیریت رزومه آنلاین',
  'یک پلتفرم کامل برای ایجاد و مدیریت رزومه‌های آنلاین با قابلیت‌های پیشرفته و رابط کاربری مدرن',
  'Online Resume Management System',
  'A comprehensive platform for creating and managing online resumes with advanced features and modern UI',
  'https://example.com/resume-system.jpg',
  ARRAY['Flutter', 'Dart', 'Supabase', 'PostgreSQL', 'Responsive Design'],
  '{"demo": "https://demo.example.com", "github": "https://github.com/example/resume-system", "website": "https://resume.example.com"}'::jsonb
),
(
  'اپلیکیشن موبایل فروشگاه',
  'اپلیکیشن فروشگاهی کامل با قابلیت‌های خرید، پرداخت، مدیریت موجودی و پنل ادمین',
  'Mobile E-commerce App',
  'Complete e-commerce application with shopping, payment, inventory management and admin panel features',
  'https://example.com/ecommerce-app.jpg',
  ARRAY['Flutter', 'Dart', 'Firebase', 'Stripe', 'State Management'],
  '{"playstore": "https://play.google.com/store/apps/details?id=com.example.shop", "github": "https://github.com/example/ecommerce-app"}'::jsonb
),
(
  'وب‌سایت شرکتی',
  'وب‌سایت شرکتی مدرن و ریسپانسیو با قابلیت‌های SEO، مدیریت محتوا و پنل ادمین',
  'Corporate Website',
  'Modern and responsive corporate website with SEO capabilities, content management and admin panel',
  'https://example.com/corporate-website.jpg',
  ARRAY['React', 'Next.js', 'TypeScript', 'Tailwind CSS', 'Strapi'],
  '{"website": "https://company.example.com", "github": "https://github.com/example/corporate-website"}'::jsonb
),
(
  'سیستم مدیریت پروژه',
  'پلتفرم جامع برای مدیریت پروژه‌ها، تیم‌ها و وظایف با قابلیت‌های همکاری و گزارش‌گیری',
  'Project Management System',
  'Comprehensive platform for managing projects, teams and tasks with collaboration and reporting features',
  'https://example.com/project-management.jpg',
  ARRAY['Vue.js', 'Node.js', 'MongoDB', 'Socket.io', 'JWT'],
  '{"demo": "https://pm.example.com", "github": "https://github.com/example/project-management"}'::jsonb
),
(
  'اپلیکیشن یادگیری آنلاین',
  'پلتفرم آموزش آنلاین با قابلیت‌های ویدیو، آزمون، گواهینامه و مدیریت دوره‌ها',
  'Online Learning Platform',
  'Online education platform with video capabilities, quizzes, certificates and course management',
  'https://example.com/learning-platform.jpg',
  ARRAY['React Native', 'Node.js', 'PostgreSQL', 'AWS S3', 'Redis'],
  '{"appstore": "https://apps.apple.com/app/learning-platform", "website": "https://learn.example.com"}'::jsonb
);

-- نمایش داده‌های اضافه شده
SELECT 
  id,
  title,
  title_en,
  technologies,
  created_at
FROM projects 
WHERE is_active = true 
ORDER BY created_at DESC;
