import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetMembershipSection extends StatelessWidget {
  const GetMembershipSection(
      {super.key,
      // required this.context,
      required this.onJoinPressed});

  // final BuildContext context;
  final void Function()? onJoinPressed;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.04,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Membership Benefits", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 6),
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(19), color: WColors.onPrimaryBackground),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Image.asset(
                    WImages.coin,
                    scale: 4,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Become a Axilo Member",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: WColors.textPrimary, fontWeight: FontWeight.w600),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Unlock \$10 worth coins & exclusive discounts.",
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: WColors.textPrimary, fontWeight: FontWeight.w400),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () => onJoinPressed,
                                child: Text("Join Now",
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1)))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
