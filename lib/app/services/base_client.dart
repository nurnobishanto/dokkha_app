import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart'; // kDebugMode
import 'package:get/get_utils/get_utils.dart';
import 'package:get/state_manager.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../config/translations/strings_enum.dart';
import '../components/custom_snackbar.dart';
import 'api_exceptions.dart';

enum RequestType {
  get,
  post,
  put,
  delete,
}

class BaseClient {
  static final Dio _dio = Dio()
    ..interceptors.addIf(
      kDebugMode, // Only add logger in debug mode
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );


  /// dio getter (used for testing)
  static get dio => _dio;
  /// Perform safe API request
  static safeApiCall(
    String url,
    RequestType requestType, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    required Function(Response response) onSuccess,
    Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    Function(int total, int progress)? onSendProgress,
    Function? onLoading,
    dynamic data,
  }) async {
    try {
      await onLoading?.call();

      late Response response;
      switch (requestType) {
        case RequestType.get:
          response = await _dio.get(
            url,
            onReceiveProgress: onReceiveProgress,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case RequestType.post:
          response = await _dio.post(
            url,
            data: data,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case RequestType.put:
          response = await _dio.put(
            url,
            data: data,
            onReceiveProgress: onReceiveProgress,
            onSendProgress: onSendProgress,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
        case RequestType.delete:
          response = await _dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(headers: headers),
          );
          break;
      }

      await onSuccess(response);
    } on DioException catch (error) {
      _handleDioError(error: error, url: url, onError: onError);
    } on SocketException {
      _handleSocketException(url: url, onError: onError);
    } on TimeoutException {
      _handleTimeoutException(url: url, onError: onError);
    } catch (error) {
      _handleUnexpectedException(url: url, onError: onError, error: error);
    }
  }

  /// Download file
  static download({
    required String url,
    required String savePath,
    Function(ApiException)? onError,
    Function(int value, int progress)? onReceiveProgress,
    required Function onSuccess,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        options: Options(
          receiveTimeout: const Duration(milliseconds: 9999),
          sendTimeout: const Duration(milliseconds: 9999),
        ),
        onReceiveProgress: onReceiveProgress,
      );
      onSuccess();
    } catch (error) {
      final exception = ApiException(url: url, message: error.toString());
      onError?.call(exception) ?? _handleError(error.toString());
    }
  }

  static _handleUnexpectedException({
    Function(ApiException)? onError,
    required String url,
    required Object error,
  }) {
    _logError('Unexpected error: $error');
    final message = Strings.somethingWentWrong.tr;
    if (onError != null) {
      onError(ApiException(message: message, url: url));
    } else {
      _handleError(message);
    }
  }

  static _handleTimeoutException({
    Function(ApiException)? onError,
    required String url,
  }) {
    _logError('Timeout error on $url');
    final message = Strings.serverNotResponding.tr;
    if (onError != null) {
      onError(ApiException(message: message, url: url));
    } else {
      _handleError(message);
    }
  }

  static _handleSocketException({
    Function(ApiException)? onError,
    required String url,
  }) {
    _logError('No internet connection for $url');
    final message = Strings.noInternetConnection.tr;
    if (onError != null) {
      onError(ApiException(message: message, url: url));
    } else {
      _handleError(message);
    }
  }

  static _handleDioError({
    required DioException error,
    Function(ApiException)? onError,
    required String url,
  }) {
    _logError('Dio error on $url: ${error.message}');

    final statusCode = error.response?.statusCode;
    final errorMessage = error.message?.toLowerCase() ?? '';

    if (statusCode == 404) {
      final message = Strings.urlNotFound.tr;
      final exception =
          ApiException(message: message, url: url, statusCode: 404);
      if (onError != null) {
        return onError(exception);
      } else {
        return _handleError(message);
      }
    }

    if (errorMessage.contains('socket') ||
        error.type == DioExceptionType.connectionError ||
        errorMessage.contains('failed host lookup')) {
      final message = Strings.noInternetConnection.tr;
      final exception = ApiException(message: message, url: url);
      if (onError != null) {
        return onError(exception);
      } else {
        return _handleError(message);
      }
    }

    if (statusCode == 500) {
      final message = Strings.serverError.tr;
      final exception =
          ApiException(message: message, url: url, statusCode: 500);
      if (onError != null) {
        return onError(exception);
      } else {
        return _handleError(message);
      }
    }

    // Default error
    final exception = ApiException(
      url: url,
      message: error.message.toString(),
      response: error.response,
      statusCode: statusCode,
    );
    if (onError != null) {
      return onError(exception);
    } else {
      return _handleError(exception.message ?? Strings.somethingWentWrong.tr);
    }
  }

  /// Show error message to user with custom snack bar
  static _handleError(String msg) {
    CustomSnackBar.showCustomErrorToast(message: msg);
  }

  /// Log errors - print only in debug, or send to remote server in release
  static void _logError(String message) {
    if (kDebugMode) {
      debugPrint("[BaseClient] $message");
    } else {
      // TODO: integrate Firebase Crashlytics or other logging
      // FirebaseCrashlytics.instance.recordError(message, null);
    }
  }
}

