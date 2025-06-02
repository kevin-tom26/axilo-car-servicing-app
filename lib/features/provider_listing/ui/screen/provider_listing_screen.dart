import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/common/widgets/custom_search_bar/custom_search_bar.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/provider_listing/controller/provider_listing_controller.dart';
import 'package:axilo/features/common/ui/widget/car_service_card.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProviderListingScreen extends StatelessWidget {
  ProviderListingScreen({super.key});

  final ProviderListingController providerListingController = Get.put(ProviderListingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WColors.primary,
        leading: IconButton.filled(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            WImages.back24,
            scale: 1.1,
          ),
          style: IconButton.styleFrom(
              backgroundColor: WColors.primary, side: const BorderSide(color: WColors.mainContainer)),
        ),
        leadingWidth: 70,
        automaticallyImplyLeading: false,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Obx(() => Text(providerListingController.heading.value,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: WColors.textPrimary, fontWeight: FontWeight.w500))),
        bottom: PreferredSize(preferredSize: Size.fromHeight(0), child: customSearch()),
        toolbarHeight: 128,
      ),
      backgroundColor: Colors.white,
      body: BottomSafeArea(
        child: Obx(() {
          bool isLoading = providerListingController.loading.value;
          List<CarWashModel> filteredList = providerListingController.filteredList;
          bool nearbyLocationPermissionDenied =
              providerListingController.isLocationPermissionDenied.value && providerListingController.fromNearBy.value;
          if (isLoading) {
            return Center(
                child: LoadingAnimationWidget.dotsTriangle(
              color: WColors.onPrimary,
              size: 40,
            ));
          }

          if (!isLoading && filteredList.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                child: Text(
                    maxLines: 2,
                    nearbyLocationPermissionDenied
                        ? "Please enable GPS and Location Permission"
                        : "No service available !!",
                    style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 16)),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 12),
            itemCount: providerListingController.filteredList.length,
            itemBuilder: (context, index) {
              final service = providerListingController.filteredList[index];
              return ServiceCard(
                id: service.id,
                name: service.name,
                rating: service.rating,
                distance: service.distance,
                waitTime: service.waitTime,
                minPrice: service.minPrice,
                maxPrice: service.maxPrice,
                imagePath: service.thumbnail,
                onTap: () => Get.toNamed(AppRoutes.car_wash_detail, arguments: {'car_wash_model': service}),
              );
            },
          );
        }),
      ),
    );
  }

  Widget customSearch() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: CustomSerachBar<CarWashModel>(
          hintText: 'Search',
          borderEnabled: true,
          suggestionsCallback: (query) {
            return query.isEmpty
                ? providerListingController.filteredList
                : providerListingController.filteredServiceList(query, providerListingController.filteredList);
          },
          itemBuilder: (context, service) => ListTile(title: Text(service.name)),
          onSelected: (car) {
            providerListingController.setSelectedService(car);
          },
          onControllerReady: (controller) {
            providerListingController.searchController = controller;
          }),
    );
  }
}
