import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_updated/core/styles/app_colors.dart';
import 'package:news_app_updated/core/styles/text_styles.dart';
import 'package:news_app_updated/core/widgets/spacing_widget.dart';
import 'package:news_app_updated/features/home_screen/models/article_model.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final Article article;
  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    String author = article.author ?? "No Author";
    String date = DateFormat('yyyy-MM-dd – kk:mm').format(article.publishedAt!);
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: article.urlToImage ??
              "https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=",
          height: 300.h,
          errorWidget: (context, url, error) => const Icon(Icons.error),
          fit: BoxFit.fill,
        ),
        Positioned(
          top: 280.h,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsetsDirectional.symmetric(
                horizontal: 32.w, vertical: 24.h),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                )),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(article.title ?? "No Title",
                      style: AppTextStyles.black14SemiBold
                          .copyWith(fontSize: 18.sp)),
                  HeightSpace(16.h),
                  Text("$author . $date",
                      style: AppTextStyles.grey14Regular
                          .copyWith(fontSize: 12.sp)),
                  HeightSpace(24.h),
                  Text(article.description ?? "No description",
                      style: AppTextStyles.black14SemiBold.copyWith(
                          fontSize: 16.sp, fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
