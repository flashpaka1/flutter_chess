import "package:chess_app/chess_piece.dart";
import "package:chess_app/chess_pieces.dart";
import "package:chess_app/position.dart";

bool isBishopValid(ChessPiece movedPiece, Position position) {
  if (movedPiece.position == position) return false;

  bool major = isInMajorDiagonal(movedPiece.position, position);
  bool minor = isInMinorDiagonal(movedPiece.position, position);

  if(!major && !minor) return false;

  int rowStep = position.row > movedPiece.position.row ? 1 : -1;
  int colStep = position.col > movedPiece.position.col ? 1 : -1;

  int currentRow = movedPiece.position.row + rowStep;
  int currentCol = movedPiece.position.col + colStep;

  while (currentRow != position.row && currentCol != position.col) {
    if (pieces.any((piece) =>
        piece.position.row == currentRow && piece.position.col == currentCol)) {
      return false;
    }
    currentRow += rowStep;
    currentCol += colStep;
  }

  return true;
}

bool isInMajorDiagonal(Position a, Position b) {
  return (a.row - a.col) == (b.row - b.col);
}

bool isInMinorDiagonal(Position a, Position b) {
  return (a.row + a.col) == (b.row + b.col);
}

bool isPawnValid(ChessPiece movedPiece, Position newPosition) {
  bool isOneStep = movedPiece.color == PieceColor.white
      ? newPosition.row == movedPiece.position.row - 1 &&
          newPosition.col == movedPiece.position.col
      : newPosition.row == movedPiece.position.row + 1 &&
          newPosition.col == movedPiece.position.col;

  bool isFirstMove = (movedPiece.color == PieceColor.white &&
          movedPiece.position.row == 6) ||
      (movedPiece.color == PieceColor.black && movedPiece.position.row == 1);
  bool isTwoSteps = isFirstMove &&
      ((movedPiece.color == PieceColor.white &&
              newPosition.row == movedPiece.position.row - 2 &&
              newPosition.col == movedPiece.position.col) ||
          (movedPiece.color == PieceColor.black &&
              newPosition.row == movedPiece.position.row + 2 &&
              newPosition.col == movedPiece.position.col));

  bool isCapture = false;
  int targetRowOffset = movedPiece.color == PieceColor.white ? -1 : 1;
  List<Position> attackPositions = [
    Position(
        movedPiece.position.row + targetRowOffset, movedPiece.position.col - 1),
    Position(
        movedPiece.position.row + targetRowOffset, movedPiece.position.col + 1)
  ];

  for (Position pos in attackPositions) {
    if (pos == newPosition) {
      ChessPiece? opponentPiece =
          pieces.firstWhere((p) => p.position == newPosition);
      // ignore: unnecessary_null_comparison
      if (opponentPiece != null && opponentPiece.color != movedPiece.color) {
        isCapture = true;
        break;
      }
    }
  }

  return isOneStep || isTwoSteps || isCapture;
}

void promotePawn(ChessPiece movedPiece) {
  if (movedPiece.color == PieceColor.white && movedPiece.position.row == 0)
    movedPiece.type == PieceType.queen;
  if (movedPiece.color == PieceColor.black && movedPiece.position.row == 7)
    movedPiece.type == PieceType.queen;
}

bool isRookValid(ChessPiece movedPiece, Position position) {
  bool isSameRow = movedPiece.position.row == position.row;
  bool isSameCol = movedPiece.position.col == position.col;

  if (!isSameRow && !isSameCol) {
    return false;
  }

  int start = isSameRow
      ? (movedPiece.position.col > position.col
              ? position.col
              : movedPiece.position.col) +
          1
      : (movedPiece.position.row > position.row
              ? position.row
              : movedPiece.position.row) +
          1;
  int end = isSameRow
      ? (movedPiece.position.col < position.col
          ? position.col
          : movedPiece.position.col)
      : (movedPiece.position.row < position.row
          ? position.row
          : movedPiece.position.row);

  for (int i = start; i < end; i++) {
    int checkRow = isSameRow ? movedPiece.position.row : i;
    int checkCol = isSameRow ? i : movedPiece.position.col;
    if (pieces.any((piece) =>
        piece.position.row == checkRow && piece.position.col == checkCol)) {
      return false;
    }
  }

  return true;
}

