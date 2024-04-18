import 'package:flutter/material.dart';
import 'package:maze/maze.dart';
import 'package:maze_puzzle/view/home.dart';
import '../model/data.dart';

class ElMaze extends StatefulWidget {
  const ElMaze({
    super.key,
    required this.data,
  });
  final Data data;

  @override
  State<ElMaze> createState() => _ElMazeState();
}

class _ElMazeState extends State<ElMaze> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
           
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const Home()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: Maze(
              player: MazeItem(widget.data.img_1, ImageType.asset),
              columns: 6,
              rows: 12,
              wallThickness: 4.0,
              wallColor: Theme.of(context).primaryColor,
              finish: MazeItem(widget.data.img_2, ImageType.asset),
              onFinish: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Congrats you finished the maze'),
                          actions: [
                            IconButton(
                                onPressed: () {
                             
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ElMaze(data: widget.data)),
                                      (route) => false);
                                },
                                icon: const Icon(Icons.done))
                          ],
                        ));
              })),

    );
  }
}
