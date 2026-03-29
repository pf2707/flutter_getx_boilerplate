
import 'package:flutter_getx_boilerplate/model/api/error_response.dart';
import 'package:flutter_getx_boilerplate/model/api/request/api_1_request.dart';
import 'package:flutter_getx_boilerplate/model/api/response/basic_response.dart';
import 'package:flutter_getx_boilerplate/service/restful_data_provider.dart';
import 'package:flutter_getx_boilerplate/utils/helper.dart';

class RestfulDataProviderImplement {

  static Future<BasicResponse> handleAPI1(Api1Request request) async {
    try {
      var url = EnumAPIEndpoint.api_1.url;
      final response = await RestfulDataProvider.shared.post(url, object: request.toJson());
      return BasicResponse.fromJson(response.data);
    } on ErrorResponse catch (e) {
      debugLog("Handle api_1 get error response = $e");
      rethrow;
    } catch (e) {
      debugLog("Handle api_1 get error = $e");
      rethrow;
    }
  }
}