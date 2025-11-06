import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gitview_assignment/data/data_suorce/remote/base_api_service.dart';


class ApiService extends BaseApiService{
  
  final Dio _dio =Dio(
    BaseOptions(
                headers: {
                  'Accept':'application/json',
                  'Content-Type': 'application/json',
                } )
  );


  @override
  Future<dynamic> getRequest(String url,{String? token}) async{
    
   try{
    
    final response= await _dio.get( url);
    return _returnResponse(response);

   }catch(e){
    throw Exception(' Failed to post data: $e');
   }

  }

// For Post Request

  @override
  Future<dynamic> postRequest(String url, data,{String? token}) async {
    try{
      final response= await _dio.post(
        url,
        data: jsonEncode(data),
      options: Options(
        headers: {
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token', 
          },
      )       

      );

      return _returnResponse(response);

    }catch(e){
      throw Exception('Failed to post data: $e');
    }
  }

}

  // Handle response
  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw Exception('Bad Request: ${response.data}');
      case 401:
        throw Exception('Unauthorized: ${response.data}');
      case 422:
        throw Exception('Unprocessable Entity: ${response.data}');
      case 500:
        throw Exception('Server Error: ${response.data}');
      default:
        throw Exception(
            'Error occurred: ${response.statusCode} ${response.statusMessage}');
    }
  }