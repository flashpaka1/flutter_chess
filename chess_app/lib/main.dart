import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chess',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyChessGame(),
    );
  }
}

class MyChessGame extends StatelessWidget {
  const MyChessGame({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Don\'t Lose', 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 36, 36, 36),
      ),
      body: Center(
        child: ChessBoard(),
      ),
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
    );
  }
}

class ChessBoard extends StatelessWidget {
  ChessBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Adjust as needed
      height: 300, // Adjust as needed
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 26, 159, 66), width: 2),
      ),
      child: Column(
        children: List.generate(8, (row) {
          return Expanded(
            child: Row(
              children: List.generate(8, (col) {
                return _buildSquare(row, col);
              }),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildSquare(int row, int col) {
      Color lightColor = const Color.fromARGB(255, 255, 242, 211);
      Color darkColor = const Color.fromARGB(255, 26, 159, 66);
      Color color = (row + col) % 2 == 0 ? lightColor : darkColor;

      ChessPiece? piece = _findPieceForPosition(row, col);

      return Expanded(
        child: Container(
          color: color,
          child: InkWell(
            onTap: () {
              print('Clicked square: ${String.fromCharCode(col + 97)}${8 - row}');
            },
            child: piece != null ? _buildPiece(piece) : null,
          ),
        ),
      );
    }

    ChessPiece? _findPieceForPosition(int row, int col) {
      for (var piece in pieces) {
        if (piece.position.row == row && piece.position.col == col) {
          return piece;
        }
      }
      return null;
    }

    Widget _buildPiece(ChessPiece piece) {
      String imagePath = _getImagePath(piece);
      return Image.asset(
        imagePath,
        fit: BoxFit.cover, // Make sure the images fit well in the squares
      );
    }

    String _getImagePath(ChessPiece piece) {
      String color = piece.color == PieceColor.white ? 'white' : 'black';
      String typeName = piece.type.toString().split('.').last;
      // Ensure your asset names are correct and match the file names in the assets folder.
      return 'assets/$color-$typeName.png';
    }
}

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

void setState(Null Function() param0) {}

class ChessPiece {
  final PieceType type;
  final PieceColor color;
  final Position position;

  ChessPiece({required this.type, required this.color, required this.position});
}

class Position {
  final int row;
  final int col;
  
  Position(this.row, this.col);
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