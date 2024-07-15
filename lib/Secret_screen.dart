import 'package:flutter/material.dart';
import 'dart:math';

class Secret_screen extends StatefulWidget {
  const Secret_screen({super.key});

  @override
  _SecretScreenState createState() => _SecretScreenState();
}

class _SecretScreenState extends State<Secret_screen> with TickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  String _message = '';
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkPassword() {
    if (_passwordController.text == 'jabalpur') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SuccessPage()),
      );
    } else {
      setState(() {
        _message = 'Wrong password';
      });
    }
  }

  void _showHint() {
    setState(() {
      _message = 'Everything in lowercase\nIt is a city of a state,\nAlso called : The Cultural Capital (Sanskardhani).\n';
    });
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: Colors.black),
        ),
        ...List.generate(30, (index) {
          final top = Random().nextDouble() * MediaQuery.of(context).size.height;
          final left = Random().nextDouble() * MediaQuery.of(context).size.width;
          return Positioned(
            top: top,
            left: left,
            child: FadeTransition(
              opacity: _animation,
              child: const Icon(
                Icons.favorite,
                color: Colors.blue,
                size: 24,
              ),
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(12),
              ),
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Enter the password:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.cyan),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.cyan),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _showHint,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Hint'),
                      ),
                      ElevatedButton(
                        onPressed: _checkPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Okay'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _message,
                    style: TextStyle(
                      fontSize: 18,
                      color: _message == 'Wrong password' ? Colors.red : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundedDiagonalPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height * 0.2);
    path.lineTo(size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class OctagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    Path path = Path();
    path.moveTo(width * 0.3, 0);
    path.lineTo(width * 0.7, 0);
    path.lineTo(width, height * 0.3);
    path.lineTo(width, height * 0.7);
    path.lineTo(width * 0.7, height);
    path.lineTo(width * 0.3, height);
    path.lineTo(0, height * 0.7);
    path.lineTo(0, height * 0.3);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildBackground() {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(color: Colors.black),
        ),
        ...List.generate(30, (index) {
          final top = Random().nextDouble() * MediaQuery.of(context).size.height;
          final left = Random().nextDouble() * MediaQuery.of(context).size.width;
          return Positioned(
            top: top,
            left: left,
            child: FadeTransition(
              opacity: _animation,
              child: const Icon(
                Icons.favorite,
                color: Colors.green,
                size: 24,
              ),
            ),
          );
        }),
      ],
    );
  }

  void _openImage(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageScreen(imagePath: imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Secrets Unlocked Here !!!'),
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          _buildBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipPath(
                  clipper: OctagonalClipper(),
                  child: GestureDetector(
                    onTap: () => _openImage('photos/img.jpg'),
                    child: Container(
                      height: 320,
                      width: 300,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(80.0)),
                        color: Colors.orange,
                      ),
                      child: Image.asset(
                        'photos/img.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                const Text(
                  'Special Moments!!!!!!!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10.0),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: List.generate(8, (index) {
                    return GestureDetector(
                      onTap: () => _openImage('photos/s${index + 1}.jpg'),
                      child: ClipPath(
                        clipper: OctagonalClipper(),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                          ),
                          child: Image.asset(
                            'photos/s${index + 1}.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imagePath;

  const ImageScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Image Viewer'),
      ),
      body: Center(
        child: Image.asset(imagePath),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Secret_screen(),
      ));
}
