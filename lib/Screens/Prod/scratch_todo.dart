import 'package:flutter/material.dart';

class ScratchToDo extends StatefulWidget {
  @override
  _ScratchToDoState createState() => _ScratchToDoState();
}

class _ScratchToDoState extends State<ScratchToDo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   "To Do List",
        //   style: TextStyle(
        //     fontSize: 20,

        //     ),
        //   ),
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Container(
          width: double.infinity,
          color: Colors.green,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "To Do List",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      Container(
                        height: 90,
                        child: Card(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(
            Icons.add_circle_outline,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            // add future todo
          }),
    );
  }
}
