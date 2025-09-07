import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/project_model.dart';

/// سرویس اتصال به Supabase برای مدیریت پروژه‌ها
class SupabaseService {
  static SupabaseService? _instance;
  static SupabaseService get instance => _instance ??= SupabaseService._();
  
  SupabaseService._();

  late final SupabaseClient _supabase;

  /// مقداردهی اولیه Supabase
  Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://qkjlatswbxyjkdyxrsjr.supabase.co', // URL پروژه Supabase شما
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFramxhdHN3Ynh5amtkeXhyc2pyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc2NjM2MzYsImV4cCI6MjA2MzIzOTYzNn0.EU2DBkoSskYat1IkAmho6UQj1JdsZAHb5W8-wK8__Pk', // کلید عمومی Supabase شما
    );
    _supabase = Supabase.instance.client;
  }

  /// دریافت تمام پروژه‌های فعال
  Future<List<ProjectModel>> getActiveProjects() async {
    try {
      final response = await _supabase
          .from('projects')
          .select()
          .eq('is_active', true)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => ProjectModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('خطا در دریافت پروژه‌ها: $e');
      return [];
    }
  }

  /// دریافت پروژه بر اساس ID
  Future<ProjectModel?> getProjectById(String id) async {
    try {
      final response = await _supabase
          .from('projects')
          .select()
          .eq('id', id)
          .single();

      return ProjectModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('خطا در دریافت پروژه: $e');
      return null;
    }
  }

  /// اضافه کردن پروژه جدید
  Future<ProjectModel?> addProject(ProjectModel project) async {
    try {
      final response = await _supabase
          .from('projects')
          .insert(project.toJson())
          .select()
          .single();

      return ProjectModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('خطا در اضافه کردن پروژه: $e');
      return null;
    }
  }

  /// به‌روزرسانی پروژه
  Future<ProjectModel?> updateProject(ProjectModel project) async {
    try {
      final response = await _supabase
          .from('projects')
          .update(project.toJson())
          .eq('id', project.id)
          .select()
          .single();

      return ProjectModel.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      print('خطا در به‌روزرسانی پروژه: $e');
      return null;
    }
  }

  /// حذف پروژه (غیرفعال کردن)
  Future<bool> deleteProject(String id) async {
    try {
      await _supabase
          .from('projects')
          .update({'is_active': false})
          .eq('id', id);

      return true;
    } catch (e) {
      print('خطا در حذف پروژه: $e');
      return false;
    }
  }

  /// دریافت پروژه‌ها با فیلتر
  Future<List<ProjectModel>> getProjectsByFilter({
    String? technology,
    bool? isActive,
    int? limit,
  }) async {
    try {
      // استفاده از getActiveProjects برای سادگی
      var projects = await getActiveProjects();
      
      if (technology != null) {
        projects = projects.where((project) => 
          project.technologies.contains(technology)).toList();
      }
      
      if (isActive != null) {
        projects = projects.where((project) => 
          project.isActive == isActive).toList();
      }
      
      if (limit != null) {
        projects = projects.take(limit).toList();
      }
      
      return projects;
    } catch (e) {
      print('خطا در دریافت پروژه‌ها با فیلتر: $e');
      return [];
    }
  }
}