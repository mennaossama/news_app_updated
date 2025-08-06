import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app_updated/core/routing/app_routes.dart';
import 'package:news_app_updated/core/widgets/custom_text_field.dart';

class CustomSearchTextField extends StatefulWidget {
  const CustomSearchTextField({super.key});

  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  bool showTextField = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        showTextField
            ? CustomTextField(
                width: 200.h,
                hintText: "search".tr(),
                prefixIcon: Icon(
                  Icons.search,
                  color: const Color(0xff8A8184),
                ),
                onFieldSubmitted: (value) {
                  GoRouter.of(context).pushNamed(
                    AppRoutes.searchResultScreen,
                    extra: value.tr(),
                  );
                })
            : SizedBox.shrink(),
        IconButton(
            onPressed: () {
              setState(() {
                showTextField = !showTextField;
              });
            },
            icon: const Icon(
              Icons.search,
              color: Color(0xff231F20),
            )),
      ],
    );
  }
}
