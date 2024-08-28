import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_budget_app/budget_app.dart';

class RippleToast extends StatefulWidget {
  final String message;

  final bool positive;

  const RippleToast({super.key, required this.message, this.positive = true});

  @override
  RippleToastState createState() => RippleToastState();
}

class RippleToastState extends State<RippleToast>
    with TickerProviderStateMixin {
  late AnimationController firstRippleController;
  late AnimationController secondRippleController;
  late AnimationController thirdRippleController;
  late Animation<double> firstRippleRadiusAnimation;
  late Animation<double> firstRippleOpacityAnimation;
  late Animation<double> secondRippleRadiusAnimation;
  late Animation<double> secondRippleOpacityAnimation;
  late Animation<double> thirdRippleRadiusAnimation;
  late Animation<double> thirdRippleOpacityAnimation;

  @override
  void initState() {
    super.initState();

    firstRippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    firstRippleRadiusAnimation = Tween<double>(begin: 0, end: 220).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    firstRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: firstRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    secondRippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    secondRippleRadiusAnimation = Tween<double>(begin: 0, end: 220).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    secondRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: secondRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    thirdRippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    thirdRippleRadiusAnimation = Tween<double>(begin: 0, end: 220).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    thirdRippleOpacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: thirdRippleController,
        curve: Curves.ease,
      ),
    )..addListener(
        () {
          setState(() {});
        },
      );

    firstRippleController.forward();
    Future.delayed(
      const Duration(milliseconds: 500),
      () => secondRippleController.forward(),
    );

    Future.delayed(
      const Duration(milliseconds: 1000),
      () => thirdRippleController.forward(),
    );
  }

  @override
  void dispose() {
    firstRippleController.dispose();
    secondRippleController.dispose();
    thirdRippleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildRipple(firstRippleRadiusAnimation, firstRippleOpacityAnimation),
        _buildRipple(secondRippleRadiusAnimation, secondRippleOpacityAnimation),
        _buildRipple(thirdRippleRadiusAnimation, thirdRippleOpacityAnimation),
        _buildToastContent(),
      ],
    );
  }

  Widget _buildRipple(
      Animation<double> radiusAnimation, Animation<double> opacityAnimation) {
    return Column(
      children: [
        40.gap,
        Container(
          width: radiusAnimation.value * 2,
          height: (radiusAnimation.value * 2) / 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: (widget.positive ? orange.withOpacity(.5) : Colors.red)
                .withOpacity(opacityAnimation.value),
          ),
        ),
      ],
    );
  }

  Widget _buildToastContent() {
    return Column(
      children: [
        40.gap,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: widget.positive ? orange : Colors.red,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/vectors/fire-svgrepo-com.svg',
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 20,
                height: 20,
              ),
              12.gap,
              SizedBox(
                width: 200,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "You are too close to the daily limit. Only ",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      TextSpan(
                        text: "\$ 5.37 left.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
