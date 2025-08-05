import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:news_app_updated/core/constants/app_constants.dart';
import 'package:news_app_updated/core/networking/api_endpoints.dart';
import 'package:news_app_updated/core/networking/dio_helper.dart';
import 'package:news_app_updated/features/home_screen/models/top_headline_model.dart';

class HomeScreenServices {
  getTopHealinesArticles() async {
    try {
      Response response = await DioHelper.getRequest(
          endpoint: ApiEndpoints.topHeadlines,
          queryParameters: {
            "country": "us",
            "apiKey": AppConstants.newsApiKey,
          });
      if (response.statusCode == 200) {
        TopHeadLinesModel topHeadLinesModel =
            TopHeadLinesModel.fromJson(response.data);
        log(topHeadLinesModel.totalResults.toString());
        return topHeadLinesModel;
      }
    } catch (error) {
      log(error.toString());
      return Future.error(error.toString());
    }
  }
}
