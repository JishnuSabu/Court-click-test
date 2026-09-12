import 'package:court_click_task/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoreListOption extends StatelessWidget {
  final String? svgPath;
  final String title;
  final VoidCallback? onTap;

  const MoreListOption({
    super.key,
    this.svgPath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (svgPath != null) ...[
              SvgPicture.asset(svgPath!, width: 24, height: 24),
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
