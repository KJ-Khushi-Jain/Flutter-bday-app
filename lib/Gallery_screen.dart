import 'package:flutter/material.dart';

class Gallery_screen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<Gallery_screen> {
  List<String> images = [
    'photos/gallery9.jpg',
    'photos/gallery10.jpg',
    'photos/gallery3.jpg',
    'photos/gallery4.jpg',
    'photos/gallery5.jpg',
    'photos/gallery6.jpg',
    'photos/gallery7.jpg',
    'photos/gallery8.jpg',
    'photos/gallery2.jpg',
    'photos/gallery1.jpg',
    'photos/gallery11.jpg',
    'photos/gallery12.jpg',
    'photos/gallery13.jpg',
    'photos/gallery14.jpg',
    'photos/gallery15.jpg',
    'photos/gallery16.jpg',
    'photos/gallery17.jpg',
    'photos/gallery18.jpg',
    'photos/gallery19.jpg',
    'photos/gallery20.jpg',
    'photos/gallery21.jpg',
    'photos/gallery22.jpg',
    'photos/gallery23.jpg',
    'photos/gallery24.jpg',
    'photos/gallery25.jpg',
    'photos/gallery26.jpg',
    'photos/gallery27.jpg',
    'photos/gallery28.jpg',
    'photos/gallery29.jpg',
    'photos/gallery30.jpg',
    'photos/gallery31.jpg',
    'photos/gallery32.jpg',
    'photos/gallery33.jpg',
    'photos/gallery34.jpg',
    'photos/gallery35.jpg',
    'photos/gallery36.jpg',
    'photos/gallery37.jpg',
    'photos/gallery38.jpg',
    'photos/gallery39.jpg',
    'photos/gallery40.jpg',
    'photos/gallery41.jpg',
    'photos/gallery42.jpg',
    'photos/gallery43.jpg',
    'photos/we.jpg',
  ];

  Set<String> likedImages = {};

  void toggleLike(String image) {
    setState(() {
      if (likedImages.contains(image)) {
        likedImages.remove(image);
      } else {
        likedImages.add(image);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Gallery'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LikedImagesScreen(
                    likedImages: likedImages.toList(),
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          final isLiked = likedImages.contains(image);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailScreen(
                    imageUrl: image,
                    isLiked: isLiked,
                    onLikeToggle: () {
                      toggleLike(image);
                    },
                  ),
                ),
              );
            },
            child: Hero(
              tag: image,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10.0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        toggleLike(image);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;
  final bool isLiked;
  final VoidCallback onLikeToggle;

  ImageDetailScreen({
    required this.imageUrl,
    required this.isLiked,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: imageUrl,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    width: 300.0,
                    height: 300.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: isLiked ? Colors.red : Colors.grey,
                size: 40.0,
              ),
              onPressed: () {
                onLikeToggle();
                Navigator.pop(context); // Close the detail screen after toggling
              },
            ),
          ],
        ),
      ),
    );
  }
}

class LikedImagesScreen extends StatelessWidget {
  final List<String> likedImages;

  LikedImagesScreen({required this.likedImages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Images'),
      ),
      body: likedImages.isEmpty
          ? Center(child: Text('No liked images.'))
          : GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: likedImages.length,
        itemBuilder: (context, index) {
          final image = likedImages[index];

          return Hero(
            tag: image,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
