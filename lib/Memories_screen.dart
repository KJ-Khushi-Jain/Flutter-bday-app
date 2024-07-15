import 'package:flutter/material.dart';

class Memories_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<String> imageUrls = [
    "photos/mamory1.jpg", "photos/memory2.jpg", "photos/memory3.jpg",
    "photos/memory4.jpg", "photos/memory5.jpg", "photos/memory6.jpg",
    "photos/memory7.jpg", "photos/memory8.jpg", "photos/memory9.jpg",
  ];

  final List<String> imageTexts = [
    'Ma & Papa.',
    '2 ponyyyy.',
    'Us 5.',
    'I can change the World.',
    'Callinggg.',
    'Holiiiii Timeeee.',
    'Laliiii.',
    'Kammu Mama.',
    'Lalli Mama.'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.blue[50]!],
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            childAspectRatio: 0.75,
          ),
          itemCount: imageUrls.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                double animationValue = _animation.value;
                double opacity = animationValue.clamp(0.0, 1.0);
                double scale = (animationValue * 0.5 + 0.5).clamp(0.0, 1.0);

                return Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(imageUrl: imageUrls[index]),
                              ),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image.asset(
                                imageUrls[index],
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                bottom: 8.0,
                                left: 8.0,
                                right: 8.0,
                                child: AnimatedOpacity(
                                  opacity: opacity,
                                  duration: Duration(seconds: 1),
                                  child: Container(
                                    padding: EdgeInsets.all(8.0),
                                    color: Colors.black54,
                                    child: Text(
                                      imageTexts[index],
                                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String imageUrl;

  DetailScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Detail"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Image.asset(
          imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "Memories",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.cyan,
    );
  }
}
