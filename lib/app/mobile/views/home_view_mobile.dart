import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:my_first_app/app/service/repo.dart';

class HomeViewMobile extends GetView {
  const HomeViewMobile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppbar,
        backgroundColor: myDefaultBackground,
        drawer: myDrawer,
        body: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: SizedBox(
                width: double.infinity,
                child: GridView.builder(
                    itemCount: 4,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Expanded(child: ListView.builder(
              itemCount: 5,
              itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  ),
                  height: 80,
                ),
              );
            }))
          ],
        ));
  }
}
