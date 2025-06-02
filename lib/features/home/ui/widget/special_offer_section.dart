import 'package:axilo/features/home/controller/home_controller.dart';
import 'package:axilo/features/home/ui/widget/special_offer_widget.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SpecialOfferSection extends StatelessWidget {
  SpecialOfferSection({
    super.key,
    //required this.context,
    required this.offerCarouselContoller,
    required this.imageList,
  });
  //final BuildContext context;
  final CarouselSliderController offerCarouselContoller;
  final List<String> imageList;

  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    // int _activeIndex = 0;

    // void updateIndex(int index) {
    //   _activeIndex = index;
    //   //setState(() {});
    // }

    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
          //vertical: screenWidth * 0.035
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("#SpecialForYou", style: Theme.of(context).textTheme.titleLarge),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See All",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: WColors.onPrimary,
                        ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 6),
            CarouselSlider.builder(
              carouselController: offerCarouselContoller,
              itemCount: imageList.length,
              options: CarouselOptions(
                padEnds: false,
                initialPage: 0,
                aspectRatio: 15 / 7,
                viewportFraction: 0.9,
                enableInfiniteScroll: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, reason) => homeController.updateIndex(index),
              ),
              itemBuilder: (_, index, realIndex) {
                final imagePath = imageList[index];
                return SpecialOfferWidget(
                    // context: context,
                    imageString: imagePath,
                    offerTime: "Limited time",
                    offerHeading: "Get Special Offer",
                    offerPercentage: "40",
                    onTap: null);
              },
            ),
            Obx(() => AnimatedSmoothIndicator(
                  activeIndex: homeController.activeIndex.value,
                  count: imageList.length,
                  effect: const ScaleEffect(
                    activeDotColor: WColors.onPrimary,
                    dotColor: WColors.onSecondary,
                    dotWidth: 6,
                    dotHeight: 6,
                  ),
                  onDotClicked: (index) => offerCarouselContoller.animateToPage(index),
                )),
          ],
        ),
      ),
    );
  }
}
