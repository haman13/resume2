/// مدل داده برای پروژه‌ها
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final Map<String, String> links;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  const ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    required this.links,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  /// تبدیل JSON به ProjectModel
  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      technologies: List<String>.from(json['technologies'] as List),
      links: Map<String, String>.from(json['links'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  /// تبدیل ProjectModel به JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'technologies': technologies,
      'links': links,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_active': isActive,
    };
  }

  /// کپی کردن با تغییرات
  ProjectModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? technologies,
    Map<String, String>? links,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      technologies: technologies ?? this.technologies,
      links: links ?? this.links,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  String toString() {
    return 'ProjectModel(id: $id, title: $title, description: $description, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
