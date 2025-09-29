import 'package:dating_application/core/constants/color_constants.dart';
import 'package:dating_application/core/constants/string_constants.dart';
import 'package:dating_application/core/constants/text_styles.dart';
import 'package:dating_application/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/onboarding_provider.dart';

class ProfilesetupScreen extends StatefulWidget {
  const ProfilesetupScreen({super.key});

  @override
  State<ProfilesetupScreen> createState() => _ProfilesetupScreenState();
}

class _ProfilesetupScreenState extends State<ProfilesetupScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OnboardingProvider>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : AppColors.textPrimaryLight;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: isDarkMode ? AppColors.cardDark : AppColors.primary,
        title: const Text(
          AppStrings.createProfile,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [AppColors.cardDark, AppColors.backgroundDark]
                : [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tell us about yourself",
                  style: AppTextStyles.h2Light.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "This information helps us find better matches for you.",
                  style: AppTextStyles.bodyMediumLight.copyWith(
                    color: isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),

                //text for name
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppStrings.name,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: isDarkMode
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.7),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: textColor),
                  onChanged: provider.updateName,
                ),

                const SizedBox(
                  height: 20,
                ),

                //textfield for boi
                TextFormField(
                  decoration: InputDecoration(
                    labelText: AppStrings.bio,
                    prefixIcon: Icon(
                      Icons.edit_note_outlined,
                      color: isDarkMode
                          ? AppColors.primary
                          : AppColors.primary.withOpacity(0.7),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  style: TextStyle(color: textColor),
                  onChanged: provider.updateBio,
                ),

                const SizedBox(
                  height: 20,
                ),

                //dropdown button
                DropdownButtonFormField<String>(
                  items: [AppStrings.male, AppStrings.female]
                      .map(
                        (gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ),
                      )
                      .toList(),
                  dropdownColor:
                      isDarkMode ? Colors.grey.shade900 : Colors.white,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.people_outline,
                          color: isDarkMode
                              ? AppColors.primary
                              : AppColors.primary.withOpacity(0.7)),
                      labelText: AppStrings.gender),
                  onChanged: (value) {},
                ),

                const SizedBox(
                  height: 30,
                ),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16)),
                    onPressed: provider.name.isNotEmpty
                        ? () =>
                            Navigator.pushNamed(context, RoutesName.photoUpload)
                        : null,
                    child: const Text(
                      AppStrings.next,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
