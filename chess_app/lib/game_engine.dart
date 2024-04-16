import "package:chess_app/chess_piece.dart";
import 'package:chess_app/chess_methods.dart';
import "package:chess_app/chess_pieces.dart";
import "package:chess_app/main.dart";
import "package:chess_app/position.dart";

class Game {
  PieceColor userTurn = PieceColor.white;
  int turn = 0;
  bool? check;
  bool? checkmate;

  Game() {
    userTurn = PieceColor.white;
    turn = 0;
    check = false;
    checkmate;
  }

  bool? determine_move(ChessPiece movedPiece, Position position) {
    if (movedPiece.color != userTurn) return false;
    bool validMove;

    switch (movedPiece.type) {
      case PieceType.bishop:
        validMove = isBishopValid(movedPiece, position);
        return validMove;
      case PieceType.pawn:
        validMove = isPawnValid(movedPiece, position);
        return validMove;
      case PieceType.rook:
        validMove = isRookValid(movedPiece, position);
        return validMove;
      case PieceType.knight:
        return isKnightValid(movedPiece, position);
      case PieceType.queen:
        return isQueenValid(movedPiece, position);
      default:
        return false;
    }
  }

  bool? getCheckMate() {
    return checkmate;
  }

  void setCheckMate(bool checkmate) {
    this.checkmate = checkmate;
  }

  void toggleTurn() {
    if (userTurn == PieceColor.white) {
      userTurn = PieceColor.black;
    }
    else {
      userTurn = PieceColor.white;
      turn++;
    }
  }

  void takePiece(Position position) {
    try {
      pieces.remove(pieces.firstWhere((p) => p.position == position));
    } catch (e) {
      print("No piece found at the given position.");
    }
  }
}
