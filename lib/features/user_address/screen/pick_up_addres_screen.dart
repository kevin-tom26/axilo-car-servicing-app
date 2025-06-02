import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/common/widgets/appbar/custom_appbar.dart';
import 'package:axilo/common/widgets/bottom_button_widget/bottom_button_widget.dart';
import 'package:axilo/common/widgets/bottom_safe_area/bottom_safe_area.dart';
import 'package:axilo/features/user_address/controller/address_controller.dart';
import 'package:axilo/features/slot_booking/model/user_address_model.dart';
import 'package:axilo/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dotted_border/dotted_border.dart';

class PickUpAddressScreen extends StatelessWidget {
  final AddressController _addressController = Get.put(AddressController());

  PickUpAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            onLeadingIconPressed: () => Get.back(),
            appBarTitle: _addressController.fromProfile ? "Manage Address" : 'Select Address'),
        resizeToAvoidBottomInset: true,
        body: BottomSafeArea(
          bottom: _addressController.fromProfile,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pick Up & Delivery Address",
                    style: TextStyle(fontSize: 20, color: WColors.textPrimary, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                _buildAddressList(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _addressController.fromProfile
            ? SizedBox()
            : BottomSafeArea(
                child: Obx(() {
                  return BottomButton(
                      onPressed: _addressController.selectedAddress.value == null
                          ? null
                          : () {
                              _addressController.goToReviewSummaryScreen();
                            },
                      buttonChild: Text(
                        "Continue",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: WColors.textSecondary, fontWeight: FontWeight.w500),
                      ));
                }),
              ));
  }

  Widget _buildAddressList() {
    return Obx(() {
      if (_addressController.addressList.isEmpty) {
        return Expanded(
          child: Center(
            child: GestureDetector(
              onTap: _showAddAddressBottomSheet,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 3],
                color: Colors.grey,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add New Address',
                    style: TextStyle(color: WColors.textPrimary),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: Get.height * 0.55,
              child: ListView.separated(
                itemCount: _addressController.addressList.length,
                itemBuilder: (context, index) {
                  final address = _addressController.addressList[index];
                  return Obx(() {
                    final isSelected = _addressController.selectedAddress.value == address;
                    return ListTile(
                      leading: const Icon(Icons.location_on_rounded, size: 25, color: WColors.onPrimary),
                      title: Text(
                        address.type,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        address.address,
                        softWrap: true,
                        maxLines: 3,
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.check_circle,
                              color: Colors.purple,
                              size: 24,
                            )
                          : null,
                      contentPadding: EdgeInsets.zero,
                      onTap: () => _addressController.selectAddress(address),
                    );
                  });
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(color: Colors.grey[300], height: 8, thickness: 1);
                },
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _showAddAddressBottomSheet,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: const [6, 3],
                color: Colors.grey,
                child: Container(
                  width: double.infinity,
                  height: 70,
                  alignment: Alignment.center,
                  child: const Text(
                    'Add New Address',
                    style: TextStyle(color: WColors.textPrimary),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    });
  }

  void _showAddAddressBottomSheet() {
    TextEditingController typeController = _addressController.typeController;
    TextEditingController addressController = _addressController.addressController;
    Get.bottomSheet(
      BottomSafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          constraints: BoxConstraints(maxHeight: Get.height * 0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Add New Address',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: WColors.textPrimary),
              ),
              const SizedBox(height: 16),
              const Text("Address Type:",
                  style: TextStyle(fontSize: 18, color: WColors.textPrimary, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              TextField(
                controller: typeController,
                style: const TextStyle(color: WColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'Address Type (e.g., Home, Office)',
                  hintStyle: const TextStyle(color: WColors.darkerGrey, fontWeight: FontWeight.w400),
                  fillColor: Colors.grey.shade200,
                ),
              ),
              const SizedBox(height: 12),
              const Text("Address:",
                  style: TextStyle(fontSize: 18, color: WColors.textPrimary, fontWeight: FontWeight.w500)),
              const SizedBox(height: 4),
              TextField(
                controller: addressController,
                style: const TextStyle(color: WColors.textPrimary),
                decoration: InputDecoration(
                    hintText: 'Full Address',
                    hintStyle: const TextStyle(color: WColors.darkerGrey, fontWeight: FontWeight.w400),
                    fillColor: Colors.grey.shade200,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
                minLines: 3,
                maxLines: 4,
              ),
              const Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final type = typeController.text.trim();
                    final address = addressController.text.trim();
                    if (type.isEmpty || address.isEmpty) {
                      CommonMethods.showErrorSnackBar('Error', 'Please fill in all fields');
                      return;
                    }
                    await _addressController.addAddress(UserAddressModel(type: type, address: address)).then((val) {
                      if (val) {
                        Get.back();
                        CommonMethods.showSuccessSnackBar('Success', 'New address added successfully');
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: WColors.onPrimary,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                    disabledBackgroundColor: Colors.grey,
                  ),
                  child: const Text("Add Address",
                      style: TextStyle(
                          fontSize: 16,
                          color: WColors.textSecondary,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500)),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
