import 'package:flutter/material.dart';
import 'package:resume/utils/responsive_helper.dart';
import 'package:resume/theme.dart';

class ExpandableCard extends StatefulWidget {
  final String title;
  final Widget child;
  final bool initiallyExpanded;
  final Function(bool)? onExpansionChanged;
  final Color? backgroundColor; // رنگ زمینه سفارشی کارت

  const ExpandableCard({
    super.key,
    required this.title,
    required this.child,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.backgroundColor,
  });

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.backgroundColor ?? AppTheme.cardBackgroundColor(context),
      surfaceTintColor: Colors.transparent,
      elevation: 2,
      margin: EdgeInsets.only(
        bottom: ResponsiveHelper.isMobile(context)
            ? ResponsiveHelper.getProportionateSpacing(2.0)
            : 16,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() => _isExpanded = !_isExpanded);
              widget.onExpansionChanged?.call(_isExpanded);
            },
            child: Padding(
              padding: EdgeInsets.all(
                ResponsiveHelper.isMobile(context)
                    ? ResponsiveHelper.getProportionateSpacing(4.0)
                    : 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    // NOTE(desktop): نسبت فونت تیتر کارت‌ها در دسکتاپ نهایی شده
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getProportionateFontSize(1.5),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary(context),
                      ),
                    ),
                  ),
                  RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: AppTheme.iconMuted(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // نمایش محتوا با انیمیشن نرم
          AnimatedCrossFade(
            duration: AppTheme.normal,
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.fromLTRB(
                ResponsiveHelper.isMobile(context)
                    ? ResponsiveHelper.getProportionateSpacing(4.0)
                    : 16,
                0,
                ResponsiveHelper.isMobile(context)
                    ? ResponsiveHelper.getProportionateSpacing(4.0)
                    : 16,
                ResponsiveHelper.isMobile(context)
                    ? ResponsiveHelper.getProportionateSpacing(4.0)
                    : 16,
              ),
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }
}
