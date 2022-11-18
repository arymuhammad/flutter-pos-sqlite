// import 'package:custom_shimmer_loader_state_mixin_flutter_getx/app/modules/home/views/rounded_elevated_button.dart';
import 'package:flutter/material.dart';

class EmptyFailureNoInternetView extends StatelessWidget {
  const EmptyFailureNoInternetView(
      {required this.image,
      required this.title,
      required this.description,
      // required this.buttonText,
      required this.onPressed});

  final String title, description, image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Lottie.asset(
              //   image,
              //   height: 250,
              //   width: 250,
              // ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: onPressed,
                child: const Text("Refresh"),
                // childText: buttonText,
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}