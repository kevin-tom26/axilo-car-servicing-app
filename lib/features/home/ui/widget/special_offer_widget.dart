import 'package:auto_size_text/auto_size_text.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget({
    super.key,
    // required this.context,
    required this.imageString,
    required this.offerTime,
    required this.offerHeading,
    required this.offerPercentage,
    required this.onTap,
  });

  // final BuildContext context;
  final String imageString;
  final String offerTime;
  final String offerHeading;
  final String offerPercentage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        //color: Colors.grey,
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
            image: AssetImage(imageString),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(WColors.textPrimary.withOpacity(0.6), BlendMode.darken)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            decoration: BoxDecoration(color: WColors.primary, borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: AutoSizeText(
              offerTime,
              minFontSize: 12,
              maxFontSize: 14,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: WColors.textPrimary, fontWeight: FontWeight.w500, fontSize: 13),
            ),
          ),
          const Spacer(),
          AutoSizeText(offerHeading,
              minFontSize: 16,
              maxFontSize: 20,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: WColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  )),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Up to",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: WColors.textSecondary,
                      )),
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(offerPercentage,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: WColors.textSecondary, fontSize: 29, height: 1)),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: AutoSizeText(
                          "%",
                          minFontSize: 6,
                          maxFontSize: 11,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(color: WColors.textSecondary, height: 1),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Limited period offer. T&C apply.",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: WColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      )),
              GestureDetector(
                onTap: () => onTap,
                child: Container(
                  decoration: BoxDecoration(color: WColors.onPrimary, borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: AutoSizeText(
                    "Claim",
                    minFontSize: 12,
                    maxFontSize: 14,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: WColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
