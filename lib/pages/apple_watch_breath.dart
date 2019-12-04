import 'dart:math' as math;

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..addListener(() => setState(() {}));
    _anim.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Apple Watch 呼吸动效')),
      body: Container(
        alignment: Alignment.center,
        color: Colors.black,
        child: Transform.rotate(
          angle: 2 * math.pi / 3 * _anim.value,
          child: CustomPaint(
            size: Size(240, 240),
            painter: _CustomPainter(_anim.value),
          ),
        ),
      ),
    );
  }
}

class _CustomPainter extends CustomPainter {
  final double value;

  _CustomPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    Offset pivot = Offset(size.width / 2, size.height / 2);
    Color first = Color.fromARGB(255, 43, 150, 153);
    Color last = Color.fromARGB(255, 79, 217, 158);
    for (int i = 0; i < 6; i++) {
      canvas.drawCircle(
        Offset(pivot.dx + 80 * value, pivot.dy),
        24 + 56 * value,
        Paint()
          ..color = Color.lerp(first, last, i / 5)
          ..blendMode = BlendMode.screen,
      );
      canvas.translate(pivot.dx, pivot.dy);
      canvas.rotate(math.pi / 3);
      canvas.translate(-pivot.dx, -pivot.dy);
    }
  }

  @override
  bool shouldRepaint(_) => true;
}
