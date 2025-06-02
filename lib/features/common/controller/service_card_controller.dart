import 'package:axilo/features/bookmark/controller/bookmark_controller.dart';

import 'package:get/get.dart';

class ServiceCardController extends GetxController {
  late BookmarkController bookmarkController;

  @override
  void onInit() {
    super.onInit();
    bookmarkController = Get.find<BookmarkController>();
  }

  bool isBookmarked(String id) {
    return bookmarkController.bookmarkIdList.contains(id);
  }

  addToBookmark(String id) async => await bookmarkController.updateUserBookmark(isAdding: true, bookmarkID: id);
  removeFromBookmark(String id) async => await bookmarkController.updateUserBookmark(isAdding: false, bookmarkID: id);
}
