import 'package:court_click_task/screens/widget/notification_item.dart';
import 'package:court_click_task/utils/constants.dart';
import 'package:flutter/material.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.netflixRed,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.notifications,
                        size: 16,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(color: AppColors.lightGrey),
                child: const Column(
                  children: [
                    NotificationItem(
                      title: 'New Arrival',
                      subtitle: 'El Chapo',
                      date: 'Nov 6',
                      imageUrl: '',
                    ),
                    NotificationItem(
                      title: 'New Arrival',
                      subtitle: 'Peaky Blinders',
                      date: 'Nov 6',
                      imageUrl: '',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
