import 'package:dating_application/core/constants/color_constants.dart';
import 'package:dating_application/core/constants/string_constants.dart';
import 'package:dating_application/core/constants/text_styles.dart';
import 'package:dating_application/core/routes/route_name.dart';
import 'package:dating_application/core/services/prefrences_services.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? const [Colors.black, Color(0xFF1A1A2E), Color(0xFF16213E)]
                  : AppColors.primaryGradient),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 60,
                ),

                //text information with app name
                Column(
                  children: [
                    Text(
                      AppStrings.welcome,
                      style: AppTextStyles.bodyLargeLight.copyWith(
                        color: Colors.white,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      AppStrings.findYourMatch,
                      style: AppTextStyles.bodyLargeLight.copyWith(
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 0.3),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                //Welcome heart break image
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 32),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Image.asset(
                        "assets/images/heartlink_logo.png",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: 64,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Column(
                    children: [
                      //go to login Signup button

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDark ? AppColors.primary : Colors.white,
                          foregroundColor:
                              isDark ? Colors.white : AppColors.primary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                          minimumSize: const Size(double.infinity, 56),
                        ),
                        onPressed: () async {
                          try {
                            //mark welcome screen as seen
                            await PreferencesService.setWelcomeSeen();

                            if (context.mounted) {
                              Navigator.pushReplacementNamed(
                                  context, RoutesName.signUp);
                            }
                          } catch (e) {
                            debugPrint(
                                "Error in welcome screen navigation: $e");
                          }
                        },
                        child: Text(
                          "Create an account",
                          style: AppTextStyles.buttonLarge.copyWith(
                            color: isDark ? Colors.white : AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                      //go to login screen button
                      TextButton(
                        onPressed: () async {
                          //mark welcome screen as seen
                          await PreferencesService.setWelcomeSeen();

                          try {
                            if (context.mounted) {
                              Navigator.pushReplacementNamed(
                                  context, RoutesName.login);
                            }
                          } catch (e) {
                            debugPrint(
                                "Error in welcome screen navigation: $e");
                          }
                        },
                        child: const Text(
                          "Already have an account? Sign In",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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
