import 'package:flutter/material.dart';

class TailAnimation extends StatefulWidget {
  final bool isCat;

  const TailAnimation({super.key, required this.isCat});

  @override
  _TailAnimationState createState() => _TailAnimationState();
}

class _TailAnimationState extends State<TailAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _translateAnimation;
  late Animation<double> _rotateAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.isCat ? 600 : 400), // 貓咪慢一點，狗狗快一點
      vsync: this,
    )..repeat(reverse: true);

    // 平移動畫（左右搖擺）
    _translateAnimation = Tween<double>(begin: -20, end: 20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 旋轉動畫（模擬尾巴搖擺）
    _rotateAnimation = Tween<double>(begin: -0.2, end: 0.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );

    // 顏色動畫（從深棕色到淺棕色）
    _colorAnimation = ColorTween(
      begin: const Color.fromARGB(255, 76, 47, 3), // 深棕色
      end: const Color.fromARGB(255, 120, 84, 40), // 淺棕色
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(TailAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isCat != widget.isCat) {
      // 當 isCat 改變時，更新動畫速度
      _controller.duration = Duration(milliseconds: widget.isCat ? 600 : 400);
      _controller
        ..reset()
        ..repeat(reverse: true);
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
        return Transform.translate(
          offset: Offset(_translateAnimation.value, 0),
          child: Transform.rotate(
            angle: _rotateAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.2), // 微透明白色背景
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.isCat ? '𓃠' : '𓃡',
                style: TextStyle(
                  fontSize: 35,
                  color: _colorAnimation.value,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
