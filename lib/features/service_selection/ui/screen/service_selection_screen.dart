import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/service_selection/controller/service_selection_controller.dart';
import 'package:axilo/features/service_selection/ui/widget/service_tile.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceSelectionScreen extends StatelessWidget {
  ServiceSelectionScreen({super.key});

  final ServiceSelectionController serviceSelectionController = Get.put(ServiceSelectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(onLeadingIconPressed: () => Get.back(), appBarTitle: 'Select Services'),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 6),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                serviceSelectionController.serviceProviderName.value,
                style: const TextStyle(fontSize: 18, color: WColors.darkerGrey, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: serviceSelectionController.serviceList.length,
              itemBuilder: (context, index) {
                final service = serviceSelectionController.serviceList[index];
                return Obx(() {
                  final isSelected = serviceSelectionController.isSelectedService(service);
                  return ServiceTile(
                      onTap: () => serviceSelectionController.toggleService(service, service.price, service.duration),
                      tileColor: isSelected ? WColors.onPrimaryBackground : Colors.white,
                      borderColor: isSelected ? WColors.onPrimary : Colors.grey.shade300,
                      borderWidth: isSelected ? 1.5 : 1,
                      shadowColor: isSelected ? WColors.onPrimary.withOpacity(0.2) : Colors.black.withOpacity(0.15),
                      serviceName: service.name,
                      serviceDescription: service.description,
                      duration: service.duration,
                      price: service.price,
                      isSelected: isSelected);
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomSafeArea(
        child: Obx(() {
          return BottomButton(
              onPressed: serviceSelectionController.selectedServices.isEmpty
                  ? null
                  : () {
                      Get.toNamed(AppRoutes.car_selection);
                    },
              topChildWidget: Row(
                children: [
                  const Text("Total:", style: TextStyle(fontSize: 16, color: WColors.textPrimary)),
                  const Spacer(),
                  Text("\$${serviceSelectionController.total.value.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: WColors.textPrimary)),
                ],
              ),
              buttonChild: Text(
                "Continue",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: serviceSelectionController.selectedServices.isEmpty
                        ? WColors.darkerGrey
                        : WColors.textSecondary,
                    fontWeight: FontWeight.w500),
              ));
        }),
      ),
    );
  }
}
