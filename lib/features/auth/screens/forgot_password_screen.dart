import 'package:dating_application/core/constants/color_constants.dart';
import 'package:dating_application/core/constants/text_styles.dart';
import 'package:dating_application/core/routes/route_name.dart';
import 'package:dating_application/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isSubmitting = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

void _handleSubmit() {
  setState(() {
    _isSubmitting = true;
  });

  Future.delayed(const Duration(seconds: 2), () {
    setState(() {
      _isSubmitting = false;
      _emailSent = true;
    });
  });
}


  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : AppColors.textPrimaryLight;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.3],
            colors: isDarkMode
                ? [AppColors.cardDark, AppColors.backgroundDark]
                : [Colors.white, Colors.grey.shade50],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    //backward navigation
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 32,
                    color: textColor,
                  ),
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  "Forgot Password",
                  style: AppTextStyles.h1Light.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "Enter your email address and we'ill send you a link to reset your password",
                  style: AppTextStyles.bodyMediumLight.copyWith(
                    color: isDarkMode
                        ? Colors.grey.shade400
                        : Colors.grey.shade700,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
            
                //email and check logo
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _emailSent
                          ? Icons.check_circle_outline
                          : Icons.mail_outline_outlined,
                      size: 60,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            
                const SizedBox(
                  height: 40,
                ),
            
                if (!_emailSent) ...[
                  //email textfield
                  CustomTextField(
                    controller: _emailController,
                    labelText: "Email",
                    hintText: "Enter your email",
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 22,
                  ),
            
                  //submit button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16))),
                    onPressed: _isSubmitting ? null : _handleSubmit,
                    child: _isSubmitting
                        ? const CircularProgressIndicator(
                            color: AppColors.primary,
                            strokeWidth: 2,
                          )
                        : const Text(
                            "Send Reset Link",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                  )
                ] else ...[
                  Center(
                    child: Text(
                      "Reset Link Send!",
                      style: AppTextStyles.h2Light.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      "Check your email inbox and follow the instructions to reset your password",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bodyMediumLight.copyWith(
                          color: isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade700),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, RoutesName.login);
                    },
                    child: _isSubmitting
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text(
                            "Back to Login",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
            
                  //resend email
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      minimumSize: const Size(double.infinity, 44),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _emailSent = false;
                      });
                    },
                    child: const Text(
                      "Resend email",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                const Spacer(),
                //resend email
                if (!_emailSent)
                  Center(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity, 56)),
                      onPressed: () {},
                      child: Text(
                        "Need help ? Contact Support",
                        style: TextStyle(
                            color: isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade700,
                            fontSize: 14),
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
