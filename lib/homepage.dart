import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayExOh = ['', '', '', '', '', '', '', '', ''];

  bool ohTurn = true; // true = O, false = X
  int ohScore = 0;
  int exScore = 0;
  int filledBoxes = 0;

  static const TextStyle myFontWhite = TextStyle(
      color: Colors.white, letterSpacing: 2, fontSize: 18, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111827),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F2937),
              Color(0xFF111827),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              // --- PLACAR ---
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _buildScoreBoard('Jogador O', ohScore),
                    const SizedBox(width: 40),
                    _buildScoreBoard('Jogador X', exScore),
                  ],
                ),
              ),
              
              // --- TABULEIRO ---
              Expanded(
                flex: 3,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 9,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                _tapped(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white24, width: 1.0)),
                                child: Center(
                                  child: Text(
                                    displayExOh[index],
                                    style: TextStyle(
                                      color: displayExOh[index] == 'x' 
                                          ? const Color.fromARGB(255, 151, 67, 67) // Vermelho Suave
                                          : const Color.fromARGB(255, 59, 138, 133), // Ciano Suave
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
              
              // --- RODAPÉ COM INDICADOR DE VEZ ---
              Expanded(
                flex: 1,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('JOGO DA VELHA', style: myFontWhite),
                      const SizedBox(height: 15),
                      // Indicador de quem joga agora
                      Text(
                        ohTurn ? 'VEZ DE O' : 'VEZ DE X',
                        style: TextStyle(
                          color: ohTurn ? const Color.fromARGB(255, 59, 138, 133) : const Color.fromARGB(255, 151, 67, 67),
                          letterSpacing: 3,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildScoreBoard(String title, int score) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(title, style: myFontWhite.copyWith(fontSize: 14, color: Colors.white70)),
        const SizedBox(height: 10),
        Text(score.toString(), 
            style: myFontWhite.copyWith(fontSize: 28)),
      ],
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'o';
        filledBoxes += 1;
      } else if (!ohTurn && displayExOh[index] == '') {
        displayExOh[index] = 'x';
        filledBoxes += 1;
      } else {
        return;
      }

      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (checkLine(0, 1, 2)) return;
    if (checkLine(3, 4, 5)) return;
    if (checkLine(6, 7, 8)) return;
    if (checkLine(0, 3, 6)) return;
    if (checkLine(1, 4, 7)) return;
    if (checkLine(2, 5, 8)) return;
    if (checkLine(0, 4, 8)) return;
    if (checkLine(6, 4, 2)) return;

    if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  bool checkLine(int a, int b, int c) {
    if (displayExOh[a] == displayExOh[b] &&
        displayExOh[a] == displayExOh[c] &&
        displayExOh[a] != '') {
      _showWinDialog(displayExOh[a]);
      return true;
    }
    return false;
  }

  // Alerta (Empate)
  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // Fundo 
            backgroundColor: Colors.black.withOpacity(0.7), 
            title: const Text('EMPATE', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              TextButton(
                child: const Text('Jogar Novamente', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  // Alerta (Vitória)
  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            // Fundo 
            backgroundColor: Colors.black.withOpacity(0.7),
            title: Text('VENCEDOR: ${winner.toUpperCase()}', 
              style: TextStyle(
                // Usa a cor do vencedor no título
                color: winner == 'x' ? const Color.fromARGB(255, 151, 67, 67) : const Color.fromARGB(255, 59, 138, 133)
              )
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Jogar Novamente', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
    });
    filledBoxes = 0;
  }
}