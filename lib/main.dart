import 'dart:math';
import 'package:flutter/material.dart';

class PedraPT extends StatefulWidget {
  const PedraPT({Key? key}) : super(key: key);

  @override
  State<PedraPT> createState() => _PedraPTState();
}

class _PedraPTState extends State<PedraPT> {
  String _imgUserPlayer = "imagens/indefinido.png";
  String _imgAppPlayer = "imagens/indefinido.png";

  // Pontuação
  int _pontosUsuario = 0;
  int _pontosApp = 0;
  int _pontosEmpate = 0;

  //Bordas das imagens
  Color _borderUserColor = Colors.transparent;
  Color _borderAppColor = Colors.transparent;

  String _obtemEscolhaApp() {
    var opcoes = ['pedra', 'papel', 'tesoura'];

    String vlrEscolhido = opcoes[Random().nextInt(3)];

    return vlrEscolhido;
  }

  void _terminaJogada(String escolhaUser, String escolhaApp) {
    var resultado = "indefinido";

    switch (escolhaUser) {
      case "pedra":
        if (escolhaApp == "papel") {
          resultado = "app";
        } else if (escolhaApp == "tesoura") {
          resultado = "user";
        } else {
          resultado = "empate";
        }
        break;
      case "papel":
        if (escolhaApp == "pedra") {
          resultado = "user";
        } else if (escolhaApp == "tesoura") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
      case "tesoura":
        if (escolhaApp == "papel") {
          resultado = "user";
        } else if (escolhaApp == "pedra") {
          resultado = "app";
        } else {
          resultado = "empate";
        }
        break;
    }

    setState(() {
      if (resultado == "user") {
        _pontosUsuario++;
        _borderUserColor = Color.fromARGB(255, 87, 182, 90);
        _borderAppColor = Colors.transparent;
      } else if (resultado == "app") {
        _pontosApp++;
        _borderUserColor = Colors.transparent;
        _borderAppColor = Color.fromARGB(255, 87, 182, 90);
      } else {
        _pontosEmpate++;
        _borderUserColor = Colors.orange;
        _borderAppColor = Colors.orange;
      }
    });
  }

  void _iniciaJogada(String opcao) {
    //Configura a opção escolhida pelo usuário:
    setState(() {
      _imgUserPlayer = "imagens/$opcao.png";
    });

    String escolhaApp = _obtemEscolhaApp();
    setState(() {
      _imgAppPlayer = "imagens/$escolhaApp.png";
    });

    _terminaJogada(opcao, escolhaApp);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Pedra, Papel, Tesoura",
            style: TextStyle(
                color: Colors
                    .white), // Altera a cor do texto do título para branco
          ),
          backgroundColor: Color.fromARGB(
              255, 9, 112, 160), // Altera a cor de fundo do AppBar
        ),
        backgroundColor: Color.fromARGB(
            255, 154, 229, 250), // Altera a cor de fundo do Scaffold
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Disputa',
              style: TextStyle(fontSize: 26),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Badge(borderColor: _borderUserColor, imgPlayer: _imgUserPlayer),
              const Text('VS'),
              Badge(borderColor: _borderAppColor, imgPlayer: _imgAppPlayer),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Placar',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Placar(nomeJogador: 'Você', pontosJogador: _pontosUsuario),
              Placar(nomeJogador: 'Empate', pontosJogador: _pontosEmpate),
              Placar(nomeJogador: 'App', pontosJogador: _pontosApp),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 20),
            child: Text(
              'Opções',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _iniciaJogada("pedra"),
                child: Tooltip(
                  message: 'Pedra',
                  child: Image.asset(
                    'imagens/pedra.png',
                    height: 90,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _iniciaJogada("papel"),
                child: Tooltip(
                  message: 'Papel',
                  child: Image.asset(
                    'imagens/papel.png',
                    height: 90,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _iniciaJogada("tesoura"),
                child: Tooltip(
                  message: 'Tesoura',
                  child: Image.asset(
                    'imagens/tesoura.png',
                    height: 90,
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}

class Placar extends StatelessWidget {
  const Placar({
    Key? key,
    required String nomeJogador,
    required int pontosJogador,
  })  : _pontosJogador = pontosJogador,
        _nomeJogador = nomeJogador,
        super(key: key);

  final int _pontosJogador;
  final String _nomeJogador;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          _nomeJogador,
          style: TextStyle(
            // Altera a cor do contorno do texto
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = Color.fromARGB(255, 194, 60, 60),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 9, 112, 160), // Cor da borda
              width: 2, // Largura da borda
            ),
            borderRadius: BorderRadius.circular(7), // Borda arredondada
          ),
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(35),
          child: Text(
            '$_pontosJogador',
            style: TextStyle(fontSize: 26),
          ),
        )
      ],
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({
    Key? key,
    required Color borderColor,
    required String imgPlayer,
  })  : _borderColor = borderColor,
        _imgPlayer = imgPlayer,
        super(key: key);

  final Color _borderColor;
  final String _imgPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: _borderColor, width: 4),
          borderRadius: const BorderRadius.all(Radius.circular(100))),
      child: Image.asset(
        _imgPlayer,
        height: 120,
      ),
    );
  }
}

void main() {
  runApp(const PedraPT());
}
