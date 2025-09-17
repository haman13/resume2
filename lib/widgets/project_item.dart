// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import '../theme.dart';
import 'package:resume/utils/responsive_helper.dart';

class ProjectItem extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final List<String> technologies;
  final Map<String, VoidCallback> links;

  const ProjectItem({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.technologies,
    this.links = const {},
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.borderColor(context)),
        borderRadius: BorderRadius.circular(
          ResponsiveHelper.isMobile(context)
              ? ResponsiveHelper.getProportionateSpacing(1.0)
              : 8,
        ),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(
                  ResponsiveHelper.isMobile(context)
                      ? ResponsiveHelper.getProportionateSpacing(4.0)
                      : 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.isMobile(context)
                            ? ResponsiveHelper.getProportionateFontSize(1.6)
                            : 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary(context),
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveHelper.isMobile(context)
                          ? ResponsiveHelper.getProportionateSpacing(1.2)
                          : 8,
                    ),
                    Text(
                      description,
                      style: TextStyle(
                        color: AppTheme.textPrimary(context),
                        fontSize: ResponsiveHelper.isMobile(context)
                            ? ResponsiveHelper.getProportionateFontSize(1.2)
                            : 14,
                      ),
                    ),
                    SizedBox(
                      height: ResponsiveHelper.isMobile(context)
                          ? ResponsiveHelper.getProportionateSpacing(2.0)
                          : 16,
                    ),
                    Wrap(
                      spacing: ResponsiveHelper.isMobile(context)
                          ? ResponsiveHelper.getProportionateSpacing(1.0)
                          : 8,
                      runSpacing: ResponsiveHelper.isMobile(context)
                          ? ResponsiveHelper.getProportionateSpacing(1.0)
                          : 8,
                      children: technologies
                          .map((tech) => Chip(
                                label: Text(
                                  tech,
                                  style: TextStyle(
                                    color: AppTheme.textPrimary(context),
                                    fontSize: ResponsiveHelper.isMobile(context)
                                        ? ResponsiveHelper.getProportionateFontSize(1.0)
                                        : 12,
                                  ),
                                ),
                                backgroundColor:
                                    AppTheme.projectChipBackground(context),
                              ))
                          .toList(),
                    ),
                    if (links.isNotEmpty) ...[
                      SizedBox(
                        height: ResponsiveHelper.isMobile(context)
                            ? ResponsiveHelper.getProportionateSpacing(2.0)
                            : 16,
                      ),
                      Row(
                        children: links.entries
                            .map(
                              (entry) => Padding(
                                padding: EdgeInsets.only(
                                  left: ResponsiveHelper.isMobile(context)
                                      ? ResponsiveHelper.getProportionateSpacing(1.0)
                                      : 8,
                                ),
                                child: TextButton(
                                  onPressed: entry.value,
                                  child: Text(
                                    entry.key,
                                    style: TextStyle(
                                      color: AppTheme.textPrimary(context),
                                      fontSize: ResponsiveHelper.isMobile(context)
                                          ? ResponsiveHelper.getProportionateFontSize(1.2)
                                          : 14,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(
                    ResponsiveHelper.isMobile(context)
                        ? ResponsiveHelper.getProportionateSpacing(1.0)
                        : 8,
                  ),
                ),
                child: _buildProjectImage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    // بررسی اینکه آیا image یک URL است یا مسیر فایل محلی
    final isNetworkImage = image.startsWith('http://') || image.startsWith('https://');
    
    if (isNetworkImage) {
      return Image.network(
        image,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.projectCardBackground(context),
                  AppTheme.projectCardBackground(context).withOpacity(0.7),
                ],
              ),
            ),
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                    : null,
                color: AppTheme.textPrimary(context),
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          print('خطا در بارگذاری تصویر: $error');
          print('URL: $image');
          return _buildErrorImage();
        },
      );
    } else {
      return Image.asset(
        image,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorImage();
        },
      );
    }
  }

  Widget _buildErrorImage() {
    return Builder(
      builder: (context) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.projectCardBackground(context),
              AppTheme.projectCardBackground(context).withOpacity(0.7),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.textGrey(context).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.work_outline,
                size: 32,
                color: AppTheme.textGrey(context),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'پروژه',
              style: TextStyle(
                color: AppTheme.textGrey(context),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'تصویر در دسترس نیست',
              style: TextStyle(
                color: AppTheme.textGrey(context).withOpacity(0.7),
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
