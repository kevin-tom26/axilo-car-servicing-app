import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class DateTimeSelectorTile extends StatelessWidget {
  final String label;
  final String displayText;
  final IconData icon;
  final VoidCallback onTap;

  const DateTimeSelectorTile({
    super.key,
    required this.label,
    required this.displayText,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    displayText,
                    style: const TextStyle(
                      color: WColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Icon(icon, color: WColors.onPrimary),
          ],
        ),
      ),
    );
  }
}
