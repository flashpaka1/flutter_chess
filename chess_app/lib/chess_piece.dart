import "package:chess_app/position.dart";

class ChessPiece {
  PieceType type;
  final PieceColor color;
  Position position;

  ChessPiece({required this.type, required this.color, required this.position});
}

enum PieceType {
  pawn,
  bishop,
  knight,
  rook,
  queen,
  king
}

enum PieceColor {
  white,
  black
}