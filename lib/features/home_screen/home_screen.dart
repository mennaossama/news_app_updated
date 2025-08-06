import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_updated/core/constants/app_constants.dart';
import 'package:news_app_updated/core/routing/app_routes.dart';
import 'package:news_app_updated/core/styles/text_styles.dart';
import 'package:news_app_updated/core/widgets/spacing_widget.dart';
import 'package:news_app_updated/features/home_screen/models/article_model.dart';
import 'package:news_app_updated/features/home_screen/services/home_screen_services.dart';
import 'package:news_app_updated/features/home_screen/widgets/custom_article_item.dart';
import 'package:news_app_updated/features/home_screen/widgets/custom_category_item.dart';
import 'package:news_app_updated/features/home_screen/widgets/custom_search_text_field.dart';
import 'package:news_app_updated/features/home_screen/widgets/top_headline_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xffE9EEFA),
            toolbarHeight: 120.h,
            title: Text("explore".tr(), style: AppTextStyles.titlesStyles),
            actions: [
              CustomSearchTextField(),
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
            ]),
        body: FutureBuilder(
            future: HomeScreenServices().getTopHealinesArticles(),
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
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 32),
                      child: SizedBox(
                        height: 40.h,
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: [
                            CustomCategoryItem(
                              title: "travel".tr(),
                              onTap: () {
                                GoRouter.of(context).pushNamed(
                                    AppRoutes.searchResultScreen,
                                    extra: "travel".tr());
                              },
                            ),
                            CustomCategoryItem(
                                title: "technology".tr(),
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRoutes.searchResultScreen,
                                      extra: "technology".tr());
                                }),
                            CustomCategoryItem(
                                title: "business".tr(),
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRoutes.searchResultScreen,
                                      extra: "business".tr());
                                }),
                            CustomCategoryItem(
                                title: "entertainment".tr(),
                                onTap: () {
                                  GoRouter.of(context).pushNamed(
                                      AppRoutes.searchResultScreen,
                                      extra: "entertainment".tr());
                                }),
                          ],
                        ),
                      ),
                    ),
                    HeightSpace(32.h),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 32),
                      child: TopHeadlineItemWidget(
                        title: articleModel.articles![0].title ?? "",
                        authorName: articleModel.articles![0].author ?? "",
                        date: DateFormat('yyyy-MM-dd – kk:mm')
                            .format(articleModel.articles![0].publishedAt!),
                        imageUrl: articleModel.articles![0].urlToImage ??
                            "https://www.cnet.com/a/img/resize/bde1b8ca1b9373b61bbf9d3e113a81ac76297b51/hub/2024/09/13/0df30744-a33f-4c6e-b58c-a90d7a914089/apple-iphone-16-2815.jpg?auto=webp&height=500",
                        onTap: () {
                          setState(() {});
                          GoRouter.of(context).pushNamed(
                            AppRoutes.articleDetailsScreen,
                            extra: articleModel.articles![0],
                          );
                        },
                      ),
                    ),
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
                                  setState(() {});
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
            }));
  }
}
