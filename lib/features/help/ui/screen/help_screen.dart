import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/help/controller/help_controller.dart';
import 'package:axilo/features/help/ui/widget/contact_option.dart';
import 'package:axilo/features/help/ui/widget/faq_expansion_tile.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:axilo/utils/constants/image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HelpController helpController = Get.find<HelpController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: WColors.primary,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Help & Support'),
      ),
      body: BottomSafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///  Contact Options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  ContactOption(iconImg: WImages.phone_outlined, label: "Call Us"),
                  SizedBox(width: 14),
                  ContactOption(iconImg: WImages.chat_outlined, label: "Chat"),
                  SizedBox(width: 14),
                  ContactOption(iconImg: WImages.mail_outlined, label: "Email"),
                ],
              ),
              const SizedBox(height: 24),

              ///  FAQ Header
              Row(
                children: [
                  Image.asset(
                    WImages.FAQ,
                    scale: 3.4,
                    color: WColors.onPrimary,
                  ),
                  // Icon(Icons.help_outline, color: WColors.onPrimary),
                  SizedBox(width: 4),
                  Expanded(
                      child: Text(
                    "Frequently Asked Questions",
                    style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 18),
                  )),
                ],
              ),
              const SizedBox(height: 10),

              /// 🔷 FAQ Expansion List
              Obx(() => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: helpController.faqData.entries.map((entry) {
                      final isExpanded = helpController.expandedItems.contains(entry.key);
                      return FaqExpansionTile(
                          titleText: entry.key,
                          onExpansionChanged: (_) => helpController.toggleItem(entry.key),
                          childText: entry.value,
                          initiallyExpanded: isExpanded);
                    }).toList(),
                  )),

              const SizedBox(height: 20),

              ///  Can't Find Question
              const Text(
                "Can't find what you're looking for?",
                style: TextStyle(color: WColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: helpController.userQuestionController,
                minLines: 4,
                maxLines: 4,
                style: const TextStyle(color: WColors.textPrimary),
                decoration: InputDecoration(
                    hintText: "Type your question here...",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
              ),
              const SizedBox(height: 16),

              ///  Submit Button
              SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: WColors.onPrimary,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                        disabledBackgroundColor: Colors.grey,
                      ),
                      child: Text(
                        "Submit",
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w500),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
