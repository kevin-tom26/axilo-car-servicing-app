import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/explore/ui/widget/car_service_list_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarServiceList extends StatelessWidget {
  const CarServiceList({super.key, required this.carouselContoller, required this.serviceProviderList});

  final CarouselSliderController carouselContoller;
  final List<CarWashModel> serviceProviderList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Get.width * 0.035,
      ),
      child: CarouselSlider.builder(
        carouselController: carouselContoller,
        itemCount: serviceProviderList.take(10).length,
        options: CarouselOptions(
          disableCenter: false,
          padEnds: false,
          initialPage: 1,
          height: Get.height * 0.26,
          viewportFraction: 0.75,
          enableInfiniteScroll: false,
        ),
        itemBuilder: (_, index, realIndex) {
          final carWashItem = serviceProviderList[index];
          return CarServiceListCard(
              //screenHeight: Get.height,
              context: context,
              image: carWashItem.thumbnail,
              name: carWashItem.name,
              distance: carWashItem.distance,
              waitTime: carWashItem.waitTime.toDouble(),
              minPrice: carWashItem.minPrice,
              maxPrice: carWashItem.maxPrice,
              rating: carWashItem.rating);
        },
      ),
    );
  }
}
