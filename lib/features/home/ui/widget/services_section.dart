import 'package:auto_size_text/auto_size_text.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection(
      {super.key,
      // required this.context,
      required this.serviceIcons,
      required this.onIconTap});

  // final BuildContext context;
  final List<Map<String, dynamic>> serviceIcons;
  final void Function(String)? onIconTap;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          height: Get.height * 0.17,
          margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.04,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Services", style: Theme.of(context).textTheme.titleLarge),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 8),
                child: const SizedBox.expand(),
              ),
              Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: serviceIcons.length,
                    itemBuilder: (context, index) {
                      final serviceIcon = serviceIcons[index];
                      return GestureDetector(
                        onTap: () => onIconTap?.call(serviceIcon['name']),
                        child: SizedBox(
                          width: Get.height * 0.1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                height: Get.height * 0.08,
                                width: Get.height * 0.08,
                                margin: const EdgeInsets.only(bottom: 2),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: WColors.onPrimaryBackground,
                                    image: DecorationImage(
                                        image: AssetImage(serviceIcon['icon']),
                                        scale: 3.6,
                                        colorFilter: ColorFilter.mode(WColors.onPrimary, BlendMode.srcIn))),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  serviceIcon['name'],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  minFontSize: 10,
                                  maxFontSize: 13,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: WColors.iconBlack, fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10)),
              ),
            ],
          )),
    );
  }
}
