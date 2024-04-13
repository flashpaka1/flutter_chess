import 'package:chess_app/chess_piece.dart';
import 'package:chess_app/position.dart';

List<ChessPiece> pieces = [
  // black's pieces
  // pawns
  ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,0)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,1)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,2)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,3)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,4)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,5)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,6)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,7)),
  // rooks
  ChessPiece(type: PieceType.rook, color: PieceColor.black, position: Position(0,0)),
  ChessPiece(type: PieceType.rook, color: PieceColor.black, position: Position(0,7)),
  // knights
  ChessPiece(type: PieceType.knight, color: PieceColor.black, position: Position(0,1)),
  ChessPiece(type: PieceType.knight, color: PieceColor.black, position: Position(0,6)),
  // bishops
  ChessPiece(type: PieceType.bishop, color: PieceColor.black, position: Position(0,2)),
  ChessPiece(type: PieceType.bishop, color: PieceColor.black, position: Position(0,5)),
  // king
  ChessPiece(type: PieceType.king, color: PieceColor.black, position: Position(0,4)),
  // queen
  ChessPiece(type: PieceType.queen, color: PieceColor.black, position: Position(0,3)),
  // white's pieces
  // pawns
  ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(6,0)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(6,1)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(6,2)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(6,3)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(6,4)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(6,5)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(6,6)),
  ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(6,7)),
  // rooks
  ChessPiece(type: PieceType.rook, color: PieceColor.white, position: Position(7,0)),
  ChessPiece(type: PieceType.rook, color: PieceColor.white, position: Position(7,7)),
  // knights
  ChessPiece(type: PieceType.knight, color: PieceColor.white, position: Position(7,1)),
  ChessPiece(type: PieceType.knight, color: PieceColor.white, position: Position(7,6)),
  // bishops
  ChessPiece(type: PieceType.bishop, color: PieceColor.white, position: Position(7,2)),
  ChessPiece(type: PieceType.bishop, color: PieceColor.white, position: Position(7,5)),
  // king
  ChessPiece(type: PieceType.king, color: PieceColor.white, position: Position(7,4)),
  // queen
  ChessPiece(type: PieceType.queen, color: PieceColor.white, position: Position(7,3)),
];