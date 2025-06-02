// import 'dart:developer';

// import 'package:axilo/core/data/data_source/datasource.dart';
// import 'package:axilo/core/local/local_data.dart';
// import 'package:axilo/core/services/logout_service/logout_service.dart';
// import 'package:axilo/utils/config_colection/config/config.dart';
// import 'package:dio/dio.dart';

// mixin TokenExpireServices {
//   final LogoutService _logoutService = LogoutService();

//   Future<bool> handleTokenExpiry(
//       {required dynamic error,
//       required Dio dio,
//       required DataSource dataSource}) async {
//     int? statusCode;

//     if (error is DioException) {
//       statusCode = error.response?.statusCode;
//     }

//     // if (error is HttpLinkServerException) {
//     //   statusCode = error.response.statusCode;
//     // }

//     if ((statusCode ?? 400) == 401) {
//       bool success = await refreshAccessToken(dio, dataSource);
//       if (!success) {
//         handleLogout();
//       }
//       return success;
//     }
//     return false;
//   }

//   Future<bool> refreshAccessToken(Dio dio, DataSource dataSource) async {
//     String? refreshToken = LocalData().refreshToken;
//     if (refreshToken == null) return false;
//     String url = "${Config.baseUrl}/refresh";
//     try {
//       final response = await dio.post(url,
//           data: {'refreshToken': refreshToken},
//           options: Options(headers: {
//             'Content-Type': Config.contentTypeApp,
//             'Authorization': Config.basicAuth,
//           }));

//       String newAccessToken = response.data["response"]['accessToken'];
//       String newRefreshToken = response.data["response"]['refreshToken'];
//       log(newAccessToken);

//       await dataSource.updateAuthTokens(newAccessToken, newRefreshToken);

//       await dataSource.getAuthData().then((authData) async {
//         LocalData().accessToken = authData.accessToken;
//         LocalData().refreshToken = authData.refreshToken;
//       });
//       log("${LocalData().accessToken}");

//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   void handleLogout() async {
//     _logoutService.logout();
//   }
// }
