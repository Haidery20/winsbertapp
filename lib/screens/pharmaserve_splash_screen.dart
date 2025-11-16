import 'package:flutter/material.dart';
import '../widgets/pharmaserve_logo.dart';

class PharmaServeSplashScreen extends StatefulWidget {
  const PharmaServeSplashScreen({super.key});

  @override
  State<PharmaServeSplashScreen> createState() => _PharmaServeSplashScreenState();
}

class _PharmaServeSplashScreenState extends State<PharmaServeSplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeInOut),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.elasticOut),
      ),
    );
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
      ),
    );
    
    _controller.forward();
    
    // Navigate to home after animation completes
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value * _pulseAnimation.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main logo with glow effect
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 30,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                      child: PharmaServeLogo(
                        size: 120,
                        showText: false,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // App name with fade-in animation
                    AnimatedOpacity(
                      opacity: _controller.value > 0.5 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 1000),
                      child: Column(
                        children: [
                          Text(
                            'PharmaServe',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.0,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Your Pharmaceutical Partner',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                              letterSpacing: 1.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Loading indicator with fade-in
                    AnimatedOpacity(
                      opacity: _controller.value > 0.7 ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 800),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 200,
                            child: LinearProgressIndicator(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                              minHeight: 3,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Loading your pharmacy...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}