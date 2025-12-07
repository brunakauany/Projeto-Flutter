import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static var myNewFont = const TextStyle(
      color: Colors.black, letterSpacing: 3, fontWeight: FontWeight.bold);
  static var myNewFontWhite = const TextStyle(
      color: Colors.white, letterSpacing: 3, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Gradiente Escuro
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F2937),
              Color(0xFF111827),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      "JOGO DA VELHA",
                      style: myNewFontWhite.copyWith(fontSize: 28),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 70.0,
                        child: Image.asset(
                          'lib/images/jogo_da_veia.png',
                          color: Colors.white,
                          fit: BoxFit.scaleDown,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.grid_3x3,
                              color: Colors.white,
                              size: 80,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                
                // Texto de instrução
                Text(
                  "APERTE PARA COMEÇAR",
                  style: myNewFontWhite.copyWith(fontSize: 12, fontWeight: FontWeight.normal, color: Colors.white54),
                ),
                
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'JOGAR',
                      style: myNewFont.copyWith(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}