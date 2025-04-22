import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/pet.dart';
import '/screens/pet_detail_screen.dart';

class PetGrid extends StatelessWidget {
  final List<Pet> pets;

  const PetGrid({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8, // 調整比例，讓卡片更高一點
        ),
        itemCount: pets.length,
        itemBuilder: (context, index) {
          final pet = pets[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: AnimatedCard(
                  pet: pet,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// 自訂卡片元件，包含點擊動畫
class AnimatedCard extends StatefulWidget {
  final Pet pet;

  const AnimatedCard({super.key, required this.pet});

  @override
  _AnimatedCardState createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _textFadeAnimation;
  bool _isTextVisible = false; // 用於控制文字是否已顯示

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // 只在首次載入時播放文字淡入動畫
    if (!_isTextVisible) {
      _controller.forward().then((_) {
        setState(() {
          _isTextVisible = true; // 標記文字已顯示
        });
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
    return GestureDetector(
      onTapDown: (_) {
        _controller.forward(); // 點擊時縮放
      },
      onTapUp: (_) {
        _controller.reverse();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetDetailScreen(pet: widget.pet),
          ),
        );
      },
      onTapCancel: () {
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFF3E0), // 淺橘色
                  Color(0xFFFFE0B2), // 更深的橘色
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: FadeInImage(
                      placeholder:
                          const AssetImage('assets/images/placeholder.jpg'),
                      image: AssetImage(widget.pet.imagePath),
                      fit: BoxFit.cover,
                      fadeInDuration: const Duration(milliseconds: 300),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _isTextVisible
                      ? Text(
                          widget.pet.breed,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFFA726),
                            fontFamily: 'Pixel',
                          ),
                          textAlign: TextAlign.center,
                        )
                      : FadeTransition(
                          opacity: _textFadeAnimation,
                          child: Text(
                            widget.pet.breed,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFA726),
                              fontFamily: 'Pixel',
                            ),
                            textAlign: TextAlign.center,
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
