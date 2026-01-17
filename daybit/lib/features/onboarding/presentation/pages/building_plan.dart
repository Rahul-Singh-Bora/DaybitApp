import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../widgets/loading_dots.dart';
import '../../../Auth/presentation/pages/signup_screen.dart';

class BuildingPlanPage extends StatefulWidget {
  const BuildingPlanPage({super.key});

  @override
  State<BuildingPlanPage> createState() => _BuildingPlanPageState();
}

class _BuildingPlanPageState extends State<BuildingPlanPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize the video player
    _controller =
        VideoPlayerController.asset(
            'lib/features/onboarding/assets/mp4/walking_chick.mp4',
          )
          ..initialize()
              .then((_) {
                // Ensure the first frame is shown after the video is initialized
                setState(() {
                  _isInitialized = true;
                  _controller.play();
                  _controller.setLooping(true);
                  _controller.setVolume(0.0);
                });

                // Navigate to SignupScreen after 2 seconds
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  }
                });
              })
              .catchError((error) {
                debugPrint('Video Player Error: $error');
                // Navigate anyway on error after delay
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  }
                });
              });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333233),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isInitialized)
              SizedBox(
                width: 250, // Adjust size as needed or make responsive
                // height: 250, // Removed to allow aspect ratio to determine height
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            else
              const SizedBox(
                width: 250,
                height: 250,
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF6FAE6C)),
                ),
              ),
            const SizedBox(height: 24),
            const Text(
              'Building plan',
              style: TextStyle(
                color: Color(0xFF6FAE6C),
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Righteous',
              ),
            ),
            const SizedBox(height: 16),
            const LoadingDots(size: 10),
          ],
        ),
      ),
    );
  }
}
