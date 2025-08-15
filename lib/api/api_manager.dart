import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/api/api_constants.dart';
import 'package:news/api/endpoints.dart';
import 'package:news/model/NewsResponse.dart';
import 'package:news/model/SourceResponse.dart';

class ApiManager{
  static Future<SourceResponse?> getSources(String categoryId) async {
    Uri url =Uri.https(ApiConstants.baseUrl, Endpoints.sourceApi,
    {
      'apiKey' : ApiConstants.apiKey,
      'category' : categoryId,
    }
    );
    try{
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return SourceResponse.fromJson(json);
    } catch(e){
      throw e;
    }
  }
  static Future<NewsResponse> getNewsBySourceId(String sourceId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, Endpoints.newsApi,
    {
      'apiKey' : ApiConstants.apiKey,
      'sources' : sourceId,
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    }catch(e){
      throw e;
    }
  }
  static Future<NewsResponse> searchNews(String query) async {
    Uri url = Uri.https(ApiConstants.baseUrl, Endpoints.newsApi, {
      'apiKey': ApiConstants.apiKey,
      'q': query,
    });
    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}