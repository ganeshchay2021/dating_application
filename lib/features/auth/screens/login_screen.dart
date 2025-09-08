import 'package:dating_application/core/constants/color_constants.dart';
import 'package:dating_application/core/constants/text_styles.dart';
import 'package:dating_application/core/routes/route_name.dart';
import 'package:dating_application/core/widgets/custom_button.dart';
import 'package:dating_application/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void dispose() {
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
            colors: isDarkMode
                ? [AppColors.cardDark, AppColors.backgroundDark]
                : [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),

                  //app logo or icon
                  Center(
                    child: Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                  ),

                  //Welcome Text
                  Text(
                    "Welcome Back",
                    style: AppTextStyles.h1Light.copyWith(
                        color: textColor, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  Text(
                    "Sign in to continue your journey",
                    style: AppTextStyles.bodyMediumLight.copyWith(
                        color: isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade700),
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  //email field
                  CustomTextField(
                    controller: _emailController,
                    labelText: "Email",
                    hintText: "Enter your email",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  //password field
                  CustomTextField(
                    controller: _passwordController,
                    labelText: "Password",
                    hintText: "Enter your password",
                    prefixIcon: Icons.lock_outline,
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
                          : const Icon(
                              Icons.visibility,
                              color: AppColors.primary,
                            ),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 16,
                  ),

                  //remember me and forgot password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(
                              color: isDarkMode
                                  ? Colors.grey.shade400
                                  : Colors.grey.shade400,
                              fontSize: 14,
                            ),
                          )
                        ],
                      ),

                      //forgot password
                      CustomButton(
                        size: ButtonSize.small,
                        text: "Forgot Password?",
                        type: ButtonType.text,
                        isFullWidth: false,
                        onPressed: () {
                          //navigate to forgot screen
                          Navigator.pushNamed(
                              context, RoutesName.forgotPassword);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),

                  //sign in button
                  CustomButton(
                    text: "Sign In",
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, RoutesName.discover, (route) => false);
                    },
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  //divider and some text
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              "Or continue with",
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: isDarkMode
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                          )
                        ],
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

                  //don't have account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
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
                          //navigate to signup page
                          Navigator.pushNamed(context, RoutesName.signUp);
                        },
                        child: const Text(
                          "Sign Up",
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
