import 'package:axilo/common/widgets/custom_search_bar/custom_search_bar.dart';
import 'package:axilo/core/local/local_data.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/home/controller/home_controller.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppbarSection extends StatelessWidget {
  HomeAppbarSection({
    super.key,
    //required this.context,
    required this.searchController,
  });

  //final BuildContext context;
  final TextEditingController searchController;
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //expandedHeight: Get.height * 0.25,
      toolbarHeight: 208,
      //Get.height * 0.25,
      pinned: true,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage(WImages.appBarCar),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(WColors.textPrimary.withOpacity(0.5), BlendMode.colorBurn)),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16))),
          child: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Get.width * 0.035, vertical: Get.width * 0.035),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                            ),
                            Expanded(
                              child: Obx(() => Text(
                                    homeController.currentPlaceName.value,
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  )),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.notification_screen);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                                child: const Icon(
                                  Icons.notifications_on_outlined,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.profile_screen);
                              },
                              child: Padding(
                                padding: EdgeInsets.only(left: Get.width * 0.035),
                                child: const Icon(
                                  Icons.person_2_outlined,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Welcome, ${LocalData().userName}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: CustomSerachBar<CarWashModel>(
                              hintText: 'Search',
                              marginEnabled: false,
                              hintStyle: TextStyle(color: WColors.darkGrey),
                              fillColor: WColors.lightContainer,
                              suggestionsCallback: (query) {
                                return query.isEmpty
                                    ? homeController.featuredServices
                                    : homeController.filteredSearchServiceList(query, homeController.featuredServices);
                              },
                              itemBuilder: (context, service) => ListTile(title: Text(service.name)),
                              onSelected: (service) {
                                homeController.setSelectedService(service);
                              },
                              onControllerReady: (controller) {
                                homeController.searchController = controller;
                              })
                          // TextField(
                          //   controller: searchController,
                          //   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          //         color: WColors.textPrimary,
                          //       ),
                          //   decoration: const InputDecoration(
                          //       prefixIcon: Icon(Icons.search_rounded),
                          //       hintText: "Search",
                          //       hintStyle: TextStyle(color: WColors.darkGrey)),
                          // ),
                          ),
                      Container(
                        decoration: BoxDecoration(
                            color: WColors.buttonBlack,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: WColors.pureblack)),
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(left: 8),
                        child: Image.asset(
                          WImages.tunes,
                          color: WColors.primary,
                          scale: 2.5,
                        ),
                      )
                    ],
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
