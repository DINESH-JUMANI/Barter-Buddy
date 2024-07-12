import 'package:barter_buddy/common/utils/constants/colors.dart';
import 'package:barter_buddy/common/utils/constants/image_strings.dart';
import 'package:barter_buddy/common/utils/constants/sizes.dart';
import 'package:barter_buddy/common/utils/functions/helper_functions.dart';
import 'package:barter_buddy/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = PageController();

  void circularButtonOnpressed() {
    if (_controller.page == 2) {
      THelperFunctions.navigateToScreen(context, const LoginScreen());
    } else {
      _controller.nextPage(
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: Stack(
        children: [
          // Pages For Page View
          PageView(
            controller: _controller,
            children: const [
              SplashScreenPage(
                title: "Title1",
                subtitle: "Subtitle1",
                image: TImages.searching,
              ),
              SplashScreenPage(
                title: "Title2",
                subtitle: "Subtitle2",
                image: TImages.shopping,
              ),
              SplashScreenPage(
                title: "Title3",
                subtitle: "Subtitle3",
                image: TImages.workout,
              ),
            ],
          ),

          // Skip Button
          Positioned(
            top: THelperFunctions.getAppBarHeight(),
            right: TSizes.defaultSpace,
            child: TextButton(
              onPressed: () {
                THelperFunctions.navigateToScreen(context, const LoginScreen());
              },
              child: const Text("Skip"),
            ),
          ),

          // Dot Naivgation SmoothPage Indicator
          Positioned(
            bottom: THelperFunctions.getBottomNavigationBarHeight() + 25,
            left: TSizes.defaultSpace,
            child: SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: dark ? TColors.white : TColors.dark,
                dotHeight: 6,
              ),
              onDotClicked: (index) {
                _controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease);
              },
            ),
          ),

          // Circular Button
          Positioned(
            right: TSizes.defaultSpace,
            bottom: THelperFunctions.getBottomNavigationBarHeight(),
            child: ElevatedButton(
              onPressed: circularButtonOnpressed,
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: dark ? TColors.primary : TColors.dark),
              child: const Icon(Icons.arrow_forward_ios),
            ),
          )
        ],
      ),
    );
  }
}

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle});
  final String image;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: width * 0.8,
            height: height * 0.6,
            image: AssetImage(
              image,
            ),
          ),
          Text(
            title,
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
