import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tic Tac Toe',
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<List<String>> _board = List.generate(3, (_) => List.filled(3, ''));

  bool _isPlayer1Turn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isPlayer1Turn ? 'Player 1 Turn' : 'Player 2 Turn',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () {
                    _onTilePressed(row, col);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        _board[row][col],
                        style: const TextStyle(fontSize: 48.0),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _resetBoard,
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  void _onTilePressed(int row, int col) {
    if (_board[row][col] == '') {
      setState(() {
        _board[row][col] = _isPlayer1Turn ? 'X' : 'O';
        _isPlayer1Turn = !_isPlayer1Turn;
      });
      _checkWinner(row, col);
    }
  }

  void _checkWinner(int row, int col) {
    String player = _board[row][col];
    bool won = false;

    // Check row
    for (int i = 0; i < 3; i++) {
      if (_board[row][i] != player) break;
      if (i == 2) won = true;
    }

    // Check column
    for (int i = 0; i < 3; i++) {
      if (_board[i][col] != player) break;
      if (i == 2) won = true;
    }

    // Check diagonal
    if (row == col) {
      for (int i = 0; i < 3; i++) {
        if (_board[i][i] != player) break;
        if (i == 2) won = true;
      }
    }

    // Check anti-diagonal
    if (row + col == 2) {
      for (int i = 0; i < 3; i++) {
        if (_board[i][2 - i] != player) break;
        if (i == 2) won = true;
      }
    }

    if (won) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Winner'),
          content: Text('Player $player won!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetBoard();
              },
              child: const Text('Play Again'),
            ),
          ],
        ),
      );
    }
  }

  void _resetBoard() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _isPlayer1Turn = true;
    });
  }
}
