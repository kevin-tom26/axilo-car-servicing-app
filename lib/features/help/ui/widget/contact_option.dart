import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ContactOption extends StatelessWidget {
  const ContactOption({
    super.key,
    required this.iconImg,
    required this.label,
  });

  final String iconImg;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 80,
        //margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: WColors.offWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: WColors.onPrimaryBackground,
                  image: DecorationImage(
                      image: AssetImage(iconImg),
                      scale: 2.9,
                      colorFilter: ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn))),
            ),
            SizedBox(height: 4),
            Text(label, style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w500)),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
