import 'package:dating_application/core/constants/color_constants.dart';
import 'package:dating_application/core/constants/text_styles.dart';
import 'package:dating_application/core/routes/route_name.dart';
import 'package:dating_application/core/widgets/custom_button.dart';
import 'package:dating_application/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : AppColors.textPrimaryLight;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode
                ? [AppColors.cardDark, AppColors.backgroundDark]
                : [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: textColor,
                    ),
                    constraints: const BoxConstraints(),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //create account text
                  Text(
                    "Create Account",
                    style: AppTextStyles.h1Light.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  //info text
                  Text(
                    "Find your perfect match today",
                    style: AppTextStyles.bodyLargeLight.copyWith(
                      color: isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  // Full Name Textfield
                  CustomTextField(
                    controller: _nameController,
                    labelText: "Full Name",
                    prefixIcon: Icons.person_3_outlined,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Email Textfield
                  CustomTextField(
                    controller: _emailController,
                    labelText: "Email address",
                    prefixIcon: Icons.email_outlined,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  // Passowrd textfield
                  CustomTextField(
                    controller: _passwordController,
                    labelText: "Password",
                    prefixIcon: Icons.lock_outlined,
                    obscureText: !_isPasswordVisible,
                    suffix: IconButton(
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      icon: _isPasswordVisible
                          ? const Icon(
                              Icons.visibility_off,
                              color: AppColors.primary,
                            )
                          : const Icon(Icons.visibility,
                              color: AppColors.primary),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  //Terms and conditions
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                          activeColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade700,
                              fontSize: 14,
                            ),
                            children: const [
                              TextSpan(text: "I agree to the "),
                              TextSpan(
                                text: "Terms of Services",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(text: "and "),
                              TextSpan(
                                text: "Privacy Policy",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //create account button
                  CustomButton(
                    text: "Create Account",
                    type: ButtonType.primary,
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.verification);
                    },
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  //divider and sign up with text
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: isDarkMode
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Or sign up with",
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: isDarkMode
                              ? Colors.grey.shade800
                              : Colors.grey.shade300,
                          thickness: 1,
                        ),
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  //Social Login Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialLoginButton(
                          onTap: () {},
                          color: isDarkMode ? Colors.white : Colors.black,
                          icon: Icons.g_mobiledata_rounded,
                          isDarkMode: isDarkMode),
                      const SizedBox(
                        width: 20,
                      ),
                      _socialLoginButton(
                          onTap: () {},
                          color: isDarkMode ? Colors.white : Colors.black,
                          icon: Icons.apple_rounded,
                          isDarkMode: isDarkMode),
                      const SizedBox(
                        width: 20,
                      ),
                      _socialLoginButton(
                          onTap: () {},
                          color: const Color(0xFF1877F2),
                          icon: Icons.facebook_rounded,
                          isDarkMode: isDarkMode),
                    ],
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  //Already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade700,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        onPressed: () {
                          //navigate to sigin page
                          Navigator.pushNamedAndRemoveUntil(
                              context, RoutesName.login, (route) => false);
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton({
    required VoidCallback onTap,
    required Color color,
    required IconData icon,
    required bool isDarkMode,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: isDarkMode
                ? Colors.grey.shade800.withOpacity(0.5)
                : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12)),
        child: Icon(
          icon,
          size: 32,
          color: color,
        ),
      ),
    );
  }
}
