import 'package:flutter/material.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */

class OnHover extends StatefulWidget {

  final Widget Function(bool isHovered)? builder;

  const OnHover({Key? key, this.builder}) : super(key: key);

  @override
  _OnHoverState createState() => _OnHoverState();
}

class _OnHoverState extends State<OnHover> {

  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    final hovered = Matrix4.identity()..translate(0,-1,0);
    final transform = isHovered ? hovered : Matrix4.identity();
    return MouseRegion(
      onEnter: (_)=> onEntered(true),
      onExit: (_)=> onEntered(false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 30),
        transform: transform,
        child: widget.builder!(isHovered),
      ),
    );
  }

  void onEntered(bool isHovered){
    setState(() {
      this.isHovered = isHovered;
    });
  }
}