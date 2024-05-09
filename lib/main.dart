import 'package:flutter/material.dart';
import 'package:tictactoe_app/presentation/tictactoe_screen.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      home: TicTacToeScreen(),
    );
  }
}
