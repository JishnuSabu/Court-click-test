import 'package:court_click_task/utils/constants.dart';
import 'package:flutter/cupertino.dart';

class LoaderWidget extends StatelessWidget {
  final double width;
  final double height;
  const LoaderWidget({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Center(child: CupertinoActivityIndicator(color: AppColors.white)),
    );
  }
}
