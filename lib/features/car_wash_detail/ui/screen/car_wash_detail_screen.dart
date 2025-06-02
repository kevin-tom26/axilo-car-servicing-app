import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/features/car_wash_detail/controller/car_wash_detail_controller.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/car_wash_detail/ui/widget/about_tab.dart';
import 'package:axilo/features/car_wash_detail/ui/widget/car_wash_detail_address.dart';
import 'package:axilo/features/car_wash_detail/ui/widget/car_wash_detail_appbar.dart';
import 'package:axilo/features/car_wash_detail/ui/widget/gallery_tab.dart';
import 'package:axilo/features/car_wash_detail/ui/widget/review_tab.dart';
import 'package:axilo/features/car_wash_detail/ui/widget/services_tab.dart';
import 'package:axilo/features/common/ui/widget/review_bootom_sheet.dart';
import 'package:axilo/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarWashDetailScreen extends StatelessWidget {
  CarWashDetailScreen({super.key});

  final CarWashDetailController carDetailController = Get.put(CarWashDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: [
            CarWashDetailAppBar(
              backgroundImage: carDetailController.carWashModelObj.providerImage,
              onBackPressed: () => Get.back(),
              onSharePressed: () {},
              onBookmarkPressed: () {},
            ),
            CarWashDetailAddress(
              rateAndReview:
                  '${carDetailController.carWashModelObj.rating} (${carDetailController.carWashModelObj.reviews.length})',
              shopName: carDetailController.carWashModelObj.name,
              shopAddress: carDetailController.carWashModelObj.address,
              onNavigationPressed: () {
                Get.toNamed(AppRoutes.service_map_screen);
              },
            ),
            Obx(() {
              return [
                const AboutTabHeading(),
                const ServiceTabHeading(),
                GalleryTabHeading(imageCount: carDetailController.carWashModelObj.gallery.length),
                ReviewTabHeading(onAddReview: addReviewBottomsheet)
              ][carDetailController.selectedTabIndex.value];
            }),
            Obx(() {
              return [
                AboutTab(
                  aboutText: carDetailController.carWashModelObj.about,
                  providerImage: carDetailController.carWashModelObj.providerImage,
                  providerName: carDetailController.carWashModelObj.providerName,
                  providerPosition: carDetailController.carWashModelObj.providerType,
                  onPhonePressed: () {},
                  onSendPressed: () {},
                ),
                ServiceTab(
                  serviceCategoryList: carDetailController.carWashModelObj.services,
                ),
                GalleryTab(galleryList: carDetailController.carWashModelObj.gallery),
                ReviewTab(reviews: carDetailController.carWashModelObj.reviews)
              ][carDetailController.selectedTabIndex.value];
            }),
          ],
        ),
        bottomNavigationBar: BottomSafeArea(
          child: BottomButton(
            onPressed: () {
              Get.toNamed(AppRoutes.service_selection, arguments: {
                'providerName': carDetailController.carWashModelObj.name,
                'service_list': carDetailController.carWashModelObj.services
              });
            },
            buttonChild: Text("Book Service Now",
                style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500)),
          ),
        )
        // _bookNowButton(context),
        );
  }

  addReviewBottomsheet() {
    showReviewBottomSheet(
        carDetailController.carWashModelObj.id,
        carDetailController.carWashModelObj.name,
        carDetailController.carWashModelObj.address,
        '${carDetailController.carWashModelObj.rating} (${carDetailController.carWashModelObj.reviews.length})');
  }
}
