import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key, required this.image, this.onTap});

  final Widget image;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              height: 140,
              width: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                //image: DecorationImage(image: image, fit: BoxFit.cover)
              ),
              child: image,
            ),
          ),
          Positioned(
            right: 3,
            bottom: 0,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: WColors.onPrimary,
                  border: Border.all(width: 2, color: WColors.primary),
                  image: DecorationImage(
                      image: AssetImage(WImages.edit),
                      scale: 3,
                      colorFilter: ColorFilter.mode(WColors.primary, BlendMode.srcIn))),
            ),
          ),
        ],
      ),
    );
  }
}
