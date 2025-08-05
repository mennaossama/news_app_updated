import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_updated/core/styles/text_styles.dart';
import 'package:news_app_updated/core/widgets/spacing_widget.dart';
import 'package:news_app_updated/features/home_screen/models/top_headline_model.dart';
import 'package:news_app_updated/features/home_screen/services/home_screen_services.dart';
import 'package:news_app_updated/features/home_screen/widgets/custom_article_item.dart';
import 'package:news_app_updated/features/home_screen/widgets/custom_category_item.dart';
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
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xff231F20),
                  )),
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
                TopHeadLinesModel topHeadLinesModel =
                    snapshot.data! as TopHeadLinesModel;
                if (topHeadLinesModel.totalResults == 0) {
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
                            CustomCategoryItem(title: "travel".tr()),
                            CustomCategoryItem(title: "technology".tr()),
                            CustomCategoryItem(title: "business".tr()),
                            CustomCategoryItem(title: "entertainment".tr()),
                          ],
                        ),
                      ),
                    ),
                    HeightSpace(32.h),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 32),
                      child: TopHeadlineItemWidget(
                        title: topHeadLinesModel.articles![0].title ?? "",
                        authorName: topHeadLinesModel.articles![0].author ?? "",
                        date: "8 August 2025",
                        imageUrl: topHeadLinesModel.articles![0].urlToImage ??
                            "https://www.cnet.com/a/img/resize/bde1b8ca1b9373b61bbf9d3e113a81ac76297b51/hub/2024/09/13/0df30744-a33f-4c6e-b58c-a90d7a914089/apple-iphone-16-2815.jpg?auto=webp&height=500",
                      ),
                    ),
                    HeightSpace(24.h),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 32),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              Article article =
                                  topHeadLinesModel.articles![index];
                              return CustomArticleItem(
                                title: article.title ?? "",
                                authorName: article.author ?? "",
                                date: "6 august 2025",
                                imageUrl: article.urlToImage ??
                                    "https://www.cnet.com/a/img/resize/bde1b8ca1b9373b61bbf9d3e113a81ac76297b51/hub/2024/09/13/0df30744-a33f-4c6e-b58c-a90d7a914089/apple-iphone-16-2815.jpg?auto=webp&height=500",
                              );
                            },
                            itemCount: topHeadLinesModel.articles!.length,
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
