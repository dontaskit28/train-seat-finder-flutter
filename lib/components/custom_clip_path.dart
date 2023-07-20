import 'package:flutter/material.dart';

// Custom clipper class to create a curved path from the top to the bottom of the container.
class MyCustomCliperFromTop extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // The height of the curved path is set to 70% of the container's height.
    double height = size.height * 0.7;
    double width = size.width;

    // Create a Path object to define the curved shape.
    Path path = Path()
      ..moveTo(0, height) // Move to the starting point of the path.
      ..lineTo(0, 0) // Draw a line to the top-left corner.
      ..lineTo(width, 0) // Draw a line to the top-right corner.
      ..lineTo(width, height) // Draw a line to the bottom-right corner.
      ..lineTo(width - 10,
          height) // Draw a line to create a curve from the top-right to the bottom-right corner.
      ..lineTo(
          width - 10, 10) // Draw a line to create a corner at the bottom-right.
      ..lineTo(10, 10) // Draw a line to create a corner at the bottom-left.
      ..lineTo(10,
          height) // Draw a line to create a curve from the bottom-left to the top-left corner.
      ..lineTo(0, height); // Draw a line to close the path.

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

// Custom clipper class to create a curved path from the bottom to the top of the container.
class MyCustomCliperFromBottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // The height of the curved path is set to 30% of the container's height.
    double height = size.height * 0.3;
    double width = size.width;

    // Create a Path object to define the curved shape.
    Path path = Path()
      ..moveTo(0, height) // Move to the starting point of the path.
      ..lineTo(0, size.height) // Draw a line to the bottom-left corner.
      ..lineTo(width, size.height) // Draw a line to the bottom-right corner.
      ..lineTo(width, height) // Draw a line to the top-right corner.
      ..lineTo(width - 10,
          height) // Draw a line to create a curve from the top-right to the bottom-right corner.
      ..lineTo(
          width - 10,
          size.height -
              10) // Draw a line to create a corner at the bottom-right.
      ..lineTo(
          10,
          size.height -
              10) // Draw a line to create a corner at the bottom-left.
      ..lineTo(10,
          height) // Draw a line to create a curve from the bottom-left to the top-left corner.
      ..lineTo(0, height); // Draw a line to close the path.

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
