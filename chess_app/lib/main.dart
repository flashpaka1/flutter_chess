import 'dart:js';

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
  const ChessBoard({Key? key}) : super(key: key);

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
  Color color = (row + col) % 2 == 0 ? lightColor : darkColor!;
  return Expanded(
    child: Container(
      color: color,
      child: InkWell(
        onTap: () {
          // Add functionality for tapping squares here
          print('Clicked square: ${String.fromCharCode(col + 97)}${8 - row}');
        },
        child: DragTarget<ChessPiece>(
          builder: (context, candidateData, rejectedData) {
            // Return an empty Container if no piece is present, otherwise return the piece
            return _getPieceAtPositon(row, col) ?? Container();
          },
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data) {
            setState(() {
              data!.position = Position(row, col);
            });
          },
        ),
      ),
    ),
  );
}


  Widget _getPieceAtPositon(int row, int col) {
    ChessPiece? piece = pieces.firstWhere((p) => p.position.row == row && p.position.col == col);
    if (piece != null){
      return Draggable<ChessPiece>(
        data: piece,
        child: _buildPiece(piece),
        feedback: _buildPiece(piece),
        childWhenDragging: Container(),
      );
    }
    else {
      return Container();
    }
  }
  Widget _buildPiece(ChessPiece piece) {
    return Text(
      piece.type.toString().substring(10), // Display piece type
      style: TextStyle(
        fontSize: 20,
        color: piece.color == PieceColor.white ? Colors.black : Colors.white,
      ),
    );
  }
 
  List<ChessPiece> pieces = [
    // white's pieces
    // pawns
    ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(1,0)),
    ChessPiece(type: PieceType.pawn, color: PieceColor.white, position: Position(1,1)),
    ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,2)),
    ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,3)),
    ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,4)),
    ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,5)),
    ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,6)),
    ChessPiece(type: PieceType.pawn, color: PieceColor.black, position: Position(1,7)),
  ];
  
  void setState(Null Function() param0) {}
}
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