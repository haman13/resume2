// ignore_for_file: avoid_unnecessary_containers, avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/expandable_card.dart';
import '../widgets/project_item.dart';
import '../utils/responsive_helper.dart';
import '../theme.dart';
import '../providers/project_provider.dart';
import '../models/project_model.dart';
import '../providers/locale_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  String? _lastLanguageCode;
  bool _hasLoaded = false;

  @override
  void initState() {
    super.initState();
    // بارگذاری پروژه‌ها هنگام شروع
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProjectsBasedOnLanguage();
    });
  }

  /// بارگذاری پروژه‌ها بر اساس زبان انتخابی
  void _loadProjectsBasedOnLanguage() {
    final languageCode = context.read<LocaleProvider>().locale.languageCode;
    
    // فقط اگر زبان تغییر کرده یا هنوز بارگذاری نشده، درخواست ارسال کن
    if (!_hasLoaded || _lastLanguageCode != languageCode) {
      _lastLanguageCode = languageCode;
      _hasLoaded = true;
      context.read<ProjectProvider>().loadProjectsForLanguage(languageCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProjectProvider, LocaleProvider>(
      builder: (context, projectProvider, localeProvider, child) {
        // بررسی تغییر زبان و بارگذاری مجدد در صورت نیاز
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final currentLanguageCode = localeProvider.locale.languageCode;
          if (_lastLanguageCode != currentLanguageCode) {
            _loadProjectsBasedOnLanguage();
          }
        });

        return Container(
          child: Column(
            children: [
              ExpandableCard(
                title: AppLocalizations.of(context).projects,
                initiallyExpanded: true,
                backgroundColor: AppTheme.projectCardBackground(context),
                child: _buildProjectsContent(projectProvider),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProjectsContent(ProjectProvider projectProvider) {
    if (projectProvider.isLoading) {
      return _buildLoadingWidget();
    }

    if (projectProvider.hasError) {
      return _buildErrorWidget(projectProvider);
    }

    if (projectProvider.projects.isEmpty) {
      return _buildEmptyWidget();
    }

    return _buildProjectsList(projectProvider.projects);
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveHelper.isMobile(context)
              ? ResponsiveHelper.getProportionateSpacing(4.0)
              : 32.0,
        ),
          child: Column(
            children: [
            CircularProgressIndicator(
              color: AppTheme.textPrimary(context),
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.6)),
            Text(
              AppLocalizations.of(context).loadingProjects,
              style: TextStyle(
                color: AppTheme.textPrimary(context),
                fontSize: ResponsiveHelper.isMobile(context)
                    ? ResponsiveHelper.getProportionateFontSize(1.2)
                    : ResponsiveHelper.getProportionateFontSize(1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(ProjectProvider projectProvider) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveHelper.isMobile(context)
              ? ResponsiveHelper.getProportionateSpacing(4.0)
              : 32.0,
        ),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: AppTheme.textGrey(context),
              size: ResponsiveHelper.isMobile(context)
                  ? ResponsiveHelper.getProportionateFontSize(3.2)
                  : 48,
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.6)),
            Text(
              projectProvider.error ?? AppLocalizations.of(context).projectLoadError,
              style: TextStyle(
                color: AppTheme.textGrey(context),
                fontSize: ResponsiveHelper.isMobile(context)
                    ? ResponsiveHelper.getProportionateFontSize(1.2)
                    : ResponsiveHelper.getProportionateFontSize(1.4),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.6)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => projectProvider.refreshProjects(),
                  child: Text(AppLocalizations.of(context).retry),
                ),
                SizedBox(
                  width: ResponsiveHelper.isMobile(context)
                      ? ResponsiveHelper.getProportionateSpacing(1.0)
                      : ResponsiveHelper.getProportionateSpacing(1.6),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final isConnected = await projectProvider.testDatabaseConnection();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isConnected 
                            ? 'اتصال به دیتابیس موفق است' 
                            : 'خطا در اتصال به دیتابیس'
                        ),
                        backgroundColor: isConnected ? Colors.green : Colors.red,
                      ),
                    );
                  },
                  child: Text('تست اتصال'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(
          ResponsiveHelper.isMobile(context)
              ? ResponsiveHelper.getProportionateSpacing(4.0)
              : 32.0,
        ),
        child: Column(
          children: [
            Icon(
              Icons.folder_open_outlined,
              color: AppTheme.textGrey(context),
              size: ResponsiveHelper.isMobile(context)
                  ? ResponsiveHelper.getProportionateFontSize(3.2)
                  : 48,
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.6)),
            Text(
              AppLocalizations.of(context).noProjectsFound,
              style: TextStyle(
                color: AppTheme.textGrey(context),
                fontSize: ResponsiveHelper.isMobile(context)
                    ? ResponsiveHelper.getProportionateFontSize(1.2)
                    : ResponsiveHelper.getProportionateFontSize(1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsList(List<ProjectModel> projects) {
    return Column(
      children: [
        for (int i = 0; i < projects.length; i++) ...[
          _buildProjectItem(projects[i]),
          if (i < projects.length - 1)
              SizedBox(height: ResponsiveHelper.getProportionateSpacing(2.4)),
        ],
      ],
    );
  }

  Widget _buildProjectItem(ProjectModel project) {
    final languageCode = context.read<LocaleProvider>().locale.languageCode;
    return ProjectItem(
      title: project.getTitleWithFallback(languageCode),
      description: project.getDescriptionWithFallback(languageCode),
      image: project.imageUrl,
      technologies: project.technologies,
      links: _buildProjectLinks(project.links),
    );
  }

  Map<String, VoidCallback> _buildProjectLinks(Map<String, String> links) {
    final Map<String, VoidCallback> callbacks = {};
    
    links.forEach((key, url) {
      callbacks[key] = () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
                      await launchUrl(
            uri,
                        mode: LaunchMode.externalApplication,
                        webOnlyWindowName: '_blank',
                      );
                    }
      };
    });
    
    return callbacks;
  }
}


