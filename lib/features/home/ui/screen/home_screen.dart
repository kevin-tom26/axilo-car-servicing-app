import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/features/home/controller/home_controller.dart';
import 'package:axilo/features/home/ui/widget/car_wash_section.dart';
import 'package:axilo/features/home/ui/widget/car_wash_section_heading.dart';
import 'package:axilo/features/home/ui/widget/get_membership_section.dart';
import 'package:axilo/features/home/ui/widget/home_appbar_section.dart';
import 'package:axilo/features/home/ui/widget/services_section.dart';
import 'package:axilo/features/home/ui/widget/special_offer_section.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController _homeController;
  @override
  void initState() {
    _homeController = Get.find<HomeController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: homeBody(),
      ),
    );
  }

  Widget homeBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await _homeController.reloadCarServiceList();
      },
      child: CustomScrollView(
        slivers: [
          //appbar
          HomeAppbarSection(searchController: _homeController.searchController),
          screenWidgetSpacing(),

          //special offer
          SpecialOfferSection(
            offerCarouselContoller: _homeController.offerCarouselController,
            imageList: _homeController.imageList,
          ),
          screenWidgetSpacing(),

          //service categories
          ServicesSection(
            serviceIcons: LocalData.serviceCategories,
            onIconTap: (categoryName) {
              Get.toNamed(AppRoutes.provider_listing_screen, arguments: {
                'heading': categoryName,
                'isCategory': true,
              });
            },
          ),
          screenWidgetSpacing(),

          //nearby heading and carousel
          CarWashSectionHeading(
              sectionHeading: "Nearby Car Washes",
              onSeeAll: () {
                Get.toNamed(AppRoutes.provider_listing_screen, arguments: {
                  'heading': 'Nearby Car Washes',
                  'fromNearBy': true,
                });
              }),
          //
          Obx(() {
            if (_homeController.isNearByServiceLoading.value) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 214,
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: WColors.onPrimary,
                      size: 50,
                    ),
                  ),
                ),
              );
            }
            if (_homeController.isLocationPermissionDenied.value) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 180,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                    child: Text("Please enable GPS and Location Permission",
                        maxLines: 2,
                        style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 16)),
                  )),
                ),
              );
            }
            return CarWashSection(
              carouselContoller: _homeController.nearbyCarouselController,
              serviceProviderList: _homeController.nearbyServices,
              onCardTap: (carWashItem) {
                Get.toNamed(AppRoutes.car_wash_detail, arguments: {'car_wash_model': carWashItem});
              },
            );
          }),
          screenWidgetSpacing(),

          //featured heading and carousel
          CarWashSectionHeading(
              sectionHeading: "Featured Car Washes",
              onSeeAll: () {
                Get.toNamed(AppRoutes.provider_listing_screen, arguments: {
                  'heading': 'Featured Car Washes',
                  'fromNearBy': false,
                });
              }),
          //
          Obx(() {
            if (_homeController.isFeatureServiceLoading.value) {
              return SliverToBoxAdapter(
                child: SizedBox(
                  height: 214,
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: WColors.onPrimary,
                      size: 50,
                    ),
                  ),
                ),
              );
            }
            return CarWashSection(
              carouselContoller: _homeController.featuredCarouselController,
              serviceProviderList: _homeController.featuredServices,
              onCardTap: (carWashItem) {
                Get.toNamed(AppRoutes.car_wash_detail, arguments: {'car_wash_model': carWashItem});
              },
            );
          }),
          screenWidgetSpacing(),

          //get memebership
          GetMembershipSection(
            onJoinPressed: () {},
          ),
          screenWidgetSpacing(),
        ],
      ),
    );
  }

  Widget screenWidgetSpacing() {
    return SliverPadding(
      padding: EdgeInsets.zero,
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: Get.height * 0.025,
        ),
      ),
    );
  }
}
