import 'dart:async';

import 'package:dating_application/core/constants/color_constants.dart';
import 'package:dating_application/core/constants/string_constants.dart';
import 'package:dating_application/core/constants/text_styles.dart';
import 'package:dating_application/core/routes/route_name.dart';
import 'package:dating_application/core/services/prefrences_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _pulseAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(
            tween: Tween<double>(begin: 0.5, end: 1.0), weight: 1),
        TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 0.5), weight: 1),
        TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1.0), weight: 1)
      ],
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();

    //navigate to next screen after splash screeh
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    bool hasNavigate = false;

    Timer(
      const Duration(seconds: 5),
      () {
        if (mounted && !hasNavigate) {
          hasNavigate = true;
          Navigator.pushReplacementNamed(context, RoutesName.welcome);
        }
      },
    );

    try {
      await Future.delayed(const Duration(seconds: 3));
      if (!mounted || hasNavigate) return;

      //check if the user seen welcome screen and is logged in
      bool hasSeenWelcome = false;
      bool hasLoggedIn = false;

      try {
        hasSeenWelcome = await PreferencesService.hasSeenWelcome();
      } catch (e) {}

      if (hasNavigate) return;
      hasNavigate = true;

      if (hasLoggedIn) {
        //user has logged in go directly to discover screen
        Navigator.pushReplacementNamed(context, RoutesName.discover);
      } else if (hasSeenWelcome) {
        Navigator.pushReplacementNamed(context, RoutesName.login);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.welcome);
      }
    } catch (e) {
      if (mounted && !hasNavigate) {
        hasNavigate = true;
        Navigator.pushReplacementNamed(context, RoutesName.welcome);
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? const [
                    Color(0xFF0F0F1E),
                    Color(0xFF1A1A2E),
                    Color(0xFF16213E)
                  ]
                : [
                    AppColors.primary.withOpacity(0.8),
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.9)
                  ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -size.width * 0.2,
              left: -size.width * 0.2,
              child: Container(
                height: size.width * 0.7,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05)),
              ),
            ),
            Positioned(
              top: -size.width * 0.3,
              left: -size.width * 0.3,
              child: Container(
                height: size.width * 0.8,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05)),
              ),
            ),
            //main Content
            Center(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => FadeTransition(
                  opacity: _fadeAnimation,
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.primary
                                        .withOpacity(isDarkMode ? 0.3 : 0.5),
                                    blurRadius: 10,
                                    spreadRadius: 5),
                              ]),
                          child: Transform.scale(
                            scale: _pulseAnimation.value,
                            child: const Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 70,
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 40,
                        ),

                        //app name
                        Text(
                          AppStrings.appName,
                          style: AppTextStyles.h1Light.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 32,
                              letterSpacing: 1.0),
                        ),

                        const SizedBox(
                          height: 12,
                        ),

                        //tagline
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Find your perfect match",
                            style: AppTextStyles.bodyMediumLight.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 0.5),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
