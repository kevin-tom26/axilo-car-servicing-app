import 'package:axilo/core/model/rest_response.dart';
import 'package:dio/dio.dart';

mixin HandleMessageServices {
  void handleError({
    required DioException dioError,
    required RestResponse responseRestModal,
  }) async {
    if (dioError.response != null && dioError.response!.data != null && dioError.response!.data.toString().isNotEmpty) {
      if (dioError.response!.data is Map && dioError.response!.data?['status'] != null) {
        responseRestModal.statusCode = dioError.response!.data['status']['code'];
        responseRestModal.message = dioError.response!.data['status']['message'] ?? '';
      } else if (dioError.response!.data is String &&
          dioError.response!.statusCode != null &&
          dioError.response!.statusMessage != null) {
        responseRestModal.statusCode = dioError.response!.statusCode;
        responseRestModal.message = dioError.response!.statusMessage ?? '';
      }
    } else {
      responseRestModal.message = 'Something went wrong';
      responseRestModal.statusCode = 800;
    }
    // if (responseRestModal.message == null ||
    //     responseRestModal.message.toString().isEmpty) {
    //   responseRestModal.message = DioExceptionUtil.handleError(dioError);
    // }
  }

  void handleSuccess({
    required Response<dynamic> responseOrignal,
    required RestResponse responseRestModal,
  }) {
    responseRestModal.data = responseOrignal.data;
    if (_statusCodeCheck(
      responseOrignal: responseOrignal,
      responseRestModal: responseRestModal,
    )) {
      responseRestModal.apiSuccess = true;

      if (responseRestModal.data != null &&
          responseRestModal.data.toString().isNotEmpty &&
          (responseRestModal.data is! String) &&
          responseRestModal.data['status'] != null) {
        responseRestModal.message = responseRestModal.data['status']['message'] ?? '';
        responseRestModal.statusCode = responseRestModal.data['status']['code'] ?? '';
      }
    } else {
      responseRestModal.apiSuccess = false;
      if (responseRestModal.data != null &&
          responseRestModal.data.toString().isNotEmpty &&
          (responseRestModal.data is! String) &&
          responseRestModal.data['status'] != null) {
        responseRestModal.message = responseRestModal.data['status']['message'] ?? '';
        responseRestModal.statusCode = responseRestModal.data['status']['code'] ?? '';
      } else {
        responseRestModal.message = 'Something went wrong';
        responseRestModal.statusCode = 800;
      }
    }
  }

  bool _statusCodeCheck({
    required Response<dynamic> responseOrignal,
    required RestResponse responseRestModal,
  }) {
    try {
      return responseOrignal.statusCode == 200 && (responseRestModal.data['status']['code'] == 200);
    } catch (_) {
      return false;
    }
  }
}
