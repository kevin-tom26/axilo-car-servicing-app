import 'dart:async';

import 'package:axilo/common/methods/common_methods.dart';
import 'package:axilo/core/model/car_wash_model.dart';
import 'package:axilo/features/bookmark/service/bookmark_service.dart';
import 'package:axilo/features/main/controller/main_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  late MainController mainController;
  BookmarkService bookmarkService = BookmarkService();
  RxList<String> bookmarkIdList = <String>[].obs;
  late final StreamSubscription subscription;

  var isBookMarkedListLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    mainController = Get.find<MainController>();
    listenToBookmarkList();
  }

  @override
  void onReady() {
    ever(mainController.carServicesList, (_) => getBookmarkedServices());
    super.onReady();
  }

  @override
  void onClose() {
    subscription.cancel();
    super.onClose();
  }

  RxList<CarWashModel> bookmarkedList = <CarWashModel>[].obs;
  RxList<CarWashModel> filteredBookmarkedList = <CarWashModel>[].obs;
  TextEditingController searchController = TextEditingController();

  var selectedCategoryIndex = 0.obs;

  // Sunscription listening to bookmark list change
  void listenToBookmarkList() {
    try {
      subscription = bookmarkService.listenToBookmarks().listen((bookmarkIds) {
        bookmarkIdList.assignAll(bookmarkIds);
        if (mainController.carServicesList.isNotEmpty) {
          getBookmarkedServices();
        }
      });
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : "Error fetching bookMark List";
      CommonMethods.showErrorSnackBar('Error', msg);
    }
  }

  // Get all bookmarked Car Service List
  void getBookmarkedServices() {
    isBookMarkedListLoading.value = true;
    bookmarkedList.assignAll(mainController.carServicesList.where((item) => bookmarkIdList.contains(item.id)));
    filteredBookmarkedList.assignAll(bookmarkedList);
    isBookMarkedListLoading.value = false;
  }

  // update the bookamark list
  Future<void> updateUserBookmark({required bool isAdding, required String bookmarkID}) async {
    try {
      await bookmarkService.updateUserBookmark(isAdding: isAdding, bookmarkID: bookmarkID);
      CommonMethods.showSuccessSnackBar('Success', 'Bookmark ${isAdding ? 'added' : 'removed'} successfully.');
    } catch (e) {
      final msg = e is FirebaseException ? e.message ?? "Database error" : "Error updating bookMark List";
      CommonMethods.showErrorSnackBar('Error', msg);
    }
  }

  void updateFilterTab(int index, String filterName) {
    selectedCategoryIndex.value = index;
    filterByCategory(filterName);
  }

  void filterByCategory(String filterName) {
    if (filterName == 'All') {
      filteredBookmarkedList.assignAll(bookmarkedList);
    } else {
      filteredBookmarkedList
          .assignAll(bookmarkedList.where((item) => item.services.any((category) => category.name == filterName)));
    }
  }

  List<CarWashModel> filteredSearchServiceList(String suggestion, RxList<CarWashModel> serviceModelsList) {
    return serviceModelsList
        .where((service) => service.name.toLowerCase().startsWith(suggestion.toLowerCase()))
        .toList();
  }

  void setSelectedService(CarWashModel value) => searchController.text = value.name;
}
