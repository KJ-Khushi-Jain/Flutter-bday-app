import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heart_overlay/heart_overlay.dart';

class Message_screen extends StatelessWidget {
  const Message_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const HeartOverlayTestWidget(),
    );
  }
}

class HeartOverlayTestWidget extends StatefulWidget {
  const HeartOverlayTestWidget({
    super.key,
  });

  @override
  State<HeartOverlayTestWidget> createState() => _HeartOverlayTestWidgetState();
}

class _HeartOverlayTestWidgetState extends State<HeartOverlayTestWidget> with SingleTickerProviderStateMixin {
  late HeartOverlayController heartOverlayController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  String displayedText = "FAMILY - \nThe Smile of the children,\nLove of a mother,\nDiscipline of a father,\nMakes the togetherness of a Family.\n";

  @override
  void initState() {
    super.initState();
    heartOverlayController = HeartOverlayController();

    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showRandomSizedHearts();
      _animationController.repeat(reverse: true);
    });
  }

  void _showRandomSizedHearts() {
    final random = Random();
    for (int i = 0; i < 100; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        final size = random.nextDouble() * 80 + 20; // Sizes between 20 and 100
        final offset = Offset(
          random.nextDouble() * MediaQuery.of(context).size.width,
          random.nextDouble() * MediaQuery.of(context).size.height,
        );

        heartOverlayController.showIcon(
          offset: offset,
        );

        heartOverlayController.changeIcon(
          icon: Icon(
            Icons.favorite,
            color: Colors.redAccent,
            size: size,
          ),
        );
      });
    }
  }

  void _changeText() {
    setState(() {
      displayedText = "FAMILY - \nToday's - \nlittle moments,\nBecome\nTomorrow's - \nprecious memories!!!";
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      appBar: AppBar(
        title: const Text('Message'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Stack(
        children: [
          HeartOverlay(
            controller: heartOverlayController,
            enableGestures: false,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    displayedText,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _changeText,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Change Text',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const Message_screen());
}
