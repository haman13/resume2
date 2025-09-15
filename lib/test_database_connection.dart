// فایل تست برای بررسی اتصال به دیتابیس
// این فایل را در main.dart import کنید و در initState فراخوانی کنید

// ignore_for_file: avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'services/supabase_service.dart';
import 'models/project_model.dart';

class DatabaseTestHelper {
  static Future<void> testDatabaseConnection(BuildContext context) async {
    try {
      print('🔍 شروع تست اتصال به دیتابیس...');
      
      // تست اتصال
      final supabaseService = SupabaseService.instance;
      final isConnected = await supabaseService.testConnection();
      
      if (isConnected) {
        print('✅ اتصال به دیتابیس موفق است');
        
        // تست دریافت پروژه‌ها
        print('🔍 تست دریافت پروژه‌ها...');
        final projects = await supabaseService.getActiveProjects();
        print('📊 تعداد پروژه‌های دریافت شده: ${projects.length}');
        
        if (projects.isNotEmpty) {
          print('📋 لیست پروژه‌ها:');
          for (int i = 0; i < projects.length; i++) {
            final project = projects[i];
            print('  ${i + 1}. ${project.title}');
            print('     - عنوان انگلیسی: ${project.titleEn ?? "ندارد"}');
            print('     - تکنولوژی‌ها: ${project.technologies.join(", ")}');
            print('     - فعال: ${project.isActive}');
            print('');
          }
          
          // تست نمایش بر اساس زبان
          print('🌐 تست نمایش بر اساس زبان:');
          final testProject = projects.first;
          print('  فارسی: ${testProject.localizedTitle("fa")}');
          print('  انگلیسی: ${testProject.localizedTitle("en")}');
          print('  Fallback: ${testProject.getTitleWithFallback("en")}');
        } else {
          print('⚠️ هیچ پروژه‌ای یافت نشد');
        }
        
        // نمایش پیام موفقیت
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('✅ اتصال به دیتابیس موفق - ${projects.length} پروژه یافت شد'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
            ),
          );
        }
      } else {
        print('❌ خطا در اتصال به دیتابیس');
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('❌ خطا در اتصال به دیتابیس'),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      }
    } catch (e) {
      print('❌ خطا در تست دیتابیس: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ خطا در تست دیتابیس: $e'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      }
    }
  }
  
  static Future<void> addSampleProject() async {
    try {
      print('🔍 اضافه کردن پروژه نمونه...');
      
      final sampleProject = ProjectModel(
        id: '', // خالی بگذارید تا UUID خودکار تولید شود
        title: 'پروژه تست',
        description: 'این یک پروژه تست برای بررسی عملکرد سیستم است',
        titleEn: 'Test Project',
        descriptionEn: 'This is a test project to verify system functionality',
        imageUrl: 'https://via.placeholder.com/300x200?text=Test+Project',
        technologies: ['Flutter', 'Dart', 'Supabase', 'Test'],
        links: {
          'github': 'https://github.com/test/test-project',
          'demo': 'https://demo.test.com',
        },
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isActive: true,
      );
      
      final supabaseService = SupabaseService.instance;
      final result = await supabaseService.addProject(sampleProject);
      
      if (result != null) {
        print('✅ پروژه نمونه با موفقیت اضافه شد');
        print('   ID: ${result.id}');
        print('   عنوان: ${result.title}');
      } else {
        print('❌ خطا در اضافه کردن پروژه نمونه');
      }
    } catch (e) {
      print('❌ خطا در اضافه کردن پروژه نمونه: $e');
    }
  }
}
