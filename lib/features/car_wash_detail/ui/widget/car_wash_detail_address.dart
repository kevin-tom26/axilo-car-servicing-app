import 'package:auto_size_text/auto_size_text.dart';
import 'package:axilo/features/car_wash_detail/controller/car_wash_detail_controller.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarWashDetailAddress extends StatelessWidget {
  final String rateAndReview;
  final String shopName;
  final String shopAddress;
  final void Function()? onNavigationPressed;

  CarWashDetailAddress({
    super.key,
    required this.rateAndReview,
    required this.shopName,
    required this.shopAddress,
    this.onNavigationPressed,
  });

  final CarWashDetailController carDetailController = Get.find<CarWashDetailController>();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: Get.height * 0.16,
      toolbarHeight: Get.height * 0.02,
      automaticallyImplyLeading: false,
      pinned: true,
      backgroundColor: WColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: WColors.primary,
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: Get.height * 0.025),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: WColors.darkGrey.withOpacity(0.4), borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text("Open Now",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: WColors.onPrimary, fontWeight: FontWeight.w500))),
                  const Spacer(),
                  Text.rich(
                    TextSpan(
                      children: [
                        const WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.star_rounded,
                            size: 18,
                            color: Color.fromARGB(255, 232, 211, 16),
                          ),
                        ),
                        // const WidgetSpan(child: SizedBox(width: 2)),
                        TextSpan(
                            text: rateAndReview,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: WColors.darkGrey, fontSize: 13.5, height: 1, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(shopName,
                            maxFontSize: 25,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w600, fontSize: 24, color: WColors.textPrimary)),
                        Text(shopAddress,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w500, fontSize: 15, color: WColors.darkGrey))
                      ],
                    ),
                  ),
                  IconButton.filled(
                    onPressed: onNavigationPressed,
                    icon: Image.asset(
                      WImages.send,
                      scale: 1.25,
                      color: WColors.primary,
                    ),
                    style: IconButton.styleFrom(backgroundColor: WColors.onPrimary),
                  )
                ],
              )
            ],
          ),
        ),
        expandedTitleScale: 1,
        title: Container(
            padding: EdgeInsets.only(left: Get.width * 0.038),
            decoration:
                BoxDecoration(border: Border(bottom: BorderSide(color: WColors.darkGrey.withOpacity(0.3), width: 1))),
            child: Obx(() {
              return Row(
                  children: List.generate(carDetailController.carWashTabs.length, (index) {
                return _tabItem(
                  context,
                  label: carDetailController.carWashTabs[index],
                  onTap: () => carDetailController.updateSelectedTab(index),
                  selected: carDetailController.selectedTabIndex.value == index,
                );
              }));
            })),
        titlePadding: const EdgeInsets.only(bottom: 0),
      ),
    );
  }

  Widget _tabItem(BuildContext context,
      {required String label, required bool selected, required void Function()? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: selected ? WColors.textPrimary : WColors.darkGrey,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 3,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                color: selected ? WColors.onPrimary : Colors.transparent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
