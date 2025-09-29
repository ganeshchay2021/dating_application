import 'package:dating_application/core/constants/color_constants.dart';
import 'package:dating_application/core/constants/string_constants.dart';
import 'package:flutter/material.dart';

class ProfilesetupScreen extends StatefulWidget {
  const ProfilesetupScreen({super.key});

  @override
  State<ProfilesetupScreen> createState() => _ProfilesetupScreenState();
}

class _ProfilesetupScreenState extends State<ProfilesetupScreen> {
  @override
  Widget build(BuildContext context) {
  // final provider = context.watch<OnboardingProvider>();
  final isDarkMode= Theme.of(context).brightness==Brightness.dark;
  final textColor=isDarkMode? Colors.white: AppColors.textPrimaryLight;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.createProfile)
      ),
    );
  }
}
