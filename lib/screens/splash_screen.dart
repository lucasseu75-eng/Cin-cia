import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey _aKey = GlobalKey();
  Offset _aTargetOffset = Offset.zero;
  
  // Timestamps de la séquence (0.0 à 1.0)
  static const double _tHoleOpenStart = 0.0;
  static const double _tHoleOpenEnd = 0.15;
  static const double _tIconRiseStart = 0.10; 
  static const double _tIconRiseEnd = 0.35; 
  static const double _tHoleCloseStart = 0.35;
  static const double _tHoleCloseEnd = 0.45;
  static const double _tIconFallStart = 0.45;
  static const double _tIconFallEnd = 0.65;
  static const double _tTypewriterStart = 0.65;
  static const double _tTypewriterEnd = 0.85;
  static const double _tFinalInteractionStart = 0.86;
  static const double _tFinalInteractionEnd = 0.95;
  static const double _tColorFlipStart = 0.96;
  static const double _tColorFlipEnd = 1.0;

  // Animations
  late Animation<double> _holeScale;
  late Animation<double> _iconRiseY;
  late Animation<double> _iconFallY;
  late Animation<double> _iconRiseScale;
  late Animation<double> _iconOpacity;
  late Animation<int> _textIndex;
  late Animation<double> _aOpacity;
  late Animation<double> _iconFinalScale;
  late Animation<Color?> _bgColor;
  late Animation<Color?> _contentColor;

  final String _brandName = "Cinécia";
  final Color _deepRed = const Color(0xFF701111);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5500), 
    );

    // Initialisation des animations...
    _holeScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeOutBack)), weight: 15),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeIn)), weight: 10),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 55),
    ]).animate(_controller);

    _iconRiseY = Tween<double>(begin: 60.0, end: -300.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(_tIconRiseStart, _tIconRiseEnd, curve: Curves.easeOutCubic)),
    );
    _iconRiseScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(_tIconRiseStart, _tIconRiseStart + 0.1, curve: Curves.easeOut)),
    );
    
    _iconOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 10), 
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 5), 
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 85),
    ]).animate(_controller);

    _iconFallY = Tween<double>(begin: -300.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(_tIconFallStart, _tIconFallEnd, curve: Curves.bounceOut)),
    );

    _textIndex = IntTween(begin: 0, end: _brandName.length).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(_tTypewriterStart, _tTypewriterEnd, curve: Curves.linear)),
    );

    _aOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(_tFinalInteractionStart, _tFinalInteractionStart + 0.02)),
    );

    _iconFinalScale = Tween<double>(begin: 1.0, end: 1.0).animate(_controller);

    _bgColor = ColorTween(begin: _deepRed, end: Colors.white).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(_tColorFlipStart, _tColorFlipEnd, curve: Curves.easeInOut)),
    );
    _contentColor = ColorTween(begin: Colors.white, end: _deepRed).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(_tColorFlipStart, _tColorFlipEnd, curve: Curves.easeInOut)),
    );

    // Mesure de la position de la lettre 'a'
    _controller.addListener(() {
      if (_controller.value >= _tFinalInteractionStart - 0.01 && _aTargetOffset == Offset.zero) {
        _measureTargetPosition();
      }
    });

    _controller.forward().then((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const OnboardingScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 1000),
            ),
          );
        });
      }
    });
  }

  void _measureTargetPosition() {
    final RenderBox? renderBox = _aKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final screenCenter = MediaQuery.of(context).size / 2;
      
      setState(() {
        // On calcule l'offset par rapport au centre de l'écran car le logo est centré par défaut
        // On ajoute la moitié de la taille de la lettre pour viser le centre exact
        // On ajoute +4.0 pour décaler légèrement vers la droite selon la demande
        _aTargetOffset = Offset(
          position.dx - screenCenter.width + (size.width / 2) + 8.0,
          position.dy - screenCenter.height + (size.height / 2),
        );
      });
    }
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
        final currentBG = _bgColor.value ?? _deepRed;
        final currentContent = _contentColor.value ?? Colors.white;
        
        final hasReachedEnd = _textIndex.value == _brandName.length;
        final mainPart = hasReachedEnd ? "Cinéci" : _brandName.substring(0, _textIndex.value);
        final lastLetter = hasReachedEnd ? "a" : "";

        double finalX = 0;
        double finalY = 0;
        
        if (_aTargetOffset != Offset.zero) {
          finalX = _aTargetOffset.dx;
          finalY = _aTargetOffset.dy;
        } else {
          // Valeurs de secours si non encore mesuré
          finalX = 88.0;
          finalY = 30.0;
        }

        double iconY = 0;
        if (_controller.value < _tIconFallStart) {
          iconY = _iconRiseY.value;
        } else {
          iconY = _iconFallY.value;
        }

        if (_controller.value >= _tFinalInteractionStart) {
          final t = (_controller.value - _tFinalInteractionStart) / (_tFinalInteractionEnd - _tFinalInteractionStart);
          final easedT = Curves.easeInOutQuart.transform(t.clamp(0.0, 1.0));
          final currentX = easedT * finalX;
          final currentY = easedT * finalY;
          
          return _buildScaffold(currentBG, currentContent, mainPart, lastLetter, hasReachedEnd, currentX, currentY, 60);
        }

        return _buildScaffold(currentBG, currentContent, mainPart, lastLetter, hasReachedEnd, 0, iconY, 90);
      },
    );
  }

  Widget _buildScaffold(Color bg, Color content, String mainPart, String lastLetter, bool hasReachedEnd, double x, double y, double iconSize) {
    return Scaffold(
      backgroundColor: bg,
      body: Stack(
        children: [
          // 1. Le Trou Blanc
          if (_controller.value < _tHoleCloseEnd)
            Center(
              child: Transform.scale(
                scale: _holeScale.value,
                child: Container(
                  width: 150,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.white24, blurRadius: 20, spreadRadius: 5),
                    ],
                  ),
                ),
              ),
            ),

          // 2. Le Logo
          if (_controller.value < _tFinalInteractionStart)
            Center(
              child: Transform.translate(
                offset: Offset(0, y),
                child: Transform.scale(
                  scale: _iconRiseScale.value,
                  child: Opacity(
                    opacity: _iconOpacity.value,
                    child: _buildClippedIcon(iconSize, y),
                  ),
                ),
              ),
            )
          else
            Center(
              child: Transform.translate(
                offset: Offset(x, y),
                child: Image.asset(
                  'assets/icon/Logo_cinecia.png',
                  width: 60,
                  height: 60,
                  fit: BoxFit.contain,
                ),
              ),
            ),

          // 3. Le Texte
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_controller.value >= _tTypewriterStart)
                  Text(
                    mainPart,
                    style: GoogleFonts.outfit(
                      fontSize: 50,
                      fontWeight: FontWeight.w800,
                      color: content,
                      letterSpacing: -1.5,
                    ),
                  ),
                if (hasReachedEnd)
                  Opacity(
                    opacity: _aOpacity.value,
                    child: Text(
                      lastLetter,
                      key: _aKey,
                      style: GoogleFonts.outfit(
                        fontSize: 50,
                        fontWeight: FontWeight.w800,
                        color: content,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClippedIcon(double size, double y) {
    if (_controller.value >= _tIconRiseStart && _controller.value <= _tIconRiseEnd) {
      return ClipRect(
        clipper: _IconEmergenceClipper(y),
        child: Image.asset(
          'assets/icon/Logo_cinecia.png',
          width: size,
          height: size,
          fit: BoxFit.contain,
        ),
      );
    }
    return Image.asset(
      'assets/icon/Logo_cinecia.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

class _IconEmergenceClipper extends CustomClipper<Rect> {
  final double iconY;
  _IconEmergenceClipper(this.iconY);

  @override
  Rect getClip(Size size) {
    // Le centre du trou est à worldY = 0.
    // L'icône est décalée de iconY par rapport au centre.
    // Donc la ligne du trou dans les coordonnées locales de l'icône est :
    final double localPortalLine = size.height / 2 - iconY;
    
    // On garde tout ce qui est AU-DESSUS de la ligne du portail
    return Rect.fromLTRB(0, -500, size.width, localPortalLine);
  }

  @override
  bool shouldReclip(covariant _IconEmergenceClipper oldClipper) => oldClipper.iconY != iconY;
}
