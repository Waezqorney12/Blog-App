import 'package:blog_application/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key, required this.buttonName, required this.onTap});
  final void Function() onTap;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [AppPallete.gradient1, AppPallete.gradient2], begin: Alignment.bottomLeft, end: Alignment.topRight),
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppPallete.transparentColor,
              shadowColor: AppPallete.transparentColor,
              fixedSize: Size(MediaQuery.of(context).size.width, 55)),
          child: Text(
            buttonName,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppPallete.whiteColor),
          )),
    );
  }
}
