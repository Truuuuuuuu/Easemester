import 'package:easemester_app/data/constant.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() =>
      _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  final List<Map<String, String>> onboardingData = const [
    {
      'image': 'assets/images/summarize.png',
      'title': 'Learn smarter',
      'description':
          'Get bite-sized summaries to understand faster.',
    },
    {
      'image': 'assets/images/quiz.png',
      'title': 'Test your knowledge',
      'description':
          'Try quick quizzes to check your understanding.',
    },
    {
      'image': 'assets/images/flash_card.png',
      'title': 'Review anytime',
      'description':
          'Use flashcards to remember key points.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final item = onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),
                        Image.asset(
                          item['image']!,
                          height: 250,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 24),
                        // Page indicator
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: List.generate(
                            onboardingData.length,
                            (dotIndex) => Container(
                              margin:
                                  const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: dotIndex == index
                                    ? Colors.blue
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Title
                        Text(
                          item['title']!,
                          style: AppFonts.title,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        // Description
                        Text(
                          item['description']!,
                          style: AppFonts.paragraph,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Always reserve button space to avoid shifting
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child:
                    currentPage == onboardingData.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                          backgroundColor:
                              const Color.fromARGB(
                                255,
                                0,
                                16,
                                34,
                              ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
