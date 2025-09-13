import 'package:flutter/foundation.dart';
import '../models/project_model.dart';
import '../services/supabase_service.dart';

/// Provider برای مدیریت state پروژه‌ها
class ProjectProvider extends ChangeNotifier {
  final SupabaseService _projectService = SupabaseService.instance;
  
  List<ProjectModel> _projects = [];
  bool _isLoading = false;
  String? _error;

  /// لیست پروژه‌ها
  List<ProjectModel> get projects => _projects;

  /// وضعیت بارگذاری
  bool get isLoading => _isLoading;

  /// پیام خطا
  String? get error => _error;

  /// آیا خطایی وجود دارد؟
  bool get hasError => _error != null;

  /// تعداد پروژه‌ها
  int get projectCount => _projects.length;

  /// دریافت پروژه بر اساس ID
  ProjectModel? getProjectById(String id) {
    try {
      return _projects.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }

  /// بارگذاری پروژه‌ها از Supabase
  Future<void> loadProjects() async {
    _setLoading(true);
    _clearError();

    try {
      _projects = await _projectService.getActiveProjects();
      notifyListeners();
    } catch (e) {
      _setError('خطا در بارگذاری پروژه‌ها: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// بارگذاری پروژه‌ها برای زبان مشخص شده
  Future<void> loadProjectsForLanguage(String languageCode) async {
    _setLoading(true);
    _clearError();

    try {
      _projects = await _projectService.getProjectsForLanguage(languageCode);
      notifyListeners();
    } catch (e) {
      _setError('خطا در بارگذاری پروژه‌ها برای زبان $languageCode: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// تست اتصال به دیتابیس
  Future<bool> testDatabaseConnection() async {
    try {
      return await _projectService.testConnection();
    } catch (e) {
      _setError('خطا در اتصال به دیتابیس: $e');
      return false;
    }
  }

  /// بارگذاری مجدد پروژه‌ها
  Future<void> refreshProjects() async {
    await loadProjects();
  }

  /// اضافه کردن پروژه جدید
  Future<bool> addProject(ProjectModel project) async {
    _setLoading(true);
    _clearError();

    try {
      final newProject = await _projectService.addProject(project);
      if (newProject != null) {
        _projects.insert(0, newProject);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError('خطا در اضافه کردن پروژه: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// به‌روزرسانی پروژه
  Future<bool> updateProject(ProjectModel project) async {
    _setLoading(true);
    _clearError();

    try {
      final updatedProject = await _projectService.updateProject(project);
      if (updatedProject != null) {
        final index = _projects.indexWhere((p) => p.id == project.id);
        if (index != -1) {
          _projects[index] = updatedProject;
          notifyListeners();
        }
        return true;
      }
      return false;
    } catch (e) {
      _setError('خطا در به‌روزرسانی پروژه: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// حذف پروژه
  Future<bool> deleteProject(String id) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await _projectService.deleteProject(id);
      if (success) {
        _projects.removeWhere((project) => project.id == id);
        notifyListeners();
      }
      return success;
    } catch (e) {
      _setError('خطا در حذف پروژه: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// فیلتر کردن پروژه‌ها بر اساس تکنولوژی
  Future<void> filterProjectsByTechnology(String technology) async {
    _setLoading(true);
    _clearError();

    try {
      _projects = await _projectService.getProjectsByFilter(
        technology: technology,
        isActive: true,
      );
      notifyListeners();
    } catch (e) {
      _setError('خطا در فیلتر کردن پروژه‌ها: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// پاک کردن فیلتر و نمایش تمام پروژه‌ها
  Future<void> clearFilter() async {
    await loadProjects();
  }

  /// تنظیم وضعیت بارگذاری
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// تنظیم خطا
  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  /// پاک کردن خطا
  void _clearError() {
    _error = null;
    notifyListeners();
  }

  /// پاک کردن تمام داده‌ها
  void clear() {
    _projects.clear();
    _isLoading = false;
    _error = null;
    notifyListeners();
  }
}
