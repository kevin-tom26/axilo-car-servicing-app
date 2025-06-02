// import 'package:axilo/core/data/data_source/datasource.dart';
// import 'package:axilo/core/model/rest_response.dart';
// import 'package:axilo/core/module/local_module/local_module.dart';
// import 'package:axilo/core/services/mixin_service/handle_message.dart';
// import 'package:axilo/core/services/mixin_service/refresh_token_mixin.dart';
// import 'package:axilo/utils/config_colection/config/config.dart';
// import 'package:dio/dio.dart';

// class DioClient with TokenExpireServices, HandleMessageServices {
//   final Dio _dio;
//   DataSource? dataSource;
//   // injecting dio instance

//   DioClient(this._dio) {
//     dataSource = LocalModule().provideLocalModule();
//   }

//   // Get:-----------------------------------------------------------------------
//   Future<RestResponse> get(
//     String uri, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     String? contentType,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     RestResponse _response = RestResponse(
//       apiSuccess: false,
//       statusCode: 400,
//     );

//     try {
//       _dio.options.contentType =
//           contentType ?? 'application/json; charset=utf-8';
//       final Response response = await _dio.get(
//         uri,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );

//       if (response.statusCode == Config.successStatusCode) {
//         handleSuccess(
//           responseOrignal: response,
//           responseRestModal: _response,
//         );
//       }
//     } on DioException catch (e) {
//       if (await handleTokenExpiry(
//           error: e, dio: _dio, dataSource: dataSource!)) {
//         return await get(
//           uri,
//           queryParameters: queryParameters,
//           options: options,
//           cancelToken: cancelToken,
//           onReceiveProgress: onReceiveProgress,
//         );
//       }
//       handleError(
//         dioError: e,
//         responseRestModal: _response,
//       );
//     }
//     return _response;
//   }

//   // Post:----------------------------------------------------------------------
//   Future<RestResponse> post(
//     String uri, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     String? contentType,
//     CancelToken? cancelToken,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//     header,
//   }) async {
//     RestResponse _response = RestResponse(
//       apiSuccess: false,
//       statusCode: 400,
//     );
//     try {
//       _dio.options.contentType =
//           contentType ?? 'application/json; charset=utf-8';
//       if (header != null) {
//         _dio.options.headers.addAll(header);
//       }
//       final Response response = await _dio.post(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );

//       if (response.statusCode == Config.successStatusCode &&
//           response.data is String &&
//           (response.data as String).isEmpty) {
//         _response = RestResponse(
//           apiSuccess: true,
//           statusCode: 200,
//         );
//         return _response;
//       }

//       if (response.statusCode == Config.successStatusCode) {
//         handleSuccess(
//           responseOrignal: response,
//           responseRestModal: _response,
//         );
//       }
//     } on DioException catch (e) {
//       print(e.error);

//       if (await handleTokenExpiry(
//           error: e, dio: _dio, dataSource: dataSource!)) {
//         return await post(
//           uri,
//           data: data,
//           queryParameters: queryParameters,
//           options: options,
//           cancelToken: cancelToken,
//           onSendProgress: onSendProgress,
//           onReceiveProgress: onReceiveProgress,
//         );
//       }
//       handleError(
//         dioError: e,
//         responseRestModal: _response,
//       );
//     }
//     return _response;
//   }

//   //Put:------------------------------------------------------------------------
//   Future<RestResponse> put(
//     String uri, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     String? contentType,
//     ProgressCallback? onSendProgress,
//     ProgressCallback? onReceiveProgress,
//     header,
//   }) async {
//     RestResponse _response = RestResponse(apiSuccess: false);
//     try {
//       _dio.options.contentType =
//           contentType ?? 'application/json; charset=utf-8';
//       if (header != null) {
//         _dio.options.headers.addAll(header);
//       }
//       final Response response = await _dio.put(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onSendProgress: onSendProgress,
//         onReceiveProgress: onReceiveProgress,
//       );

//       if (response.statusCode == Config.successStatusCode &&
//           response.data is String &&
//           (response.data as String).isEmpty) {
//         _response = RestResponse(
//           apiSuccess: true,
//           statusCode: 200,
//         );
//         return _response;
//       }

//       if (response.statusCode == Config.successStatusCode) {
//         handleSuccess(
//           responseOrignal: response,
//           responseRestModal: _response,
//         );
//       }
//     } on DioException catch (e) {
//       print(e.error);
//       if (await handleTokenExpiry(
//           error: e, dio: _dio, dataSource: dataSource!)) {
//         return await put(
//           uri,
//           data: data,
//           queryParameters: queryParameters,
//           options: options,
//           cancelToken: cancelToken,
//           onSendProgress: onSendProgress,
//           onReceiveProgress: onReceiveProgress,
//         );
//       }
//       handleError(
//         dioError: e,
//         responseRestModal: _response,
//       );
//     }
//     return _response;
//   }

//   //Delete:------------------------------------------------------------------------
//   Future<RestResponse> delete(
//     String uri, {
//     data,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//   }) async {
//     RestResponse _response = RestResponse(
//       apiSuccess: false,
//       statusCode: 400,
//     );
//     try {
//       final Response response = await _dio.delete(
//         uri,
//         data: data,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//       );

//       if (response.statusCode == Config.successStatusCode) {
//         handleSuccess(
//           responseOrignal: response,
//           responseRestModal: _response,
//         );
//       }
//     } on DioException catch (e) {
//       print(e.error);
//       if (await handleTokenExpiry(
//           error: e, dio: _dio, dataSource: dataSource!)) {
//         return await delete(
//           uri,
//           data: data,
//           queryParameters: queryParameters,
//           options: options,
//           cancelToken: cancelToken,
//         );
//       }
//       handleError(
//         dioError: e,
//         responseRestModal: _response,
//       );
//     }
//     return _response;
//   }

//   Future<RestResponse> download(
//     String uri, {
//     required String savePath,
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//     CancelToken? cancelToken,
//     ProgressCallback? onReceiveProgress,
//   }) async {
//     RestResponse _response = RestResponse(
//       apiSuccess: false,
//       statusCode: 400,
//     );
//     try {
//       final Response response = await _dio.download(
//         uri,
//         savePath,
//         queryParameters: queryParameters,
//         options: options,
//         cancelToken: cancelToken,
//         onReceiveProgress: onReceiveProgress,
//       );

//       if (response.data != null &&
//           response.statusCode == Config.successStatusCode) {
//         handleSuccess(
//           responseOrignal: response,
//           responseRestModal: _response,
//         );
//       }
//     } on DioException catch (e) {
//       print(e.error);
//       if (await handleTokenExpiry(
//           error: e, dio: _dio, dataSource: dataSource!)) {
//         return await download(uri,
//             savePath: savePath,
//             queryParameters: queryParameters,
//             options: options,
//             cancelToken: cancelToken,
//             onReceiveProgress: onReceiveProgress);
//       }
//       handleError(
//         dioError: e,
//         responseRestModal: _response,
//       );
//     }
//     return _response;
//   }
// }
