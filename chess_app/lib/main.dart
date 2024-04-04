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
          'The Great Game', 
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
    Color lightColor = Color.fromARGB(255, 255, 242, 211);
    Color darkColor = Color.fromARGB(255, 26, 159, 66);
    Color color = (row + col) % 2 == 0 ? lightColor : darkColor!;
    return Expanded(
      child: Container(
        color: color,
        child: InkWell(
          onTap: () {
            // Add functionality for tapping squares here
            print('Clicked square: ${String.fromCharCode(col + 97)}${8 - row}');
          },
          child: Center(
            child: Text(
              '${String.fromCharCode(col + 97)}${8 - row}',
              style: TextStyle(
                color: color == lightColor ? Colors.black : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
