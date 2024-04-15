import "package:chess_app/chess_piece.dart";
import 'package:chess_app/chess_methods.dart';
import "package:chess_app/position.dart";

class Game {
  PieceColor? userTurn;
  int turn = 0;
  bool? check;
  bool? checkmate;

  Game(){
    userTurn = PieceColor.white;
    turn = 0;
    check = false;
    checkmate;
  }

  bool determine_move(ChessPiece movedPiece, Position position){
    if (movedPiece.color != userTurn) return false;
    
    switch (movedPiece.type) {
      case PieceType.bishop:
        print("gets bishop");
        return isBishopValid(movedPiece, position);
      case PieceType.pawn:
        return isPawnValid(movedPiece, position);
      case PieceType.rook:
        print("gets rook");
        return isRookValid(movedPiece, position);
      case PieceType.knight:
        return isKnightValid(movedPiece, position);
      case PieceType.queen:
        print("gets queen");
        return isQueenValid(movedPiece, position);
      default:
        return false;
    }
  }

  bool? getCheckMate(){
    return checkmate;
  }
  void setCheckMate(bool checkmate){
    this.checkmate = checkmate;
  }

  void toggleTurn(){
    if (userTurn == PieceColor.white){
      userTurn = PieceColor.black;
    } 
    if (userTurn == PieceColor.black){
      userTurn = PieceColor.white;
      turn++;
    }
  }
}