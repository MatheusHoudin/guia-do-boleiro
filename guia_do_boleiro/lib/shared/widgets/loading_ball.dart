import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:guia_do_boleiro/core/constants/assets.dart';

class LoadingBall extends StatefulWidget {
  final double size;

  LoadingBall({this.size});

  @override
  _LoadingBallState createState() => _LoadingBallState();
}

class _LoadingBallState extends State<LoadingBall>  with TickerProviderStateMixin{
  AnimationController rotationController;

  @override
  void initState() {
    rotationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    rotationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      child: RotationTransition(
        turns: Tween(begin: 0.0, end: 1.0).animate(rotationController),
        child: SvgPicture.asset(loadingBallIcon),
      ),
    );
  }
}
