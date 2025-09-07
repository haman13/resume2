import '../models/project_model.dart';

/// سرویس Mock برای تست پروژه‌ها (بدون Supabase)
class MockProjectService {
  static MockProjectService? _instance;
  static MockProjectService get instance => _instance ??= MockProjectService._();
  
  MockProjectService._();

  /// دریافت تمام پروژه‌های فعال (Mock Data)
  Future<List<ProjectModel>> getActiveProjects() async {
    // شبیه‌سازی تاخیر شبکه
    await Future.delayed(const Duration(seconds: 1));
    
    return [
      ProjectModel(
        id: '1',
        title: 'همین رزومه ای که دارید مشاهده میکنید',
        description: 'وب اپ',
        imageUrl: 'assets/images/1752648209158.png',
        technologies: const ['Flutter', 'GetX', 'Dart'],
        links: const {
          'اتصال مستقیم': 'https://github.com/haman13/resume',
        },
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
        isActive: true,
      ),
      ProjectModel(
        id: '2',
        title: 'بازی حدس عدد',
        description: 'وب اپ',
        imageUrl: 'assets/images/1752648209158.png',
        technologies: const ['Flutter', 'GetX', 'Dart'],
        links: const {
          'اتصال مستقیم': 'https://github.com/haman13/number-guessing-game',
        },
        createdAt: DateTime.now().subtract(const Duration(days: 25)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
        isActive: true,
      ),
      ProjectModel(
        id: '3',
        title: 'برنامه نوبت دهی',
        description: 'وب اپ',
        imageUrl: 'assets/images/1752648209158.png',
        technologies: const ['Flutter', 'GetX', 'Dart'],
        links: const {
          'اتصال مستقیم': 'https://github.com/haman13/appointment-booking',
        },
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        updatedAt: DateTime.now().subtract(const Duration(days: 15)),
        isActive: true,
      ),
      ProjectModel(
        id: '4',
        title: 'فروشگاه آنلاین',
        description: 'وب اپ',
        imageUrl: 'assets/images/1752648209158.png',
        technologies: const ['Flutter', 'GetX', 'Dart'],
        links: const {
          'اتصال مستقیم': 'https://github.com/haman13/online-store',
        },
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now().subtract(const Duration(days: 20)),
        isActive: true,
      ),
      ProjectModel(
        id: '5',
        title: 'ماشین حساب',
        description: 'وب اپ',
        imageUrl: 'assets/images/1752648209158.png',
        technologies: const ['Flutter', 'GetX', 'Dart'],
        links: const {
          'اتصال مستقیم': 'https://github.com/haman13/calculator',
        },
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 25)),
        isActive: true,
      ),
    ];
  }

  /// دریافت پروژه بر اساس ID
  Future<ProjectModel?> getProjectById(String id) async {
    final projects = await getActiveProjects();
    try {
      return projects.firstWhere((project) => project.id == id);
    } catch (e) {
      return null;
    }
  }

  /// اضافه کردن پروژه جدید
  Future<ProjectModel?> addProject(ProjectModel project) async {
    // در Mock Service، فقط پروژه را برمی‌گردانیم
    await Future.delayed(const Duration(milliseconds: 500));
    return project;
  }

  /// به‌روزرسانی پروژه
  Future<ProjectModel?> updateProject(ProjectModel project) async {
    // در Mock Service، فقط پروژه را برمی‌گردانیم
    await Future.delayed(const Duration(milliseconds: 500));
    return project;
  }

  /// حذف پروژه (غیرفعال کردن)
  Future<bool> deleteProject(String id) async {
    // در Mock Service، همیشه true برمی‌گردانیم
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }

  /// دریافت پروژه‌ها با فیلتر
  Future<List<ProjectModel>> getProjectsByFilter({
    String? technology,
    bool? isActive,
    int? limit,
  }) async {
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
  }
}
