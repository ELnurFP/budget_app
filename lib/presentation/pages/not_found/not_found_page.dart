import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_budget_app/budget_app.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: context.width,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  80.gap,
                  Text(
                    'Oops!'.staticallyTyped(),
                    style: const TextStyle(
                      fontSize: 96.0,
                      fontWeight: FontWeight.w700,
                      color: darkGrey,
                    ),
                  ),
                  80.gap,
                  SizedBox(height: context.height * 0.05),
                  Text(
                    'Page not found'.staticallyTyped(),
                    style: const TextStyle(
                      fontSize: 36.0,
                    ),
                  ),
                  SizedBox(height: context.height * 0.025),
                  SizedBox(
                    width: 320.0,
                    child: StyledButton.outlined(
                      text: 'Go To Home Page'.staticallyTyped(),
                      onTap: () {
                        context.go('/');
                      },
                    ),
                  ),
                  104.gap,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
