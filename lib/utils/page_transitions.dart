import 'package:flutter/material.dart';
import 'dart:math' as math;

class CineciaTransition extends PageRouteBuilder {
  final Widget page;

  CineciaTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            
            return AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return ClipPath(
                  clipper: CircularRevealClipper(
                    fraction: animation.value,
                    center: const Offset(0.5, 0.5), // Reveal from center
                  ),
                  child: Container(
                    color: Colors.black, // Background during transition
                    child: FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(
                        scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                          CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
                        ),
                        child: child,
                      ),
                    ),
                  ),
                );
              },
              child: child,
            );
          },
        );
}

class CircularRevealClipper extends CustomClipper<Path> {
  final double fraction;
  final Offset center;

  CircularRevealClipper({required this.fraction, required this.center});

  @override
  Path getClip(Size size) {
    Offset revealCenter = Offset(size.width * center.dx, size.height * center.dy);
    
    // Calculate distance to the farthest corner
    double maxRadius = _distanceToFarthestCorner(revealCenter, size);
    
    return Path()
      ..addOval(Rect.fromCircle(
        center: revealCenter,
        radius: maxRadius * fraction,
      ));
  }

  double _distanceToFarthestCorner(Offset center, Size size) {
    List<Offset> corners = [
      const Offset(0.0, 0.0),
      Offset(size.width, 0.0),
      Offset(0.0, size.height),
      Offset(size.width, size.height),
    ];
    
    double maxDist = 0;
    for (var corner in corners) {
      double dist = (center - corner).distance;
      if (dist > maxDist) maxDist = dist;
    }
    return maxDist;
  }

  @override
  bool shouldReclip(CircularRevealClipper oldClipper) => oldClipper.fraction != fraction;
}
