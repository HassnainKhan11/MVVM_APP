import 'package:flutter/material.dart';
import 'package:mvvm_project/resources/colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {super.key,
      required this.title,
      this.loading = false,
      required this.onPress});

  final String title;
  final bool loading;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.blackColor,
        ),
        height: 40,
        width: double.infinity,
        child: Center(
          child: loading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  title.toString(),
                  style: const TextStyle(color: AppColors.whiteColor),
                ),
        ),
      ),
    );
  }
}
