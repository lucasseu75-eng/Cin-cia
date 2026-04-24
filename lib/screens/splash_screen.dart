import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen.dart';
import '../utils/app_branding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _portalScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoY;
  late Animation<double> _logoX;
  late Animation<double> _logoScale;
  late Animation<Color?> _bgColor;
  late Animation<Color?> _textColor;
  late Animation<double> _textOpacity;

  final Color cineciRed = const Color(0xFFD84444);
  final Color cineciWhite = Colors.white;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000), // La durée de ton animation
    );

    // 1. Démarrage : Le portail se ferme
    _portalScale = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.10, 0.30, curve: Curves.easeInOutCubic),
      ),
    );

    // 2. Apparition du logo
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.16, 0.17, curve: Curves.linear),
      ),
    );

    // 3. Séquence Y - REBOND EN DOUCEUR
    _logoY = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(20.0), weight: 10.0),
      TweenSequenceItem(
        tween: Tween(begin: 20.0, end: -120.0).chain(CurveTween(curve: Curves.easeOutSine)),
        weight: 20.0,
      ),
      TweenSequenceItem(tween: ConstantTween(-120.0), weight: 10.0),
      TweenSequenceItem(
        tween: Tween(begin: -120.0, end: 0.0).chain(CurveTween(curve: Curves.easeInSine)),
        weight: 15.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -25.0).chain(CurveTween(curve: Curves.easeOutSine)),
        weight: 8.0,
      ),
      TweenSequenceItem(
        tween: Tween(begin: -25.0, end: 0.0).chain(CurveTween(curve: Curves.easeInSine)),
        weight: 7.0,
      ),
      // GLISSEMENT OBLIQUE (Y)
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: -15.0).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 20.0,
      ),
      TweenSequenceItem(tween: ConstantTween(-15.0), weight: 10.0),
    ]).animate(_controller);

    // 4. Glissement X et Scale
    _logoX = Tween<double>(begin: 0.0, end: 75.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.70, 0.90, curve: Curves.easeInOutCubic),
      ),
    );

    _logoScale = Tween<double>(begin: 1.0, end: 0.75).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.70, 0.90, curve: Curves.easeInOut),
      ),
    );

    // 5. Apparition du texte "Cinéci"
    _textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.80, 0.90, curve: Curves.easeIn),
      ),
    );

    // 6. INVERSION DES COULEURS
    _bgColor = ColorTween(
      begin: cineciRed,
      end: cineciWhite,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.90, 1.0, curve: Curves.easeInOut),
      ),
    );

    _textColor = ColorTween(
      begin: cineciWhite,
      end: cineciRed,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.90, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Écouter la fin pour naviguer avec un délai de 3 secondes !
    _controller.addStatusListener((status) async { // <-- Ajout de 'async' ici
      if (status == AnimationStatus.completed) {

        // --- LA PAUSE DE 3 SECONDES EST ICI ---
        await Future.delayed(const Duration(seconds: 2));

        // Sécurité : on vérifie si l'écran est toujours affiché après les 3s
        if (!mounted) return;

        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 800), // Durée du fondu
            pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: _bgColor.value,
          body: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // --- LE TEXTE "Cinéci" ---
                Transform.translate(
                  offset: const Offset(-35, -15),
                  child: Opacity(
                    opacity: _textOpacity.value,
                    child: Text(
                      AppBranding.animationTitle,
                      style: GoogleFonts.itim(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: _textColor.value,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),

                // --- LE PORTAIL ---
                Transform.scale(
                  scale: _portalScale.value,
                  child: Container(
                    width: 250,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.elliptical(125, 30)),
                    ),
                  ),
                ),

                // --- LE LOGO AVATAR ---
                Transform.translate(
                  offset: Offset(_logoX.value, _logoY.value),
                  child: Transform.scale(
                    scale: _logoScale.value,
                    child: Opacity(
                      opacity: _logoOpacity.value,
                      child: Image.asset(
                        'assets/icon/Logo_cinecia.png',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}