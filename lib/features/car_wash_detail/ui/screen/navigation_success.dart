import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/features/car_wash_detail/controller/car_wash_detail_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationSuccessScreen extends StatelessWidget {
  NavigationSuccessScreen({super.key});

  final CarWashDetailController carDetailController = Get.find<CarWashDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: WColors.onPrimary,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "You Have Arrived!",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  "You have arrived at the ${carDetailController.carWashModelObj.name}.",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomButton(
        onPressed: () => Get.back(),
        buttonChild: Text("Ok", style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500)),
      ),
    );
  }
}
