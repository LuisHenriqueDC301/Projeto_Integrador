import 'package:concentric_transition/page_view.dart';
import 'package:flutter/material.dart';

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

final pages = [
  PageData(
    title: "Search for your favourite food",
    imagePath: "assets/Imagem1.jpeg",
    bgColor: Color.fromARGB(185, 19, 199, 19),
    textColor: Colors.green,
  ),
  PageData(
    title: "Add it to cart",
    imagePath: "assets/Imagem2.jpeg",
    bgColor: Color(0xfffab800),
    textColor: Color(0xff3b1790),
  ),
  PageData(
    title: "Order and wait",
    imagePath: "assets/Imagem3.jpeg",
    bgColor: Color(0xffffffff),
    textColor: Color(0xff3b1790),
  ),
];

class _CarouselPageState extends State<CarouselPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: pages.map((p) => p.bgColor).toList(),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 3),
          child: Icon(
            Icons.navigate_next,
            size: screenWidth * 0.08,
          ),
        ),
        itemCount: pages.length + 1,
        opacityFactor: 2.0,
        scaleFactor: 2,
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return SafeArea(
            child: _Page(page: page),
          );
        },
      ),
    );
  }
}

class PageData {
  final String title;
  final String imagePath;
  final Color bgColor;
  final Color textColor;

  PageData({
    required this.title,
    required this.imagePath,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class _Page extends StatelessWidget {
  final PageData page;

  const _Page({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(16.0),
          child: Image.asset(
            page.imagePath,
            height: screenHeight * 0.2, // Ajuste a altura conforme necessário
            width: screenHeight * 0.2, // Ajuste a largura conforme necessário
          ),
        ),
        Text(
          page.title,
          style: TextStyle(
              color: page.textColor,
              fontSize: screenHeight * 0.035,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
