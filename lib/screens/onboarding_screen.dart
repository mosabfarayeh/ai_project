import 'package:flutter/material.dart';

import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> onboardingPages = [
    {
      "color": Colors.deepOrange,
      "title": "Welcome to SpeedTest",
      "description": "Test your internet speed with accuracy.",
      "image":
          "https://broadband.yourcoop.coop/Assets/Images/NoResize/default/test-broadbandspeed-systemtools.png",
    },
    {
      "color": Colors.green,
      "title": "Real-Time Results",
      "description": "Get real-time speed test results and insights.",
      "image":
          "https://broadband.yourcoop.coop/Assets/Images/NoResize/default/test-broadbandspeed-speedtest.png",
    },
    {
      "color": Colors.blue,
      "title": "Start Your Journey",
      "description": "Let's get started and test your speed now!",
      "image":
          "https://broadband.yourcoop.coop/Assets/Images/NoResize/default/test-broadbandspeed-timeofday.png"
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingPages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                return Container(
                  // color: onboardingPages[index]['color'],
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: height * 0.4,
                        width: width,
                        child: Image.network(
                          onboardingPages[index]['image'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 25),
                      Text(
                        onboardingPages[index]['title'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        onboardingPages[index]['description'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Page Indicator (Dots)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingPages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 10,
                  width: _currentPage == index ? 20 : 10,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? Colors.black : Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Navigation Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage == onboardingPages.length - 1) {
                    // Navigate to Login Screen on last step
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
                child: Text(_currentPage == onboardingPages.length - 1
                    ? "Get Started"
                    : "Next"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
