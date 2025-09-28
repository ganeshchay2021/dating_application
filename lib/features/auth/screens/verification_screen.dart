import 'dart:async';

import 'package:dating_application/core/constants/text_styles.dart';
import 'package:dating_application/core/routes/route_name.dart';
import 'package:dating_application/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/color_constants.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> _controller = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNode = List.generate(
    4,
    (_) => FocusNode(),
  );

  int _resendSeconds = 60;
  Timer? _timer;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (context) {
      setState(() {
        if (_resendSeconds > 0) {
          _resendSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _verifyCode() {
    setState(() {
      _isVerifying = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, RoutesName.profileSetup, (route) => false);
    });
  }

  void _reSendCode() {
    setState(() {
      _resendSeconds = 60;
    });
    _startResendTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controller) {
      controller.dispose();
    }

    for (var focusNode in _focusNode) {
      focusNode.dispose();
    }
    super.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //back button
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: textColor,
                  size: 24,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              //verification text
              Text(
                "Verification",
                style: AppTextStyles.h1Light
                    .copyWith(color: textColor, fontWeight: FontWeight.w700),
              ),

              const SizedBox(
                height: 24,
              ),

              //info text
              Text(
                "We've send a verification code to your email address",
                style: AppTextStyles.bodyMediumLight.copyWith(
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                ),
              ),
              const SizedBox(
                height: 24,
              ),

              //verification illustration
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  height: 120,
                  width: 120,
                  child: const Icon(
                    Icons.verified_user_outlined,
                    size: 60,
                    color: AppColors.primary,
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    height: 64,
                    width: 64,
                    child: TextField(
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade200,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none),
                      ),
                      controller: _controller[index],
                      focusNode: _focusNode[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                      onChanged: (value) {
                        //backwark focused
                        if (value.isEmpty && index > 0) {
                          _focusNode[index].unfocus();
                          FocusScope.of(context).requestFocus(
                            _focusNode[index - 1],
                          );
                        }
                        //forward focused
                        else if (value.isNotEmpty && index < 3) {
                          _focusNode[index].unfocus();
                          FocusScope.of(context).requestFocus(
                            _focusNode[index + 1],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //verify button
              CustomButton(
                text: "Verify",
                isLoading: _isVerifying,
                onPressed: () {
                  _verifyCode();
                },
              ),

              const SizedBox(
                height: 24,
              ),

              Center(
                child: Column(
                  children: [
                    Text(
                      "Don't received the code",
                      style: TextStyle(
                        color: isDarkMode
                            ? Colors.grey.shade400
                            : Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),

                    //resend code
                    TextButton(
                      onPressed: () {
                        if (_resendSeconds <= 0) {
                          _reSendCode();
                        }
                      },
                      child: Text(
                        _resendSeconds > 0
                            ? "Resend code in $_resendSeconds S"
                            : "Resend Code",
                        style: TextStyle(
                            color: _resendSeconds > 0
                                ? isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade700
                                : AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              //help and contact support
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Need help? Contact Support",
                    style: TextStyle(
                      color: isDarkMode
                          ? Colors.grey.shade400
                          : Colors.grey.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
