import 'package:court_click_task/screens/widget/more_list_option.dart';
import 'package:court_click_task/screens/widget/social_share_icon.dart';
import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/image_path/img_paths.dart';
import 'splash_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = [
      {'name': 'Emenalo', 'image': ImagePaths.profile1},
      {'name': 'Onyeka', 'image': ImagePaths.profile2},
      {'name': 'Thelma', 'image': ImagePaths.profile3},
      {'name': 'Kids', 'image': ImagePaths.profile4},
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Column(
          children: [
            const SizedBox(height: 60),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  ...profiles.map((p) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              p['image'] as String,
                              width: 65,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 58,
                                  height: 58,
                                  color: AppColors.darkCard,
                                  child: const Icon(
                                    Icons.person,
                                    color: AppColors.white,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            p['name'] as String,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.only(right: 14.0),
                    child: Column(
                      children: [
                        Container(
                          width: 65,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.5),
                            border: Border.all(color: AppColors.white),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: TextButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Manage Profiles')),
                  );
                },
                icon: const Icon(Icons.edit, size: 16, color: AppColors.white),
                label: const Text(
                  'Manage Profiles',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: AppColors.darkCard),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 20,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Tell friends about Netflix.',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit quam dui, vivamusbibendum ut. A morbi mi tortor ut felis non accumsan accumsan quis. Massa,',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Terms&Conditions',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.greyText,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 37,
                          decoration: const BoxDecoration(
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 37,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white,
                            foregroundColor: AppColors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Copy Link',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SocialShareIcon(
                          img: ImagePaths.whatsappSvg,
                          onTap: () {},
                        ),
                        const VerticalDivider(
                          color: AppColors.white,
                          thickness: 0.5,
                          width: 16,
                        ),
                        SocialShareIcon(img: ImagePaths.fbSvg, onTap: () {}),
                        const VerticalDivider(
                          color: AppColors.white,
                          thickness: 0.5,
                          width: 16,
                        ),
                        SocialShareIcon(img: ImagePaths.gmailSvg, onTap: () {}),
                        const VerticalDivider(
                          color: AppColors.white,
                          thickness: 0.5,
                          width: 16,
                        ),
                        SocialShareIcon(
                          icon: Icons.more_horiz,
                          label: 'More',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            MoreListOption(
              svgPath: ImagePaths.tickSvg,
              title: 'My List',
              onTap: () {},
            ),
            const Divider(thickness: 0.7, color: AppColors.lightGrey),
            MoreListOption(title: 'App Settings', onTap: () {}),
            MoreListOption(title: 'Account', onTap: () {}),
            MoreListOption(title: 'Help', onTap: () {}),
            MoreListOption(
              title: 'Sign Out',
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const SplashScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
