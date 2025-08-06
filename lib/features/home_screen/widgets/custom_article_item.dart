import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_updated/core/styles/text_styles.dart';
import 'package:news_app_updated/core/widgets/spacing_widget.dart';

class CustomArticleItem extends StatelessWidget {
  final String title;
  final String authorName;
  final String date;
  final String? imageUrl;
  final void Function()? onTap;
  const CustomArticleItem({
    super.key,
    required this.title,
    required this.authorName,
    required this.date,
    this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 238.w,
                  child: Text(
                    title,
                    maxLines: 2,
                    style: AppTextStyles.titlesStyles
                        .copyWith(fontSize: 18.sp, color: Colors.black),
                  ),
                ),
                const HeightSpace(8),
                SizedBox(
                  width: 238.w,
                  child: Text(
                    "$authorName . $date",
                    style: AppTextStyles.grey14Regular.copyWith(),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 112.w,
              height: 80.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl ??
                      "https://media.istockphoto.com/id/1369150014/vector/breaking-news-with-world-map-background-vector.jpg?s=612x612&w=0&k=20&c=9pR2-nDBhb7cOvvZU_VdgkMmPJXrBQ4rB1AkTXxRIKM=",
                  height: 206.h,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
