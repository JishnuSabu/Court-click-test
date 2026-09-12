import 'package:court_click_task/utils/constants.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: AppColors.black,
      selectedItemColor: AppColors.white,
      unselectedItemColor: AppColors.mediumGrey,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          activeIcon: Icon(Icons.search_rounded),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Badge(
            label: Text('4'),
            backgroundColor: AppColors.netflixRed,
            child: Icon(Icons.video_library_outlined),
          ),
          activeIcon: Badge(
            label: Text('4'),
            backgroundColor: AppColors.netflixRed,
            child: Icon(Icons.video_library),
          ),
          label: 'Coming Soon',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.file_download_outlined),
          activeIcon: Icon(Icons.file_download),
          label: 'Downloads',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          activeIcon: Icon(Icons.menu_open),
          label: 'More',
        ),
      ],
    );
  }
}
