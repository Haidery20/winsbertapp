import 'package:flutter/material.dart';

class PharmaServeLogo extends StatelessWidget {
  final double size;
  final bool showText;
  final bool showGlow;
  final Color? customColor;
  final bool useCustomImage;
  
  const PharmaServeLogo({
    super.key,
    this.size = 100,
    this.showText = false,
    this.showGlow = false,
    this.customColor,
    this.useCustomImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = customColor ?? Theme.of(context).colorScheme.primary;
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (useCustomImage)
          // Use the custom PNG logo from images folder
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size * 0.25),
              boxShadow: showGlow ? [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 8,
                  offset: const Offset(0, 8),
                ),
              ] : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size * 0.25),
              child: Image.asset(
                'images/pharmaserve-logo.png',
                width: size,
                height: size,
                fit: BoxFit.contain,
              ),
            ),
          )
        else
          // Fallback to the generated logo design
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color,
                  color.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(size * 0.25),
              boxShadow: showGlow ? [
                BoxShadow(
                  color: color.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 8,
                  offset: const Offset(0, 8),
                ),
              ] : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Cross shape (pharmacy symbol)
                  Positioned(
                    top: size * 0.15,
                    bottom: size * 0.15,
                    left: size * 0.45,
                    right: size * 0.45,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Positioned(
                    left: size * 0.15,
                    right: size * 0.15,
                    top: size * 0.45,
                    bottom: size * 0.45,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  // Center circle
                  Container(
                    width: size * 0.25,
                    height: size * 0.25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size * 0.125),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'P',
                        style: TextStyle(
                          fontSize: size * 0.15,
                          fontWeight: FontWeight.bold,
                          color: color,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        if (showText) ...[
          const SizedBox(height: 12),
          Text(
            'PharmaServe',
            style: TextStyle(
              fontSize: size * 0.18,
              fontWeight: FontWeight.bold,
              color: color,
              letterSpacing: 1.5,
              fontFamily: 'serif',
            ),
          ),
          Text(
            'Professional Pharmaceutical Services',
            style: TextStyle(
              fontSize: size * 0.08,
              color: color.withOpacity(0.7),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}