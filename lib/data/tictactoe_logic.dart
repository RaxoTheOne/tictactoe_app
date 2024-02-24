class TicTacToeLogic {
  late List<List<String>> board;
  bool isPlayer1Turn = true;

  String get currentPlayer => isPlayer1Turn ? 'X' : 'O';

  TicTacToeLogic() {
    resetBoard();
  }

  void resetBoard() {
    board = List.generate(3, (_) => List.filled(3, ''));
    isPlayer1Turn = true;
  }

  void updateBoard(int row, int col) {
    board[row][col] = currentPlayer;
    isPlayer1Turn = !isPlayer1Turn;
  }

  bool checkWinner(int row, int col) {
    String player = board[row][col];
    bool won = false;

    // Check row
    for (int i = 0; i < 3; i++) {
      if (board[row][i] != player) break;
      if (i == 2) won = true;
    }

    // Check column
    for (int i = 0; i < 3; i++) {
      if (board[i][col] != player) break;
      if (i == 2) won = true;
    }

    // Check diagonal
    if (row == col) {
      for (int i = 0; i < 3; i++) {
        if (board[i][i] != player) break;
        if (i == 2) won = true;
      }
    }

    // Check anti-diagonal
    if (row + col == 2) {
      for (int i = 0; i < 3; i++) {
        if (board[i][2 - i] != player) break;
        if (i == 2) won = true;
      }
    }

    return won;
  }
}
