import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app_updated/core/constants/app_constants.dart';
import 'package:news_app_updated/core/networking/api_endpoints.dart';
import 'package:news_app_updated/core/networking/dio_helper.dart';
import 'package:news_app_updated/features/home_screen/models/article_model.dart';

class SearchResultServices {
  searchItemByName(String query) async {
    try {
      Response response = await DioHelper.getRequest(
          endpoint: ApiEndpoints.searchEndpoint,
          queryParameters: {
            "apiKey": AppConstants.newsApiKey,
            "q": query,
            "language": AppConstants.language
          });
      if (response.statusCode == 200) {
        ArticleModel articleModel = ArticleModel.fromJson(response.data);
        log(articleModel.totalResults.toString());
        return articleModel;
      }
    } catch (error) {
      return Future.error(error.toString());
    }
  }
}
