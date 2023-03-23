import 'package:flutter/material.dart';

class ColorAnimation extends StatefulWidget {
  final bool isLoading;
  final Widget tree;

  const ColorAnimation({
    required this.isLoading,
    required this.tree,
    super.key
  });

  @override
  State<StatefulWidget> createState() => _ColorAnimationState();
}

class _ColorAnimationState extends State<ColorAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _animation = ColorTween(
      begin: const Color(0xffcacaca),
      end: const Color(0xff555555),
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading ? AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _animation.value,
          ),
          width: 100,
          height: 100,
        );
      },
    ): widget.tree;
  }
}
