import 'package:court_click_task/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialShareIcon extends StatelessWidget {
  final String? img;
  final IconData? icon;
  final String? label;
  final VoidCallback onTap;

  const SocialShareIcon({
    super.key,
    this.img,
    this.icon,
    this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 36,
            height: 36,
            child: Center(
              child: img != null
                  ? SvgPicture.asset(img!, width: 36, height: 36)
                  : Icon(icon, size: 32, color: AppColors.white),
            ),
          ),
          label != null
              ? Text(
                  label!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
