import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/profile/controller/profile_controller.dart';
import 'package:axilo/features/profile/ui/widget/profile_image_widget.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(onLeadingIconPressed: () => Get.back(), appBarTitle: 'Profile'),
      body: BottomSafeArea(
        child: Obx(() {
          final user = profileController.currentUser.value;
          if (user == null) {
            return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: WColors.onPrimary,
                size: 40,
              ),
            );
          }
          return Column(
            children: [
              const Spacer(),
              Obx(() {
                return ProfileImageWidget(
                    image: user.profileImage == null && profileController.selectedImage.value == null
                        ? Image.asset(
                            WImages.profile_pic,
                            fit: BoxFit.cover,
                          )
                        : profileController.selectedImage.value != null
                            ? Image.file(
                                profileController.selectedImage.value!,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: user.profileImage!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                    child: LoadingAnimationWidget.dotsTriangle(color: WColors.onPrimary, size: 35)),
                                errorWidget: (context, url, error) => const Icon(
                                      Icons.broken_image,
                                      color: WColors.black,
                                    )),
                    onTap: () => Get.toNamed(AppRoutes.edit_profile_screen));
              }),
              const SizedBox(height: 10),
              Text(user.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: WColors.textPrimary)),
              const SizedBox(height: 26),
              _buildTile(
                  icon: Icons.person_outline,
                  title: 'Your Profile',
                  onTap: () => Get.toNamed(AppRoutes.edit_profile_screen)),
              _buildTile(
                  svgIcon: WImages.car,
                  title: 'My Cars',
                  onTap: () {
                    Get.toNamed(AppRoutes.car_selection, arguments: {'from_profile': true});
                  }),
              _buildTile(
                  icon: Icons.place_outlined,
                  title: 'Manage Address',
                  onTap: () {
                    Get.toNamed(AppRoutes.pick_up_addrees_screen, arguments: {'from_profile': true});
                  }),
              _buildTile(icon: Icons.settings_outlined, title: 'Settings', onTap: () {}),
              _buildTile(icon: Icons.privacy_tip_outlined, title: 'Privacy Policy', onTap: () {}),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      profileController.logout();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: WColors.onPrimary),
                    ),
                    icon: const Icon(Icons.logout, color: WColors.onPrimary),
                    label: const Text("Logout", style: TextStyle(color: WColors.onPrimary)),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildTile({IconData? icon, String? svgIcon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: icon != null
          ? Icon(icon, color: WColors.onPrimary)
          : svgIcon != null
              ? SvgPicture.asset(svgIcon,
                  width: 21, height: 21, colorFilter: const ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn))
              : null,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16,
        color: WColors.onPrimary,
      ),
      onTap: onTap,
    );
  }
}
