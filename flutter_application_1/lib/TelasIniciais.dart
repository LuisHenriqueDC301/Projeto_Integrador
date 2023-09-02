import 'package:flutter/material.dart';
import 'cadastro.dart';
import 'package:flutter/material.dart';

class TelasIniciais extends StatefulWidget {
  @override
  _TelasIniciaisState createState() => _TelasIniciaisState();
}

class _TelasIniciaisState extends State<TelasIniciais> {
  final List<Map<String, String>> dados = [
    {
      'imagem': 'assets/Imagem1.jpeg',
      'texto':
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      'titulo': "Lambidinha Maneira e Sincera"
    },
    {
      'imagem': 'assets/Imagem2.jpeg',
      'texto': 'Texto da imagem 2',
      'titulo': "Não sei"
    },
    {
      'imagem': 'assets/Imagem3.jpeg',
      'texto': 'Texaaaaaaaaaaaa000',
      'titulo': "Ta funcionando?"
    },
    {'imagem': 'assets/branco.jpg', 'texto': '', 'titulo': ""},
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragEnd: (DragEndDetails details) {
          if (details.primaryVelocity! > 0 && _currentIndex > 0) {
            setState(() {
              _currentIndex--;
            });
          } else if (details.primaryVelocity! < 0 &&
              _currentIndex < dados.length - 1) {
            setState(() {
              _currentIndex++;
            });
          }
        },
        child: Stack(
          children: [
            PageView.builder(
              physics: ClampingScrollPhysics(),
              itemCount: dados.length,
              controller: PageController(initialPage: _currentIndex),
              onPageChanged: (int index) {
                if (index == dados.length - 1) {
                  // Navegar para outra página quando todas as imagens forem percorridas
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistroView()),
                  );
                }
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: [
                    Image.asset(
                      dados[index]['imagem']!,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 20,
                        left: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            dados[index]['titulo']!,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            dados[index]['texto']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
