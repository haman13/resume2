import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/expandable_card.dart';
import '../widgets/project_item.dart';
import '../utils/responsive_helper.dart';
import '../theme.dart';
import '../providers/project_provider.dart';
import '../models/project_model.dart';


class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  @override
  void initState() {
    super.initState();
    // بارگذاری پروژه‌ها هنگام شروع
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectProvider>().loadProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProjectProvider>(
      builder: (context, projectProvider, child) {
    return Container(
      child: Column(
        children: [
          ExpandableCard(
          title: 'پروژه‌ها',
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
        padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
            CircularProgressIndicator(
              color: AppTheme.textPrimary(context),
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.6)),
            Text(
              'در حال بارگذاری پروژه‌ها...',
              style: TextStyle(
                color: AppTheme.textPrimary(context),
                fontSize: ResponsiveHelper.getProportionateFontSize(1.4),
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
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              Icons.error_outline,
              color: AppTheme.textGrey(context),
              size: 48,
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.6)),
            Text(
              projectProvider.error ?? 'خطا در بارگذاری پروژه‌ها',
              style: TextStyle(
                color: AppTheme.textGrey(context),
                fontSize: ResponsiveHelper.getProportionateFontSize(1.4),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.6)),
            ElevatedButton(
              onPressed: () => projectProvider.refreshProjects(),
              child: Text('تلاش مجدد'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(
              Icons.folder_open_outlined,
              color: AppTheme.textGrey(context),
              size: 48,
            ),
            SizedBox(height: ResponsiveHelper.getProportionateSpacing(1.6)),
            Text(
              'هیچ پروژه‌ای یافت نشد',
              style: TextStyle(
                color: AppTheme.textGrey(context),
                fontSize: ResponsiveHelper.getProportionateFontSize(1.4),
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
    return ProjectItem(
      title: project.title,
      description: project.description,
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
