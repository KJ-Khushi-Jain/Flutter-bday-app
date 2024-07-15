import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:confetti/confetti.dart';
import 'dart:async'; // For Timer
import 'dart:math'; // For pi
import 'package:family/Message_screen.dart';
import 'package:family/Gallery_screen.dart';
import 'package:family/Memories_screen.dart';
import 'package:family/Secret_screen.dart';

class Startingscreen extends StatefulWidget {
  @override
  _StartingscreenState createState() => _StartingscreenState();
}

class _StartingscreenState extends State<Startingscreen> {
  late ConfettiController _confettiController;
  late ConfettiController _topConfettiController;
  int _counter = 5;
  Timer? _timer;
  bool _showMessage = false;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 10));
    _topConfettiController = ConfettiController(duration: const Duration(seconds: 10));
    _startCountdown();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _topConfettiController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _confettiController.play();
          _showMessage = true;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      bottomNavigationBar: Container(
        height: 50,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.lightBlueAccent,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _topConfettiController.play();
          // Navigator.push(context, MaterialPageRoute(
          //   builder: (context) => Message_screen(),
          // ));
        },
        child: Icon(
          Icons.celebration,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.0),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              ClipPath(
                clipper: WaveClipperTwo(),
                child: Container(
                  height: 250,
                  color: Colors.orange,
                  child: Center(
                    child: Image.network(
                      'https://example.com/your_image.jpg',
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return Image.asset(
                          'photos/gallery31.jpg',
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
                child: _showMessage
                    ? Center(
                  key: ValueKey<String>('message'),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Familyyyyy Timeeee !!!!\n',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '💙💙💙\n',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24, color: Colors.blue),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildIconButton(Icons.message, "Message", onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Message_screen(),
                            ));
                          }),
                          _buildIconButton(Icons.photo_library, "Gallery", onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Gallery_screen(),
                            ));
                          }),
                          _buildIconButton(Icons.photo_album, "Memories", onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Memories_screen(),
                            ));
                          }),
                          _buildIconButton(Icons.lock, "Special", onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Secret_screen(),
                            ));
                          }),
                        ],
                      ),
                    ],
                  ),
                )
                    : Center(
                  key: ValueKey<int>(_counter),
                  child: Text(
                    '$_counter',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // Add more widgets here if needed
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 0, // Right direction
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi, // Left direction
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _topConfettiController,
              blastDirection: pi / 2, // Downwards direction
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label, {required VoidCallback onPressed}) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
          iconSize: 48,
          color: Colors.blue,
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.blue),
        ),
      ],
    );
  }
}
