import "package:chess_app/chess_piece.dart";
import "package:chess_app/chess_pieces.dart";
import "package:chess_app/position.dart";

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

bool isInMajorDiagonal(Position a, Position b){
  return ((a.row - a.col) == (b.row - b.col)) ? true : false;
}
bool isInMinorDiagonal(Position a, Position b){
  return ((a.row + a.col) == (b.row + b.col)) ? true : false;
}

isPawnValid(ChessPiece movedPiece, Position position) {
 return true;
}