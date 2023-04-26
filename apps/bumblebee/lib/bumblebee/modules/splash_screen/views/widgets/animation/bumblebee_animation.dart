import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/splash_screen/views/widgets/painter/bumblebee_drop_painter.dart';
import 'package:kreditplus_deasy_mobile/bumblebee/modules/splash_screen/views/widgets/painter/bumblebee_hole_painter.dart';
import 'package:deasy_color/deasy_color.dart';
import 'bumblebee_staggered_raindrop_animation.dart';

class AnimationScreen extends StatefulWidget {
  AnimationScreen({this.color});

  final Color? color;

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  Size size = Size.zero;
  late AnimationController _controller;
  late StaggeredRaindropAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _animation = StaggeredRaindropAnimation(_controller);
    _controller.forward();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    setState(() {
      size = MediaQuery.of(context).size;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
          width: double.infinity,
          height: double.infinity,
          child: CustomPaint(
              painter: HolePainter(
                  color: DeasyColor.kpBlue200,
                  holeSize: _animation.holeSize.value * size.width))),
      Align(
        alignment: Alignment.center,
        child: Container(
            width: 200,
            height: 200,
            child: SvgPicture.asset('resources/images/logo/new_logo.svg')),
      ),
      Positioned(
          top: _animation.dropPosition.value * size.height,
          left: size.width / 2 - _animation.dropSize.value / 2,
          child: SizedBox(
              width: _animation.dropSize.value,
              height: _animation.dropSize.value,
              child: CustomPaint(
                painter: DropPainter(visible: _animation.dropVisible.value),
              ))),
    ]);
  }

  @override
  void dispose() {
    if (_controller.isAnimating) {
      _controller.dispose();
    }
    super.dispose();
  }
}