// import 'dart:async';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:get/get_utils/get_utils.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';
//
// import '../../config/translations/strings_enum.dart';
// import '../components/custom_snackbar.dart';
// import 'api_exceptions.dart';
//
// enum RequestType {
//   get,
//   post,
//   put,
//   delete,
// }
//
// class BaseClient {
//   static final Dio _dio = Dio()
//   ..interceptors.add(PrettyDioLogger(
//     requestHeader: true,
//     requestBody: true,
//     responseBody: true,
//     responseHeader: false,
//     error: true,
//     compact: true,
//     maxWidth: 90,
//   ));
//
//   /// dio getter (used for testing)
//   static get dio => _dio;
//
//   /// perform safe api request
//   static safeApiCall(
//     String url,
//     RequestType requestType, {
//     Map<String, dynamic>? headers,
//     Map<String, dynamic>? queryParameters,
//     required Function(Response response) onSuccess,
//     Function(ApiException)? onError,
//     Function(int value, int progress)? onReceiveProgress,
//     Function(int total, int progress)?
//         onSendProgress, // while sending (uploading) progress
//     Function? onLoading,
//     dynamic data,
//   }) async {
//     try {
//       // 1) indicate loading state
//       await onLoading?.call();
//       // 2) try to perform http request
//       late Response response;
//       if (requestType == RequestType.get) {
//         response = await _dio.get(
//           url,
//           onReceiveProgress: onReceiveProgress,
//           queryParameters: queryParameters,
//           options: Options(
//             headers: headers,
//           ),
//         );
//       } else if (requestType == RequestType.post) {
//         response = await _dio.post(
//           url,
//           data: data,
//           onReceiveProgress: onReceiveProgress,
//           onSendProgress: onSendProgress,
//           queryParameters: queryParameters,
//           options: Options(headers: headers),
//         );
//       } else if (requestType == RequestType.put) {
//         response = await _dio.put(
//           url,
//           data: data,
//           onReceiveProgress: onReceiveProgress,
//           onSendProgress: onSendProgress,
//           queryParameters: queryParameters,
//           options: Options(headers: headers),
//         );
//       } else {
//         response = await _dio.delete(
//           url,
//           data: data,
//           queryParameters: queryParameters,
//           options: Options(headers: headers),
//         );
//       }
//       // 3) return response (api done successfully)
//       await onSuccess(response);
//     } on DioException catch (error) {
//       // dio error (api reach the server but not performed successfully
//       _handleDioError(error: error, url: url, onError: onError);
//     } on SocketException {
//       // No internet connection
//       _handleSocketException(url: url, onError: onError);
//     } on TimeoutException {
//       // Api call went out of time
//       _handleTimeoutException(url: url, onError: onError);
//     } catch (error) {
//       // unexpected error for example (parsing json error)
//       _handleUnexpectedException(url: url, onError: onError, error: error);
//     }
//   }
//
//   /// download file
//   static download(
//       {required String url, // file url
//       required String savePath, // where to save file
//       Function(ApiException)? onError,
//       Function(int value, int progress)? onReceiveProgress,
//       required Function onSuccess}) async {
//     try {
//       await _dio.download(
//         url,
//         savePath,
//         options: Options(receiveTimeout: const Duration(milliseconds: 9999), sendTimeout: const Duration(milliseconds: 9999)),
//         onReceiveProgress: onReceiveProgress,
//       );
//       onSuccess();
//     } catch (error) {
//       var exception = ApiException(url: url, message: error.toString());
//       onError?.call(exception) ?? _handleError(error.toString());
//     }
//   }
//
//   /// handle unexpected error
//   static _handleUnexpectedException(
//       {Function(ApiException)? onError,
//       required String url,
//       required Object error}) {
//     if (onError != null) {
//       onError(ApiException(
//         message: error.toString(),
//         url: url,
//       ));
//     } else {
//       _handleError(error.toString());
//     }
//   }
//
//   /// handle timeout exception
//   static _handleTimeoutException(
//       {Function(ApiException)? onError, required String url}) {
//     if (onError != null) {
//       onError(ApiException(
//         message: Strings.serverNotResponding.tr,
//         url: url,
//       ));
//     } else {
//       _handleError(Strings.serverNotResponding.tr);
//     }
//   }
//
//   /// handle timeout exception
//   static _handleSocketException(
//       {Function(ApiException)? onError, required String url}) {
//     if (onError != null) {
//       onError(ApiException(
//         message: Strings.noInternetConnection.tr,
//         url: url,
//       ));
//     } else {
//       _handleError(Strings.noInternetConnection.tr);
//     }
//   }
//
//   /// handle Dio error
//   static _handleDioError(
//       {required DioException error,
//       Function(ApiException)? onError,
//       required String url}) {
//     // 404 error
//     if (error.response?.statusCode == 404) {
//       if (onError != null) {
//         return onError(ApiException(
//           message: Strings.urlNotFound.tr,
//           url: url,
//           statusCode: 404,
//         ));
//       } else {
//         return _handleError(Strings.urlNotFound.tr);
//       }
//     }
//
//     // no internet connection
//     if (error.message!.toLowerCase().contains('socket')) {
//       if (onError != null) {
//         return onError(ApiException(
//           message: Strings.noInternetConnection.tr,
//           url: url,
//         ));
//       } else {
//         return _handleError(Strings.noInternetConnection.tr);
//       }
//     }
//
//     // check if the error is 500 (server problem)
//     if (error.response?.statusCode == 500) {
//       var exception = ApiException(
//         message: Strings.serverError.tr,
//         url: url,
//         statusCode: 500,
//       );
//
//       if (onError != null) {
//         return onError(exception);
//       } else {
//         return handleApiError(exception);
//       }
//     }
//
//     var exception = ApiException(
//         url: url,
//         message: error.message.toString(),
//         response: error.response,
//         statusCode: error.response?.statusCode);
//     if (onError != null) {
//       return onError(exception);
//     } else {
//       return handleApiError(exception);
//     }
//   }
//
//   /// handle error automaticly (if user didnt pass onError) method
//   /// it will try to show the message from api if there is no message
//   /// from api it will show the reason (the dio message)
//   static handleApiError(ApiException apiException) {
//     String msg = apiException.toString();
//     CustomSnackBar.showCustomErrorToast(message: msg);
//   }
//
//   /// handle errors without response (500, out of time, no internet,..etc)
//   static _handleError(String msg) {
//     CustomSnackBar.showCustomErrorToast(message: msg);
//   }
// }
