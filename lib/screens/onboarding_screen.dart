import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_colors.dart';
import '../widgets/primary_button.dart';
import 'login_screen.dart';
import 'register_actor_screen.dart';
import 'register_agent_screen.dart';
import 'role_selection_screen.dart';
import '../utils/page_transitions.dart';

// --- MODÈLE DE DONNÉES MIS À JOUR ---
class OnboardingData {
  final String title;
  final String subtitle;
  final String description;
  final String imagePath;
  final Color bgColor;
  final bool isLastPage;
  final bool isRoleChoice;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imagePath,
    required this.bgColor,
    this.isLastPage = false,
    this.isRoleChoice = false,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> with SingleTickerProviderStateMixin {
  late AnimationController _transitionController;
  late Animation<double> _waveAnimation;
  late Animation<double> _zoomAnimation;
  late Animation<double> _opacityAnimation;

  // NOUVEAU : Animations de glissement
  late Animation<Offset> _slideImageAnimation;
  late Animation<Offset> _slideTextAnimation;

  int _currentIndex = 0;
  int _nextIndex = 0;

  final List<OnboardingData> pages = [
    OnboardingData(
      title: "Mise en Scène",
      subtitle: "Le rôle de votre vie commence ici",
      description: "Accédez à des centaines de castings exclusifs et donnez une nouvelle dimension à votre carrière d'acteur ou de modèle.",
      imagePath: 'assets/images/onboarding Cinécia_1.png',
      bgColor: const Color(0xFF7B1A28),
    ),
    OnboardingData(
      title: "La Sélection",
      subtitle: "Trouvez le profil idéal en un clic",
      description: "Filtrez par apparence, compétences et expérience pour dénicher la perle rare qui donnera vie à votre prochain chef-d'œuvre.",
      imagePath: 'assets/images/onboarding Cinécia_2.png',
      bgColor: const Color(0xFFFCE8E8),
    ),
    OnboardingData(
      title: "Action !",
      subtitle: "Prêt pour le premier clap ?",
      description: "Rejoignez une communauté dynamique de professionnels du cinéma et commencez à postuler ou à recruter dès maintenant.",
      imagePath: 'assets/images/onboarding Cinécia_3.png',
      bgColor: const Color(0xFF7B1A28),
    ),
    OnboardingData(
      title: "",
      subtitle: "",
      description: "",
      imagePath: "",
      bgColor: const Color(0xFF12141A), // Dark cinematic background for role choice
      isLastPage: true,
      isRoleChoice: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _transitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _transitionController, curve: Curves.easeInOutCubic),
    );

    _zoomAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.7).chain(CurveTween(curve: Curves.easeOut)), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.7, end: 1.0).chain(CurveTween(curve: Curves.easeOutBack)), weight: 50),
    ]).animate(_transitionController);

    // Opacité synchronisée en 40% - 20% (invisible) - 40%
    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 20),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: Curves.easeIn)), weight: 40),
    ]).animate(_transitionController);

    // NOUVEAU : Glissement de l'image (Sort par la gauche, entre par la droite)
    _slideImageAnimation = TweenSequence<Offset>([
      TweenSequenceItem(tween: Tween(begin: Offset.zero, end: const Offset(-150, 0)).chain(CurveTween(curve: Curves.easeIn)), weight: 40),
      TweenSequenceItem(tween: ConstantTween(const Offset(150, 0)), weight: 20), // Pendant que c'est invisible, on le déplace à droite
      TweenSequenceItem(tween: Tween(begin: const Offset(150, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
    ]).animate(_transitionController);

    // NOUVEAU : Glissement du texte (Un peu moins fort pour l'effet parallaxe)
    _slideTextAnimation = TweenSequence<Offset>([
      TweenSequenceItem(tween: Tween(begin: Offset.zero, end: const Offset(-80, 0)).chain(CurveTween(curve: Curves.easeIn)), weight: 40),
      TweenSequenceItem(tween: ConstantTween(const Offset(80, 0)), weight: 20),
      TweenSequenceItem(tween: Tween(begin: const Offset(80, 0), end: Offset.zero).chain(CurveTween(curve: Curves.easeOut)), weight: 40),
    ]).animate(_transitionController);
  }

  void _onNextTap() {
    if (_transitionController.isAnimating) return;

    if (_currentIndex < pages.length - 1) {
      setState(() {
        _nextIndex = _currentIndex + 1;
      });
      _transitionController.forward(from: 0.0).then((_) {
        setState(() {
          _currentIndex = _nextIndex;
        });
      });
    } else {
      // Logic for the button inside the role choice if needed, 
      // but the role choice has its own buttons.
    }
  }

  @override
  void dispose() {
    _transitionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Fond Actuel
          Container(color: pages[_currentIndex].bgColor),

          // 2. La Vague Animée
          if (_transitionController.isAnimating)
            AnimatedBuilder(
              animation: _waveAnimation,
              builder: (context, child) {
                return ClipPath(
                  clipper: WaveClipper(fraction: _waveAnimation.value),
                  child: Container(color: pages[_nextIndex].bgColor),
                );
              },
            ),

          // 3. Contenu (Texte, Images, Boutons)
          SafeArea(
            child: AnimatedBuilder(
              animation: _transitionController,
              builder: (context, child) {
                bool showNextContent = _transitionController.value >= 0.5;
                int displayIndex = showNextContent ? _nextIndex : _currentIndex;
                OnboardingData displayData = pages[displayIndex];

                bool isPinkBg = displayIndex == 1;

                Color cardColor = isPinkBg ? const Color(0xFF7B1A28) : Colors.white;
                Color buttonBgColor = isPinkBg ? const Color(0xFF7B1A28) : Colors.white;
                Color buttonIconColor = isPinkBg ? Colors.white : const Color(0xFF7B1A28);
                Color topIconColor = isPinkBg ? const Color(0xFF7B1A28) : Colors.white;

                Color titleColor = isPinkBg ? Colors.white : const Color(0xFF2D2D2D);
                Color subtitleColor = isPinkBg ? Colors.white : const Color(0xFF7B1A28);
                Color descColor = isPinkBg ? Colors.white70 : const Color(0xFF7B1A28).withOpacity(0.8);

                Color circleColor = isPinkBg
                    ? const Color(0xFF7B1A28).withOpacity(0.06)
                    : Colors.white.withOpacity(0.08);

                return Transform.scale(
                  scale: _zoomAnimation.value,
                  child: Opacity(
                    opacity: _opacityAnimation.value,
                    child: Column(
                      children: [
                        // --- EN TÊTE ---
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios, color: topIconColor),
                              onPressed: () {
                                if (_currentIndex > 0) {
                                  setState(() {
                                    _nextIndex = _currentIndex - 1;
                                  });
                                  _transitionController.forward(from: 0.0).then((_) {
                                    setState(() {
                                      _currentIndex = _nextIndex;
                                    });
                                  });
                                }
                              },
                            ),
                          ),
                        ),

                        if (displayData.isRoleChoice)
                          // --- ROLE SELECTION UI ---
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Spacer(),
                                  // Logo
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: Image.asset(
                                      'assets/icon/Logo_cinecia.png',
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'CINECIA',
                                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                      color: Colors.white,
                                      fontSize: 32,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    "L'excellence du casting\ncommence ici.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                      height: 1.5,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'CRÉER UN COMPTE EN TANT QUE',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  PrimaryButton(
                                    text: 'Acteur',
                                    icon: const Icon(LucideIcons.user),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CineciaTransition(page: const RegisterActorScreen()),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        CineciaTransition(page: const RegisterAgentScreen()),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      minimumSize: const Size(double.infinity, 56),
                                      side: const BorderSide(color: Colors.white24, width: 2),
                                    ).copyWith(
                                      side: WidgetStateProperty.all(const BorderSide(color: AppColors.primary, width: 1)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(LucideIcons.building2, color: AppColors.primary),
                                        const SizedBox(width: 12),
                                        Text(
                                          'AGENT / PRODUCTION',
                                          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                                color: AppColors.primary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        CineciaTransition(page: const LoginScreen()),
                                      );
                                    },
                                    child: RichText(
                                      text: const TextSpan(
                                        text: 'Déjà un compte ? ',
                                        style: TextStyle(color: Colors.white70, fontSize: 14),
                                        children: [
                                          TextSpan(
                                            text: 'Se connecter',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          )
                        else ...[
                          // --- SECTION IMAGE + CERCLES DE FOND ---
                          Expanded(
                            flex: 5,
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                double size = constraints.maxHeight < constraints.maxWidth 
                                    ? constraints.maxHeight 
                                    : constraints.maxWidth;
                                return Transform.translate(
                                  offset: _slideImageAnimation.value,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: size * 0.9,
                                        height: size * 0.9,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
                                      ),
                                      Container(
                                        width: size * 0.65,
                                        height: size * 0.65,
                                        decoration: BoxDecoration(shape: BoxShape.circle, color: circleColor),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                                        child: Image.asset(displayData.imagePath, fit: BoxFit.contain),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),

                          // --- POINTS DE PAGINATION ---
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              pages.length - 1, // Exclude the role selection page from dots
                                  (index) => Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: displayIndex == index ? 24 : 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: displayIndex == index ? topIconColor : topIconColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // --- SECTION CARTE + BOUTON ---
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 35),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: CustomPaint(
                                      painter: CardCutoutPainter(color: cardColor),
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.fromLTRB(20, 30, 20, 75),
                                        child: Transform.translate(
                                          offset: _slideTextAnimation.value,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                displayData.title,
                                                style: TextStyle(
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: 'SF Pro Display',
                                                  color: titleColor,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                displayData.subtitle,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'SF Pro Display',
                                                  color: subtitleColor,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Text(
                                                displayData.description,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  height: 1.4,
                                                  color: descColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // Le Bouton
                                GestureDetector(
                                  onTap: _onNextTap,
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: buttonBgColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: buttonIconColor,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double fraction;
  WaveClipper({required this.fraction});

  @override
  Path getClip(Size size) {
    Offset center = Offset(size.width / 2, size.height - 80);
    double maxRadius = size.height * 1.2;
    return Path()..addOval(Rect.fromCircle(center: center, radius: maxRadius * fraction));
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) => oldClipper.fraction != fraction;
}

class CardCutoutPainter extends CustomPainter {
  final Color color;

  CardCutoutPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double cutoutRadius = 45.0;

    final double width = size.width;
    final double height = size.height;
    final double cornerRadius = 30.0;

    final path = Path();

    path.moveTo(0, cornerRadius);
    path.arcToPoint(Offset(cornerRadius, 0), radius: Radius.circular(cornerRadius));
    path.lineTo(width - cornerRadius, 0);
    path.arcToPoint(Offset(width, cornerRadius), radius: Radius.circular(cornerRadius));

    path.lineTo(width, height - cornerRadius);
    path.arcToPoint(Offset(width - cornerRadius, height), radius: Radius.circular(cornerRadius));

    path.lineTo((width / 2) + cutoutRadius, height);

    path.arcToPoint(
      Offset((width / 2) - cutoutRadius, height),
      radius: Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(cornerRadius, height);
    path.arcToPoint(Offset(0, height - cornerRadius), radius: Radius.circular(cornerRadius));

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}