bool isKnightValid(ChessPiece movedPiece, Position position) {
  int rowDifference = (movedPiece.position.row - position.row).abs();
  int colDifference = (movedPiece.position.col - position.col).abs();

  return (rowDifference == 2 && colDifference == 1) ||
      (rowDifference == 1 && colDifference == 2);
}

bool isQueenValid(ChessPiece movedPiece, Position position) {
  return isRookValid(movedPiece, position) ||
      isBishopValid(movedPiece, position);
}

ChessPiece? pieceAtPosition(Position position) {
  ChessPiece? piece;
  for (ChessPiece p in pieces) {
    piece = (p.position == position ? p : null);
  }
  return piece;
}
bool? isKingInDiagonalCheck(Position kingPosition, PieceColor kingColor) {
  var directions = [1, -1]; 

  for (int dRow in directions) {
    for (int dCol in directions) {
      int currentRow = kingPosition.row + dRow;
      int currentCol = kingPosition.col + dCol;

      while (currentRow >= 0 && currentRow < 8 && currentCol >= 0 && currentCol < 8) {
        ChessPiece? piece = pieceAtPosition(Position(currentRow, currentCol));
        
        if (piece != null) {
          if (piece.color != kingColor && (piece.type == PieceType.bishop || piece.type == PieceType.queen)) {
            return true;
          }
          break; 
        }

        currentRow += dRow;
        currentCol += dCol;
      }
    }
  }

  return false;
}

bool? isKingLongCheck(Position kingPosition, PieceColor kingColor) {
  List<List<int>> directions = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0]
  ];

  for (List<int> direction in directions) {
    int dRow = direction[0];
    int dCol = direction[1];

    int currentRow = kingPosition.row + dRow;
    int currentCol = kingPosition.col + dCol;

    while (currentRow >= 0 && currentRow < 8 && currentCol >= 0 && currentCol < 8) {
      ChessPiece? piece = pieceAtPosition(Position(currentRow, currentCol));

      if (piece != null) {
        if (piece.color != kingColor && (piece.type == PieceType.rook || piece.type == PieceType.queen)) {
          return true;
        }
        break;
      }

      currentRow += dRow;
      currentCol += dCol;
    }
  }
}

bool isKingInPawnCheck(Position kingPosition, PieceColor kingColor) {
  List<Position> attackPositions;

  if (kingColor == PieceColor.white) {
    attackPositions = [
      Position(kingPosition.row - 1, kingPosition.col - 1),
      Position(kingPosition.row - 1, kingPosition.col + 1)
    ];
  } else {
    attackPositions = [
      Position(kingPosition.row + 1, kingPosition.col - 1),
      Position(kingPosition.row + 1, kingPosition.col + 1)
    ];
  }

  for (Position attackPosition in attackPositions) {
    if (attackPosition.row >= 0 && attackPosition.row < 8 &&
        attackPosition.col >= 0 && attackPosition.col < 8) {
      ChessPiece? attacker = pieceAtPosition(attackPosition);
      if (attacker != null && attacker.type == PieceType.pawn && attacker.color != kingColor) {
        return true;
      }
    }
  }

  return false;
}

bool isKingInKnightCheck(Position kingPosition, PieceColor kingColor) {
  List<Position> potentialThreatPositions = [
    Position(kingPosition.row + 2, kingPosition.col + 1),
    Position(kingPosition.row + 2, kingPosition.col - 1),
    Position(kingPosition.row - 2, kingPosition.col + 1),
    Position(kingPosition.row - 2, kingPosition.col - 1),
    Position(kingPosition.row + 1, kingPosition.col + 2),
    Position(kingPosition.row + 1, kingPosition.col - 2),
    Position(kingPosition.row - 1, kingPosition.col + 2),
    Position(kingPosition.row - 1, kingPosition.col - 2)
  ];

  for (Position threatPosition in potentialThreatPositions) {
    if (threatPosition.row >= 0 && threatPosition.row < 8 &&
        threatPosition.col >= 0 && threatPosition.col < 8) {
      ChessPiece? knight = pieceAtPosition(threatPosition);
      if (knight != null && knight.type == PieceType.knight && knight.color != kingColor) {
        return true;
      }
    }
  }

  return false;
}