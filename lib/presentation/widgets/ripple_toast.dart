import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_budget_app/budget_app.dart';

class RippleToast extends StatefulWidget {
  final String message;
  final bool positive;
  final VoidCallback onDismiss;

  const RippleToast(
      {super.key,
      required this.message,
      this.positive = true,
      required this.onDismiss});

  @override
  RippleToastState createState() => RippleToastState();
}

class RippleToastState extends State<RippleToast>
    with TickerProviderStateMixin {
  late AnimationController initialCircleController;
  late AnimationController firstRippleController;
  late AnimationController secondRippleController;
  late AnimationController thirdRippleController;

  late Animation<double> initialCircleWidthAnimation;
  late Animation<double> initialCircleHeightAnimation;
  late Animation<double> initialCircleBorderRadiusAnimation;
  late Animation<double> firstRippleRadiusAnimation;
  late Animation<double> firstRippleOpacityAnimation;
  late Animation<double> secondRippleRadiusAnimation;
  late Animation<double> secondRippleOpacityAnimation;
  late Animation<double> thirdRippleRadiusAnimation;
  late Animation<double> thirdRippleOpacityAnimation;

  @override
  void initState() {
    super.initState();

    initialCircleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    initialCircleWidthAnimation = Tween<double>(begin: 40.0, end: 280).animate(
      CurvedAnimation(
        parent: initialCircleController,
        curve: Curves.easeInOut,
      ),
    );

    initialCircleHeightAnimation = Tween<double>(begin: 40.0, end: 60).animate(
      CurvedAnimation(
        parent: initialCircleController,
        curve: Curves.easeInOut,
      ),
    );

    initialCircleBorderRadiusAnimation =
        Tween<double>(begin: 20.0, end: 20).animate(
      CurvedAnimation(
        parent: initialCircleController,
        curve: Curves.easeInOut,
      ),
    );

    firstRippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    firstRippleRadiusAnimation = Tween<double>(begin: 0, end: 280).animate(
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

    secondRippleRadiusAnimation = Tween<double>(begin: 0, end: 280).animate(
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

    thirdRippleRadiusAnimation = Tween<double>(begin: 0, end: 280).animate(
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

    initialCircleController.forward().whenComplete(() {
      firstRippleController.forward();
      Future.delayed(
        const Duration(milliseconds: 500),
        () => secondRippleController.forward(),
      );

      Future.delayed(
        const Duration(milliseconds: 1000),
        () => thirdRippleController.forward(),
      );
    });
  }

  @override
  void dispose() {
    firstRippleController.dispose();
    secondRippleController.dispose();
    thirdRippleController.dispose();
    initialCircleController.dispose();

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
    return Container(
      width: radiusAnimation.value * 2,
      height: (radiusAnimation.value * 2) / 5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: (widget.positive ? orange.withOpacity(.5) : Colors.red)
            .withOpacity(opacityAnimation.value),
      ),
    );
  }

  Widget _buildToastContent() {
    return AnimatedBuilder(
      animation: initialCircleController,
      builder: (context, child) {
        return Container(
          width: initialCircleWidthAnimation.value,
          height: initialCircleHeightAnimation.value,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.circular(initialCircleBorderRadiusAnimation.value),
            color: widget.positive ? orange : Colors.red,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: initialCircleWidthAnimation.value > 200 ? 24 : 4,
              vertical: initialCircleWidthAnimation.value > 200 ? 16 : 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (initialCircleWidthAnimation.value > 200)
                SvgPicture.asset(
                  'assets/vectors/fire-svgrepo-com.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  width: initialCircleWidthAnimation.value * 0.1,
                  height: initialCircleWidthAnimation.value * 0.1,
                ),
              SizedBox(
                width: initialCircleWidthAnimation.value > 200 ? 12 : 0,
              ),
              if (initialCircleWidthAnimation.value > 150)
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "You are too close to the daily limit. Only "
                              .staticallyTyped(),
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: initialCircleWidthAnimation.value > 200
                                  ? 12
                                  : 8),
                        ),
                        TextSpan(
                          text: "\$ 5.37 left.".staticallyTyped(),
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: initialCircleWidthAnimation.value > 200
                                ? 12
                                : 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              if (initialCircleWidthAnimation.value > 200)
                InkWell(
                  onTap: widget.onDismiss,
                  child: const Icon(Icons.close, color: inActiveRed),
                ),
            ],
          ),
        );
      },
    );
  }
}
