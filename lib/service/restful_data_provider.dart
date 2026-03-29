
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_getx_boilerplate/model/api/error_response.dart' as er;
import 'package:flutter_getx_boilerplate/utils/helper.dart';

enum EnumAPIEndpoint {
  api_1;

  String get url {
    final domain = RestfulDataProvider.shared._mainDomain;
    switch (this) {
      case api_1: return "$domain/api/api-1";
    }
  }
}

class RestfulDataProvider {
  static RestfulDataProvider shared = RestfulDataProvider();

  Dio? _dio;

  String get _mainDomain {
    // ////////////////////////////////////////////////////////
    // OPEN THIS COMMENT IF YOUR PROJECT USE MULTIPLE FIREBASE
    // ////////////////////////////////////////////////////////
    // final firebaseProjectId = DefaultFirebaseOptions.currentPlatform.projectId;
    // if (firebaseProjectId == "your-production-firebase-project-id") {
    //   // Production
    //   return "https://your-main-api-domain.com";
    // }
    // return "https://staging-your-main-api-domain.com";

    return "";
  }

  initProvider() async {
    _dio = Dio(BaseOptions(
      baseUrl: _mainDomain,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 90),
      sendTimeout: const Duration(seconds: 90),
    ));

    _dio?.interceptors.add(InterceptorsWrapper(
        onError: (error, handler ){
          log(error.message ?? 'unknown error');

          handler.next(error);
        },
        onRequest: (request, handler){
          log("${request.method} | ${request.path}");

          handler.next(request);
        },
        onResponse: (response, handler) {
          log('${response.statusCode} ${response.statusCode} ${response.data}');

          handler.next(response);
        }
    ));
  }

  Future<String?> _getFirebaseAuthIdToken() async {
    String? authorization;
    final idTokenResult = await FirebaseAuth.instance.currentUser?.getIdTokenResult();
    if (idTokenResult != null) {
      final expireAt = idTokenResult.expirationTime;
      if (expireAt != null) {
        final now = DateTime.now();
        if (now.isAfter(expireAt)) {
          authorization = await FirebaseAuth.instance.currentUser?.getIdToken(true);
        } else {
          authorization = idTokenResult.token ?? (await FirebaseAuth.instance.currentUser?.getIdToken());
        }
      } else {
        authorization = await FirebaseAuth.instance.currentUser?.getIdToken(true);
      }
    } else {
      authorization = await FirebaseAuth.instance.currentUser?.getIdToken(true);
    }
    debugLog("latest firebase id token = $authorization");
    return authorization;
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? query}) async {
    dynamic response;
    try{
      var header = <String, dynamic>{
        HttpHeaders.contentTypeHeader: "application/json"
      };
      final authorization = await _getFirebaseAuthIdToken();
      if (authorization != null && authorization.isNotEmpty) {
        header[HttpHeaders.authorizationHeader] = "Bearer $authorization";
      }

      if(query != null && query.isNotEmpty){
        // Map<String, String> map = {'CODE': code};

        var arr = <String>[];
        query.forEach((key, value) => arr.add('$key=$value'));
        var queryString = arr.join('&');
        response = await _dio!.get(
          '$url?$queryString',
          options: Options(headers: header),
        );
      } else {
        response = await _dio!.get(
          url,
          options: Options(headers: header),
        );
      }
    } on DioException catch(e){
      log(e.message ?? 'unknown error');

      if (e.response != null) {
        if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
          var error = er.ErrorResponse.fromJson(e.response?.data);

          throw error;
        } else {
          var error = er.ErrorResponse.fromJson(e.response);

          throw error;
        }
      } else {
        var error = er.ErrorResponse.noNetwork();
        throw error;
      }
    }

    return response;
  }

  Future<dynamic> post(String url, {dynamic object, Map<String, String>? additionalHeader}) async {
    dynamic response;
    try{
      var header = {
        HttpHeaders.contentTypeHeader: "application/json"
      };

      final authorization = await _getFirebaseAuthIdToken();
      if (authorization != null && authorization.isNotEmpty) {
        header[HttpHeaders.authorizationHeader] = "Bearer $authorization";
      }
      if (additionalHeader != null) {
        additionalHeader.forEach((key, value) {
          header[key] = value;
        });
      }
      if (object != null) {
        var jsonObj = jsonEncode(object);
        response = await _dio!.post(
            url,
            options: Options(headers: header),
            data: jsonObj
        );
      } else {
        response = await _dio!.post(
          url,
          options: Options(headers: header),
        );
      }
    } on DioException catch(e){
      // rethrow;
      if (e.response != null) {
        if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
          var error = er.ErrorResponse.fromJson(e.response?.data);
          throw error;
        } else {
          var error = er.ErrorResponse.fromJson(e.response);
          throw error;
        }
      } else {
        var error = er.ErrorResponse.noNetwork();
        throw error;
      }
    }
    return response;
  }

  Future<dynamic> patch(String url, {dynamic object, Map<String, String>? additionalHeader}) async {
    dynamic response;
    try{
      var header = {
        HttpHeaders.contentTypeHeader: "application/json"
      };

      final authorization = await _getFirebaseAuthIdToken();
      if (authorization != null && authorization.isNotEmpty) {
        header[HttpHeaders.authorizationHeader] = "Bearer $authorization";
      }
      if (additionalHeader != null) {
        additionalHeader.forEach((key, value) {
          header[key] = value;
        });
      }

      if (object != null) {
        var jsonObj = jsonEncode(object);
        response = await _dio!.patch(
            url,
            options: Options(headers: header),
            data: jsonObj
        );
      } else {
        response = await _dio!.patch(
          url,
          options: Options(headers: header),
        );
      }
    } on DioException catch(e){
      // rethrow;
      if (e.response != null) {
        if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
          var error = er.ErrorResponse.fromJson(e.response?.data);
          throw error;
        } else {
          var error = er.ErrorResponse.fromJson(e.response);
          throw error;
        }
      } else {
        var error = er.ErrorResponse.noNetwork();
        throw error;
      }
    }
    return response;
  }

  // Future<dynamic> postMultipartForm(String url, {File? file, String? authorization, String? refreshToken, Map<String, String>? additionalHeader}) async {
  //   dynamic response;
  //   try{
  //     var header = {
  //       HttpHeaders.contentTypeHeader: "application/json"
  //     };
  //     if (authorization != null && authorization.isNotEmpty) {
  //       header[HttpHeaders.authorizationHeader] = authorization;
  //     }
  //     if (refreshToken != null && refreshToken.isNotEmpty) {
  //       header["refresh-token"] = refreshToken;
  //     }
  //     if (additionalHeader != null) {
  //       additionalHeader.forEach((key, value) {
  //         header[key] = value;
  //       });
  //     }
  //
  //     if (file != null) {
  //       String fileName = file.path.split('/').last;
  //       FormData formData = FormData.fromMap({
  //         "file": await MultipartFile.fromFile(file.path, filename:fileName),
  //       });
  //       response = await _dio!.post(
  //         url,
  //         options: Options(headers: header),
  //         data: formData
  //       );
  //     } else {
  //       response = await _dio!.post(
  //         url,
  //         options: Options(headers: header),
  //       );
  //     }
  //   } on DioException catch(e){
  //     log('_______ ' + (e.message ?? 'unknown error'));
  //
  //     // rethrow;
  //     if (e.response != null) {
  //       log('111_______ ' + e.response.toString());
  //       if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
  //         var error = er.ErrorResponse.fromJson(e.response?.data);
  //
  //         throw error;
  //       } else {
  //         var error = er.ErrorResponse.fromJson(e.response);
  //
  //         throw error;
  //       }
  //     } else {
  //       var error = er.ErrorResponse(error: er.Error(message: 'There is a problem with your connection. Please make sure your data or wifi is connected.'.tr, status: 500));
  //       // var error = ErrorResponse.fromJson(e.response);
  //
  //       throw error;
  //     }
  //   }
  //   return response;
  // }

  Future<dynamic> put(String url, {dynamic object, Map<String, String>? additionalHeader}) async {
    dynamic response;
    try{
      var header = {
        HttpHeaders.contentTypeHeader: "application/json"
      };
      final authorization = await _getFirebaseAuthIdToken();
      if (authorization != null && authorization.isNotEmpty) {
        header[HttpHeaders.authorizationHeader] = "Bearer $authorization";
      }
      if (additionalHeader != null) {
        additionalHeader.forEach((key, value) {
          header[key] = value;
        });
      }

      if (object != null) {
        var jsonObj = jsonEncode(object);
        response = await _dio!.put(
            url,
            options: Options(headers: header),
            data: jsonObj
        );
      } else {
        response = await _dio!.put(
          url,
          options: Options(headers: header),
        );
      }
    } on DioException catch(e){
      // rethrow;
      if (e.response != null) {
        if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
          var error = er.ErrorResponse.fromJson(e.response?.data);
          throw error;
        } else {
          var error = er.ErrorResponse.fromJson(e.response);
          throw error;
        }
      } else {
        var error = er.ErrorResponse.noNetwork();
        throw error;
      }
    }
    return response;
  }

  Future<dynamic> delete(String url, {dynamic object}) async {
    dynamic response;
    try{
      var header = {
        HttpHeaders.contentTypeHeader: "application/json"
      };

      final authorization = await _getFirebaseAuthIdToken();
      if (authorization != null && authorization.isNotEmpty) {
        header[HttpHeaders.authorizationHeader] ="Bearer $authorization";
      }

      if (object != null) {
        var jsonObj = jsonEncode(object);
        response = await _dio!.delete(
            url,
            options: Options(headers: header),
            data: jsonObj
        );
      } else {
        response = await _dio!.delete(
          url,
          options: Options(headers: header),
        );
      }
    } on DioException catch(e){
      // rethrow;
      if (e.response != null) {
        if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
          var error = er.ErrorResponse.fromJson(e.response?.data);

          throw error;
        } else {
          var error = er.ErrorResponse.fromJson(e.response);

          throw error;
        }
      } else {
        var error = er.ErrorResponse.noNetwork();
        throw error;
      }
    }
    return response;
  }

  Future<dynamic> putRequest(String url, {required File object}) async {
    dynamic response;
    try{
      var header = {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded"

      };
      final authorization = await _getFirebaseAuthIdToken();
      if (authorization != null && authorization.isNotEmpty) {
        header[HttpHeaders.authorizationHeader] = "Bearer $authorization";
      }

      // FormData data = FormData.fromMap({
      //   "file": await MultipartFile.fromFile(object.path, filename: object.path.split('/').last),
      // });
      Uint8List image = File(object.path).readAsBytesSync();

      // Uint8List bytes = object.readAsBytesSync();

      response = await _dio!.put(
        url,
        options: Options(headers: header),
        data: image,
      );
    } on DioException catch(e){
      // rethrow;
      if (e.response != null) {
        if (e.response?.data != null && e.response?.data is Map<String, dynamic>) {
          var error = er.ErrorResponse.fromJson(e.response?.data);

          throw error;
        } else {
          var error = er.ErrorResponse.fromJson(e.response);

          throw error;
        }
      } else {
        var error = er.ErrorResponse.noNetwork();
        throw error;
      }
    }
    return response;
  }
}