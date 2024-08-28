import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_budget_app/budget_app.dart';

class HomeProfileCartWidget extends StatelessWidget {
  const HomeProfileCartWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        children: [
          // Profile Image
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: AppValues.profileUrl,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'ISAAC NORMAN',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text(
                    '5555 **** **** 2342',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/vectors/mastercard-logo.svg',
                    width: 15,
                    height: 15,
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}
