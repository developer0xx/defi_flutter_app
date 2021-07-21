import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class MetatagsDisplay extends StatelessWidget {
  final List<String> tags;
  final Color labelColor;
  final bool removeLabel;

  const MetatagsDisplay({
    Key? key,
    required this.tags,
    this.labelColor = AppColors.textParagraph,
    this.removeLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!removeLabel)
            Text(
              context.strings.inf.summary.tags,
              style: AppText.label.copyWith(color: labelColor),
            ),
          if (!removeLabel) SizedBox(height: 4),
          Wrap(
            children: [for (final tag in tags) _buildTag(tag)],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(300),
          color: AppColors.tagBackground,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 12, top: 3, bottom: 3),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(right: 40.0),
                  child: Text(
                    tag,
                    style: AppText.label,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              ClipOval(
                child: Container(
                  height: 8,
                  width: 8,
                  color: AppColors.light,
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
