import 'package:flutter/material.dart';
import 'package:tictactoe_app/data/tictactoe_logic.dart';


class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({Key? key}) : super(key: key);

  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  TicTacToeLogic _logic = TicTacToeLogic();

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
              _logic.isPlayer1Turn ? 'Player 1 Turn' : 'Player 2 Turn',
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
                        _logic.board[row][col],
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
    if (_logic.board[row][col] == '') {
      setState(() {
        _logic.updateBoard(row, col);
      });
      _checkWinner(row, col);
    }
  }

  void _checkWinner(int row, int col) {
    if (_logic.checkWinner(row, col)) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Winner'),
          content: Text('Player ${_logic.currentPlayer} won!'),
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
      _logic.resetBoard();
    });
  }
}
