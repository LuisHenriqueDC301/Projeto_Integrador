import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/slide_tile.dart';
import 'package:flutter_application_1/login.dart';

class CarouselPage extends StatefulWidget {
  final List<Map<String, dynamic>> _listSlide = [
    {"id": 0, "image": "assets/Imagem1.jpeg"},
    {"id": 1, "image": "assets/Imagem2.jpeg"},
    {"id": 2, "image": "assets/Imagem3.jpeg"}
  ];

  CarouselPage({Key? key}) : super(key: key);

  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  int _currentPage = 0;
  final PageController pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: pageController,
                itemCount: widget._listSlide.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, currentIndex) {
                  bool activePage = currentIndex == _currentPage;
                  return Slide_Tile(
                    activePage: activePage,
                    image: widget._listSlide[currentIndex]["image"],
                  );
                },
              ),
            ),
            _buildBullets(),
            _buildButtonToLoginPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildBullets() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget._listSlide.map((slide) {
          int index = widget._listSlide.indexOf(slide);
          return Container(
            width: 10,
            height: 10,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: index == _currentPage ? Colors.green : Colors.grey,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildButtonToLoginPage() {
    return ElevatedButton(
      onPressed: () {
        // Transição para a página de login com animação de desvanecimento (fade)
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: LoginView(),
              );
            },
          ),
        );
      },
      child: Text('Fazer Login'),
    );
  }
}
