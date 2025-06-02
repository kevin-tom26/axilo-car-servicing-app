import 'package:axilo/common/widgets/custom_search_bar/custom_search_bar.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/bookmark/controller/bookmark_controller.dart';
import 'package:axilo/features/bookmark/ui/widgets/category_filter.dart';
import 'package:axilo/features/common/ui/widget/car_service_card.dart';
import 'package:axilo/routes.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookmarkController bookmarkController = Get.find<BookmarkController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WColors.primary,
        leadingWidth: 70,
        automaticallyImplyLeading: false,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text('Bookmark',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: WColors.textPrimary, fontWeight: FontWeight.w500)),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [customSearch(), SizedBox(height: 8), CategoryFilter()],
            )),
        toolbarHeight: 180,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        bool loading = bookmarkController.isBookMarkedListLoading.value;
        List<CarWashModel> filteredBookmarkedList = bookmarkController.filteredBookmarkedList;

        if (loading) {
          return Center(
              child: LoadingAnimationWidget.dotsTriangle(
            color: WColors.onPrimary,
            size: 40,
          ));
        }

        if (!loading && filteredBookmarkedList.isEmpty) {
          return Center(
            child: Text("No items bookmarked !!",
                style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 18)),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(top: 6),
          itemCount: filteredBookmarkedList.length,
          itemBuilder: (context, index) {
            final service = filteredBookmarkedList[index];
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
    );
  }

  Widget customSearch() {
    final BookmarkController bookmarkController = Get.find<BookmarkController>();
    return CustomSerachBar<CarWashModel>(
        hintText: 'Search',
        borderEnabled: true,
        suggestionsCallback: (query) {
          return query.isEmpty
              ? bookmarkController.filteredBookmarkedList
              : bookmarkController.filteredSearchServiceList(query, bookmarkController.filteredBookmarkedList);
        },
        itemBuilder: (context, service) => ListTile(title: Text(service.name)),
        onSelected: (bookmark) {
          bookmarkController.setSelectedService(bookmark);
        },
        onControllerReady: (controller) {
          bookmarkController.searchController = controller;
        });
  }
}
