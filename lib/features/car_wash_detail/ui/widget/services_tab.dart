import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceTab extends StatelessWidget {
  final List<Service> serviceCategoryList;
  const ServiceTab({
    super.key,
    required this.serviceCategoryList,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(childCount: serviceCategoryList.length, (context, index) {
      return Card(
        elevation: 3,
        color: WColors.softGrey,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: Get.width * 0.04,
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            height: Get.height * 0.08,
            width: Get.height * 0.08,
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: WColors.onPrimaryBackground,
                image: DecorationImage(
                    colorFilter: ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn),
                    image: AssetImage(CommonMethods.getServiceIcon(serviceCategoryList[index].name)),
                    scale: 3.6)),
          ),
          title: Text(
            serviceCategoryList[index].name,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WColors.textPrimary),
          ),
        ),
      );
    }));
  }
}

class ServiceTabHeading extends StatelessWidget {
  const ServiceTabHeading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          //vertical: Get.height * 0.01,
          horizontal: Get.width * 0.04,
        ),
        padding: EdgeInsets.only(top: Get.height * 0.02),
        child: Text(
          'Services',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: WColors.textPrimary),
        ),
      ),
    );
  }
}
