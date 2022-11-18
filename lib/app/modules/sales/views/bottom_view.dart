import 'package:flutter/material.dart';

class BottomView extends StatelessWidget {
  const BottomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 88, 87, 87),
        borderRadius:  const BorderRadius.vertical(top: Radius.circular(20.0)),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      height: 70,
      width: double.maxFinite,
      child:  Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[
                // IconButton(icon: Icon(Icons.arrow_forward), onPressed: (){},),
                // IconButton(icon: Icon(Icons.arrow_downward), onPressed: (){},),
                // IconButton(icon: Icon(Icons.arrow_left), onPressed: (){},),
                // IconButton(icon: Icon(Icons.arrow_upward), onPressed: (){},),
              ],
            ),
    );
  }
}
