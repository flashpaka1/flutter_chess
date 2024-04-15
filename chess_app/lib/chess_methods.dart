import "package:chess_app/chess_piece.dart";
import "package:chess_app/chess_pieces.dart";
import "package:chess_app/position.dart";
import "package:flutter/material.dart";

// bool isBishopValid(ChessPiece movedPiece, Position position) {
//   print("determining bishop");
//   if (!isInMajorDiagonal(movedPiece.position, position) && !isInMinorDiagonal(movedPiece.position, position)) {
//     return false;
//   }

//   int rowStep = position.row > movedPiece.position.row ? 1 : -1;
//   int colStep = position.col > movedPiece.position.col ? 1 : -1;

//   int currentRow = movedPiece.position.row + rowStep;
//   int currentCol = movedPiece.position.col + colStep;

//   while (currentRow != position.row || currentCol != position.col) {
//     if (pieces.any((piece) => piece.position.row == currentRow && piece.position.col == currentCol)) {
//       return false;
//     }
//     currentRow += rowStep;
//     currentCol += colStep;
//   }

//   return true;
// }

bool isBishopValid(ChessPiece movedPiece,Position position) {
  bool major = isInMajorDiagonal(movedPiece.position, position);
  bool minor = isInMinorDiagonal(movedPiece.position, position);
  bool inPath = false;

  int rowStep = position.row > movedPiece.position.row ? 1 : -1;
  int colStep = position.col > movedPiece.position.col ? 1 : -1;
  
  int currentRow = movedPiece.position.row + rowStep;
  int currentCol = movedPiece.position.col + colStep;

  while (currentRow != position.row && currentCol != position.col) {
    if (pieces.any((piece) => piece.position.row == currentRow && piece.position.col == currentCol)) {
      inPath = true;
      break;
    }
    currentRow += rowStep;
    currentCol += colStep;
  }

  return !inPath && (major || minor);
}

bool isInMajorDiagonal(Position a, Position b) {
  return (a.row - a.col) == (b.row - b.col);
}

bool isInMinorDiagonal(Position a, Position b) {
  return (a.row + a.col) == (b.row + b.col);
}


// isPawnValid(ChessPiece movedPiece, Position position) {
//   bool isOne;
//   bool isTwo;
//   bool isTaking;

//   // if the moved position is one square infront --> valid
//   isOne = (position.col + 1) == movedPiece.position.col ? true : false;

//   // if the white pawn is on its starting rank, or the black pawn is on the starting rank, then isFirstMove is true
//   bool isFirstMove = (movedPiece.color == PieceColor.white && movedPiece.position.row == 6) || (movedPiece.color == PieceColor.black && movedPiece.position.row == 1) ? true : false;

//   // if the movement is two squares infront and its the pieces first move --> valid
//   isTwo = ((position.col + 2) == movedPiece.position.col) && isFirstMove ? true : false;

//   bool isPieceDiagAdj(){
//     Position l_Adj = Position(0, 0);
//     Position r_Adj = Position(0, 0);

//     int x = movedPiece.position.row;
//     int y = movedPiece.position.col;

//     ChessPiece? takePiece;
    
//     if (movedPiece.color == PieceColor.white){
//       l_Adj = Position(x - 1, y - 1);
//       r_Adj = Position(x + 1, y - 1);
//     }
//     else if (movedPiece.color == PieceColor.black){
//       l_Adj = Position(x - 1, y + 1);
//       r_Adj = Position(x + 1, y + 1);
//     }

//     for (ChessPiece p in pieces){
//       takePiece = p.position == position ? p : null;
//     }
    
//     if (takePiece == null) return false;
//     else if(takePiece.position == l_Adj || takePiece.position == r_Adj) return true;
//     else return false;
//   }

//   isTaking = isPieceDiagAdj();

//  return isOne || isTwo || isTaking;
// }

bool isPawnValid(ChessPiece movedPiece, Position newPosition) {
  // Check if the move is vertically forward by one row
  bool isOneStep = movedPiece.color == PieceColor.white ? 
                   newPosition.row == movedPiece.position.row - 1 && newPosition.col == movedPiece.position.col :
                   newPosition.row == movedPiece.position.row + 1 && newPosition.col == movedPiece.position.col;

  // Check if it's the pawn's first move and the move is two rows forward
  bool isFirstMove = (movedPiece.color == PieceColor.white && movedPiece.position.row == 6) ||
                     (movedPiece.color == PieceColor.black && movedPiece.position.row == 1);
  bool isTwoSteps = isFirstMove && 
                    ((movedPiece.color == PieceColor.white && newPosition.row == movedPiece.position.row - 2 && newPosition.col == movedPiece.position.col) ||
                     (movedPiece.color == PieceColor.black && newPosition.row == movedPiece.position.row + 2 && newPosition.col == movedPiece.position.col));

  // Check for diagonal captures
  bool isCapture = false;
  int targetRowOffset = movedPiece.color == PieceColor.white ? -1 : 1;
  List<Position> attackPositions = [
    Position(movedPiece.position.row + targetRowOffset, movedPiece.position.col - 1),
    Position(movedPiece.position.row + targetRowOffset, movedPiece.position.col + 1)
  ];

  for (Position pos in attackPositions) {
    if (pos == newPosition) {
      ChessPiece? opponentPiece = pieces.firstWhere((p) => p.position == newPosition);
      if (opponentPiece != null && opponentPiece.color != movedPiece.color) {
        isCapture = true;
        break;
      }
    }
  }

  // Return true if any of the valid moves are made
  return isOneStep || isTwoSteps || isCapture;
}


void promotePawn(ChessPiece movedPiece){
  if (movedPiece.color == PieceColor.white && movedPiece.position.row == 0) movedPiece.type == PieceType.queen;
  if (movedPiece.color == PieceColor.black && movedPiece.position.row == 7) movedPiece.type == PieceType.queen;
}

bool isRookValid(ChessPiece movedPiece, Position position) {
  bool isSameRow = movedPiece.position.row == position.row;
  bool isSameCol = movedPiece.position.col == position.col;

  if (!isSameRow && !isSameCol) {
    return false;
  }

  int start = isSameRow ? (movedPiece.position.col > position.col? position.col : movedPiece.position.col) + 1 : (movedPiece.position.row > position.row? position.row : movedPiece.position.row) + 1;
  int end = isSameRow ? (movedPiece.position.col < position.col? position.col : movedPiece.position.col) : (movedPiece.position.row < position.row? position.row : movedPiece.position.row);

  for (int i = start; i < end; i++) {
    int checkRow = isSameRow ? movedPiece.position.row : i;
    int checkCol = isSameRow ? i : movedPiece.position.col;
    if (pieces.any((piece) => piece.position.row == checkRow && piece.position.col == checkCol)) {
      return false;
    }
  }

  return true;
}

bool isKnightValid(ChessPiece movedPiece, Position position) {
  int rowDifference = (movedPiece.position.row - position.row).abs();
  int colDifference = (movedPiece.position.col - position.col).abs();

  return (rowDifference == 2 && colDifference == 1) || (rowDifference == 1 && colDifference == 2);
}

bool isQueenValid(ChessPiece movedPiece, Position position){
  return isRookValid(movedPiece, position) || isBishopValid(movedPiece, position);
}