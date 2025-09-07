import 'package:flutter/material.dart';
import '../theme.dart';

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
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary(context),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        color: AppTheme.textPrimary(context),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: technologies
                          .map((tech) => Chip(
                                label: Text(
                                  tech,
                                  style: TextStyle(
                                    color: AppTheme.textPrimary(context),
                                    fontSize: 12,
                                  ),
                                ),
                                backgroundColor:
                                    AppTheme.projectChipBackground(context),
                              ))
                          .toList(),
                    ),
                    if (links.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Row(
                        children: links.entries
                            .map(
                              (entry) => Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: TextButton(
                                  onPressed: entry.value,
                                  child: Text(
                                    entry.key,
                                    style: TextStyle(
                                      color: AppTheme.textPrimary(context),
                                      fontSize: 14,
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
                borderRadius:
                    const BorderRadius.horizontal(left: Radius.circular(8)),
                child: _buildProjectImage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    return Image.asset(
      image,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
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
        );
      },
    );
  }
}
