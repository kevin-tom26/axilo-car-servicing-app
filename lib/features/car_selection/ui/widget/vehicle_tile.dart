import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleTile extends StatelessWidget {
  const VehicleTile(
      {super.key,
      required this.carName,
      required this.carType,
      required this.numberPlate,
      required this.isSelected,
      required this.assetColor,
      this.onTap});

  final String carName;
  final String carType;
  final String numberPlate;
  final bool isSelected;
  final Color assetColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? WColors.onPrimaryBackground : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? WColors.onPrimary : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? WColors.onPrimary.withOpacity(0.2) : Colors.black.withOpacity(0.15),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              WImages.car_top,
              width: 50,
              height: 50,
              color: assetColor,
            ), // dummy asset
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(carName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: WColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text("$carType  •  $numberPlate", style: TextStyle(color: Colors.grey.shade700)),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: WColors.onPrimary, size: 24),
          ],
        ),
      ),
    );
  }
}
