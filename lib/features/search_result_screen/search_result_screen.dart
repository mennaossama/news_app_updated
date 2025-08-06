import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_updated/core/constants/app_constants.dart';
import 'package:news_app_updated/core/routing/app_routes.dart';

import 'package:news_app_updated/core/styles/app_colors.dart';
import 'package:news_app_updated/core/styles/text_styles.dart';
import 'package:news_app_updated/core/widgets/spacing_widget.dart';
import 'package:news_app_updated/features/home_screen/models/article_model.dart';
import 'package:news_app_updated/features/home_screen/widgets/custom_article_item.dart';
import 'package:news_app_updated/features/search_result_screen/services/search_result_services.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text(
          "search_result".tr(),
          style: AppTextStyles.black14SemiBold.copyWith(fontSize: 18.sp),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                if (AppConstants.language == 'en') {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(const Locale('en'));
                }
                AppConstants.language = context.locale.languageCode;
              },
              icon: Icon(Icons.language))
        ],
      ),
      body: FutureBuilder(
          future: SearchResultServices().searchItemByName(query),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              ArticleModel articleModel = snapshot.data! as ArticleModel;
              if (articleModel.totalResults == 0) {
                return Center(
                  child: Text("no_results".tr()),
                );
              }
              return Column(
                children: [
                  HeightSpace(16.h),
                  HeightSpace(24.h),
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            horizontal: 32),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            Article article = articleModel.articles![index];
                            return CustomArticleItem(
                              title: article.title ?? "",
                              authorName: article.author ?? "",
                              date: DateFormat('yyyy-MM-dd – kk:mm')
                                  .format(article.publishedAt!),
                              imageUrl: article.urlToImage ??
                                  " https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.dreamstime.com%2Fdefault-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available-image235041328&psig=AOvVaw1agVJZq2HNEL35929Mby5t&ust=1754530670321000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCPjEs52G9Y4DFQAAAAAdAAAAABAE",
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                  AppRoutes.articleDetailsScreen,
                                  extra: article,
                                );
                              },
                            );
                          },
                          itemCount: articleModel.articles!.length,
                        )),
                  ),
                ],
              );
            }
            return const Center(
              child: Text("Something went wrong"),
            );
          }),
    );
  }
}
