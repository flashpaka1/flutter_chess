import "package:chess_app/chess_piece.dart";
import 'package:chess_app/chess_methods.dart';
import "package:chess_app/position.dart";

class Game {
  PieceColor? userTurn;
  int? turn;
  bool? check;
  bool? checkmate;

  Game(){
    userTurn = PieceColor.white;
    turn = 0;
    check = false;
    checkmate;
  }

  bool determine_move(ChessPiece movedPiece, Position position){
    if (movedPiece.color == userTurn){
      if (movedPiece.type == PieceType.bishop) return isBishopValid(movedPiece, position);
      if (movedPiece.type == PieceType.pawn) return isPawnValid(movedPiece, position);
    }
    return false;
  }

  bool? getCheckMate(){
    return checkmate;
  }
  void setCheckMate(bool checkmate){
    this.checkmate = checkmate;
  }
}