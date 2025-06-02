import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceTile extends StatelessWidget {
  const ServiceTile({
    super.key,
    required this.serviceName,
    required this.serviceDescription,
    required this.duration,
    required this.price,
    required this.isSelected,
    required this.shadowColor,
    this.tileColor,
    required this.borderColor,
    this.borderWidth = 1.0,
    this.onTap,
  });

  final String serviceName;
  final String serviceDescription;
  final int duration;
  final double price;
  final bool isSelected;
  final Color? tileColor;
  final Color borderColor;
  final double borderWidth;
  final Color shadowColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tileColor,
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(serviceName,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: WColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text(serviceDescription, style: const TextStyle(color: WColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text("Duration: $duration min", style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            const SizedBox(width: 6),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: WColors.textPrimary)),
                if (isSelected)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Icon(Icons.check_circle, color: WColors.onPrimary, size: 25),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
