import 'package:chess_app/chess_methods.dart';
import 'package:chess_app/chess_piece.dart';
import 'package:chess_app/game_engine.dart';
import 'package:chess_app/position.dart';
import 'package:chess_app/services/auth_service.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chess_app/chess_pieces.dart';
import 'package:chess_app/pages/login_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Game engine = Game();
String titleText = "Chess 2";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final stream = AuthService().loggedInStream;
    return MaterialApp(
      title: 'Flutter Chess',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: stream,
        builder: (context, snapshot){
          if(snapshot.hasData && snapshot.data == true){
            return const MyChessGame();
          }
          return const LoginPage();
        })
    );
  }
}

class MyChessGame extends StatelessWidget {
  const MyChessGame({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleText, 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 36, 36, 36),
      ),
      body: Center(
        child: ChessBoard(),
      ),
      drawer: Drawer(
       
        child: SafeArea(
          child: Column(children: [
            ListTile(
              tileColor: Colors.white,
              title: const Text('sign out'),
              onTap: (){
                AuthService().signOut();
              }
            )
          ],)
        )
      ),
      backgroundColor: const Color.fromARGB(255, 36, 36, 36),
    );
  }
}

class ChessBoard extends StatefulWidget {
  ChessBoard({Key? key}) : super(key: key);

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
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
        child: DragTarget<ChessPiece>(
          onWillAccept: (ChessPiece? incomingPiece) {
            if (engine.checkmate == true) {
              changeTitle();
              return false;
            }
            Position incomingPosition = Position(row, col);
            return engine.determine_move(incomingPiece!, incomingPosition)!;
          },
          onAccept: (movedPiece) {
             setState(() {
              Position position = Position(row, col);
              engine.takePiece(position);
              movedPiece.position = Position(row, col);
              if (movedPiece.type == PieceType.pawn) promotePawn(movedPiece);
              engine.toggleTurn();
            });
          },
          builder: (context, candidateData, rejectedData) => Container(
            color: color,
            child: piece == null ? null : Draggable<ChessPiece>(
              data: piece,
              feedback: Transform.scale(
                scale: 0.75,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Opacity(
                    opacity: 1,
                    child: _buildPiece(piece),
                  ),
                ),
              ),
              childWhenDragging: Container(),
              child: _buildPiece(piece),
            ),
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
        fit: BoxFit.cover,
      );
    }

    String _getImagePath(ChessPiece piece) {
      String color = piece.color == PieceColor.white ? 'white' : 'black';
      String typeName = piece.type.toString().split('.').last;
      return 'assets/$color-$typeName.png';
    }
}

void changeTitle(){
  if(engine.checkmate == false) titleText = "Chess 2";
  titleText = engine.userTurn == PieceColor.white ? "White Wins!" : "Black Wins!";
}