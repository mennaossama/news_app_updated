import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app_updated/core/styles/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? width;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;
  const CustomTextField(
      {super.key,
      this.hintText,
      this.suffixIcon,
      this.width,
      this.isPassword,
      this.controller,
      this.validator,
      this.prefixIcon,
      this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width ?? 331.w,
        child: TextFormField(
            controller: controller,
            validator: validator,
            autofocus: false,
            obscureText: isPassword ?? false,
            cursorColor: AppColors.blackColor,
            onFieldSubmitted: onFieldSubmitted,
            decoration: InputDecoration(
              hintText: hintText ?? "",
              hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xff8391A1),
                  fontWeight: FontWeight.w500),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: Color(0xffE8ECF4), width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide:
                      const BorderSide(color: AppColors.blackColor, width: 1)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: Colors.red, width: 1)),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              filled: true,
              fillColor: const Color(0xffF0EFF0),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
            )));
  }
}
