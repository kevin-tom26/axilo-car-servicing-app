import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/home/ui/widget/car_wash_card_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarWashSection extends StatelessWidget {
  const CarWashSection(
      {super.key, required this.carouselContoller, required this.serviceProviderList, required this.onCardTap});

  final CarouselSliderController carouselContoller;
  final List<CarWashModel> serviceProviderList;

  final void Function(CarWashModel)? onCardTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
        ),
        child: CarouselSlider.builder(
          carouselController: carouselContoller,
          itemCount: serviceProviderList.take(3).length,
          options: CarouselOptions(
            disableCenter: true,
            padEnds: false,
            initialPage: 0,
            //height: Get.height * 0.26 < 214.61 ? 214.62 : Get.height * 0.26,
            aspectRatio: 15 / 8.9,
            viewportFraction: 0.9,
            enableInfiniteScroll: false,
          ),
          itemBuilder: (_, index, realIndex) {
            final carWashItem = serviceProviderList[index];
            return CarWashCardWidget(
                //screenHeight: Get.height,
                context: context,
                onTap: () => onCardTap?.call(carWashItem),
                image: carWashItem.thumbnail,
                name: carWashItem.name,
                distance: carWashItem.distance,
                address: carWashItem.address,
                waitTime: carWashItem.waitTime.toDouble(),
                minPrice: carWashItem.minPrice,
                maxPrice: carWashItem.maxPrice,
                rating: carWashItem.rating);
          },
        ),
      ),
    );
  }
}
