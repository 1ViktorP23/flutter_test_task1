import 'package:flutter/material.dart';

import 'custom_grid.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  int _animatableValue = 0;

  double setBoxSizeSide(double width) => width / CustomGrid.rowsCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Spacer(),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return boxContainer(width: constraints.maxWidth);
            },
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [leftButton(), rightButton()],
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget leftButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _animatableValue += 1;
        });
      },
      child: Text("Turn Left"),
    );
  }

  Widget rightButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _animatableValue -= 1;
        });
      },
      child: Text("Turn Right"),
    );
  }

  Widget boxContainer({double width = 0.0}) {
    return Stack(
      children: [
        // backgroung container
        Column(
          children: [
            for (var row in List.generate(8, (int index) => (index + 1)))
              Row(
                children: [
                  for (var column in List.generate(
                    8,
                    (int index) => (index + 1),
                  ))
                    boxItem(
                      width,
                      CustomGrid(
                        row: row.toDouble(),
                        column: column.toDouble(),
                      ),
                    ),
                ],
              ),
          ],
        ),

        //whiteBoxescontainer
        Container(
          width: width,
          height: width,
          child: Stack(
            children: [
              for (var (index, items) in CustomGrid.boxes.indexed)
                Positioned(
                  width: setBoxSizeSide(width),
                  height: setBoxSizeSide(width),
                  left: createPosition(width, items).dx,
                  top: createPosition(width, items).dy,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    child: Container(color: Colors.white),
                  ),
                ),
            ],
          ),
        ),
        Container(
          width: width,
          height: width,
          child: Stack(
            children: [
              for (var (index, items) in CustomGrid.boxes.indexed)
                // if (index == 0)
                AnimatedPositioned(
                  duration: Duration(seconds: 1),
                  curve: Curves.linear,
                  width: setBoxSizeSide(width),
                  height: setBoxSizeSide(width),
                  left:
                      createAnimatablePosition(
                        width,
                        index,
                        _animatableValue,
                      ).dx,
                  top:
                      createAnimatablePosition(
                        width,
                        index,
                        _animatableValue,
                      ).dy,
                  child: Container(
                    width: setBoxSizeSide(width),
                    height: setBoxSizeSide(width),
                    padding: EdgeInsets.all(2),
                    child: Container(color: CustomGrid.colors[index]),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget boxItem(double width, CustomGrid grid) {
    return Container(
      width: setBoxSizeSide(width),
      height: setBoxSizeSide(width),
      child: Container(margin: EdgeInsets.all(2), color: addBGColor(grid)),
    );
  }

  Offset createAnimatablePosition(double width, int index, int value) {
    var reminderVal = value % CustomGrid.rowsCount.toInt();
    var total = index + reminderVal;
    if (total < CustomGrid.rowsCount.toInt()) {
      return createPosition(width, CustomGrid.boxes[total]);
    } else {
      var newIndex = total - (CustomGrid.rowsCount.toInt());
      return createPosition(width, CustomGrid.boxes[newIndex]);
    }
  }

  Offset createPosition(double width, CustomGrid customGrid) {
    var boxX = width / CustomGrid.rowsCount * customGrid.column;
    var boxY = width / CustomGrid.rowsCount * customGrid.row;
    return Offset(boxX - setBoxSizeSide(width), boxY - setBoxSizeSide(width));
  }

  Color addBGColor(CustomGrid grid) {
    if (grid.row == 1 ||
        grid.row == 8 ||
        grid.column == 1 ||
        grid.column == 8) {
      return Colors.grey[800] ?? Colors.grey;
    } else if (grid.row == 2 ||
        grid.row == 7 ||
        grid.column == 2 ||
        grid.column == 7) {
      return Colors.grey[700] ?? Colors.grey;
    } else if (grid.row == 3 ||
        grid.row == 6 ||
        grid.column == 3 ||
        grid.column == 6) {
      return Colors.grey[600] ?? Colors.grey;
    } else if (grid.row == 4 ||
        grid.row == 5 ||
        grid.column == 4 ||
        grid.column == 5) {
      return Colors.grey[500] ?? Colors.grey;
    } else {
      return Colors.red;
    }
  }
}
