import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/profile/controller/profile_controller.dart';
import 'package:axilo/features/profile/ui/widget/profile_image_widget.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: customAppBar(onLeadingIconPressed: () => Get.back(), appBarTitle: 'Your Profile'),
      body: SingleChildScrollView(
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Obx(() {
                  return ProfileImageWidget(
                      image: user.profileImage == null && profileController.selectedImage.value == null
                          ? Image.asset(WImages.profile_pic, fit: BoxFit.cover)
                          : profileController.selectedImage.value != null
                              ? Image.file(profileController.selectedImage.value!, fit: BoxFit.cover)
                              : CachedNetworkImage(
                                  imageUrl: user.profileImage!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                      child: LoadingAnimationWidget.dotsTriangle(color: WColors.onPrimary, size: 35)),
                                  errorWidget: (context, url, error) => const Icon(
                                        Icons.broken_image,
                                        color: WColors.black,
                                      )),
                      onTap: () => _showImagePickerOptions(context));
                }),
                const SizedBox(height: 20),
                _buildLabel("Name"),
                _buildTextField(profileController.nameController, hint: 'Enter name'),
                _buildLabel("Phone Number"),
                _buildTextField(profileController.phoneController, hint: 'Enter phone', isPhone: true),
                _buildLabel("Email"),
                _buildTextField(profileController.emailController, hint: 'Enter email', enabled: false),
              ],
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomSafeArea(
        child: BottomButton(
            onPressed: () async {
              Get.dialog(
                Center(
                  child: LoadingAnimationWidget.dotsTriangle(
                    color: WColors.onPrimary,
                    size: 40,
                  ),
                ),
                barrierDismissible: false,
              );
              await profileController.validateFields().then((val) {
                Get.back();
                CommonMethods.showSuccessSnackBar('Success', 'Profile updated successfully.');
              });
            },
            buttonChild:
                Text("Update", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500))),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 6),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: WColors.textPrimary))),
    );
  }

  Widget _buildTextField(TextEditingController controller, {String? hint, bool enabled = true, bool isPhone = false}) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: WColors.textPrimary),
      keyboardType: isPhone ? TextInputType.phone : null,
      inputFormatters: isPhone ? [LengthLimitingTextInputFormatter(10)] : null,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        enabled: enabled,
        fillColor: Colors.grey.shade200,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) {
        return BottomSafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: SvgPicture.asset(WImages.gallery,
                    colorFilter: ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn)),
                title: const Text('Gallery', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  profileController.pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading:
                    SvgPicture.asset(WImages.camera, colorFilter: ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn)),
                title: const Text('Camera', style: TextStyle(fontWeight: FontWeight.w500)),
                onTap: () {
                  Navigator.pop(context);
                  profileController.pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
