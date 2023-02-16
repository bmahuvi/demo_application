import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Demo',
                    style: Theme.of(context).textTheme.displayLarge,
                    children: [
                      TextSpan(
                        text: 'APP',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.tertiary),
                      )
                    ],
                  ),
                ),
              ],
            )),
            const Padding(
              padding: EdgeInsets.only(bottom: 36),
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}
