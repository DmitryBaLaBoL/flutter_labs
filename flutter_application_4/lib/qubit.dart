import 'dart:math';

class Qubit {
  //static const double gravitationalConstant = 6.67430e-11;

  double calculateAcceleration(double mass, double speed) {
    return (mass * pow(speed,2))/2;
  }
}

class QubitState {
  final double mass;
  final double radius;

  QubitState({required this.mass, required this.radius});
}