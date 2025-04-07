import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading_Widget extends StatelessWidget {
  const Loading_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LoadingAnimationWidget.dotsTriangle(
          color: CupertinoColors. lightBackgroundGray,
          size: 50,
        ),
      ],
    );
  }
}
