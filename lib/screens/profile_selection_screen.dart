import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constants.dart';
import '../utils/image_path/img_paths.dart';
import 'main_nav_screen.dart';

class ProfileSelectionScreen extends StatelessWidget {
  const ProfileSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profiles = [
      {'name': 'Emenalo', 'image': ImagePaths.profile1},
      {'name': 'Onyeka', 'image': ImagePaths.profile2},
      {'name': 'Thelma', 'image': ImagePaths.profile3},
      {'name': 'Kids', 'image': ImagePaths.profile4},
    ];

    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.asset(ImagePaths.logo, height: 35),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.white, size: 22),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Manage Profiles clicked')),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(95.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 28,
                childAspectRatio: 0.85,
              ),
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final profile = profiles[index];
                return ProfileAvatarItem(
                  name: profile['name']!,
                  image: profile['image']!,
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => const MainNavScreen()),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ProfileAvatarItem(
                name: 'Add Profile',
                image: ImagePaths.addProfileSvg,
                isAdd: true,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Add Profile clicked')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileAvatarItem extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;
  final bool isAdd;

  const ProfileAvatarItem({
    super.key,
    required this.name,
    required this.image,
    required this.onTap,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: isAdd ? 50 : 100,
            height: isAdd ? 50 : 92,
            decoration: BoxDecoration(
              shape: isAdd ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: isAdd ? null : BorderRadius.circular(7),
              color: isAdd ? AppColors.white : Colors.transparent,
            ),
            child: isAdd
                ? ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: image.endsWith('.svg')
                          ? SvgPicture.asset(image, fit: BoxFit.contain)
                          : Image.asset(image, fit: BoxFit.contain),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.darkCard,
                          child: const Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 50,
                          ),
                        );
                      },
                    ),
                  ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
