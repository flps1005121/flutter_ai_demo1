import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'screens/home_screen.dart';

// 創建一個單例類來管理 AudioPlayer
class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  late AudioPlayer _audioPlayer;

  factory AudioManager() {
    return _instance;
  }

  AudioManager._internal() {
    _audioPlayer = AudioPlayer();
  }

  AudioPlayer get audioPlayer => _audioPlayer;

  void playBackgroundMusic() async {
    try {
      await _audioPlayer.setSource(AssetSource('background.mp3'));
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.resume();
    } catch (e) {
      debugPrint("播放音樂時發生錯誤: $e");
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 在應用啟動時播放背景音樂
    AudioManager().playBackgroundMusic();

    return MaterialApp(
      title: '寵物圖鑑',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFA726),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: 'Pixel',
            fontSize: 20,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Pixel',
            fontSize: 16,
            color: Colors.black87,
            height: 1.5,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Pixel',
            fontSize: 14,
            color: Colors.black87,
            height: 1.5,
          ),
          titleLarge: TextStyle(
            fontFamily: 'Pixel',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFA726),
          ),
          labelMedium: TextStyle(
            fontFamily: 'Pixel',
            fontSize: 14,
            color: Color(0xFFFFA726),
          ),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: Colors.white,
          selectedColor: Color(0xFFFFA726),
          secondarySelectedColor: Color(0xFFFFA726),
          labelStyle: TextStyle(
            fontFamily: 'Pixel',
            color: Color(0xFFFFA726),
          ),
          secondaryLabelStyle: TextStyle(
            fontFamily: 'Pixel',
            color: Colors.white,
          ),
          side: BorderSide(color: Color(0xFFFFA726)),
          shape: StadiumBorder(),
          elevation: 2,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFFFFA726),
            backgroundColor: Colors.white.withOpacity(0.1),
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// 啟動畫面
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    // 2秒後跳轉到 HomeScreen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFF3E0),
              Color(0xFFFFE0B2),
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.pets,
                    size: 80,
                    color: Color(0xFFFFA726),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '寵物圖鑑',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: const Color(0xFFFFA726),
                          fontSize: 36,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
