//
// import 'package:flutter/material.dart';
//
// enum ShapeType { circle, square, triangle }
//
// class Particle {
//   Offset position;
//   Offset velocity;
//   Color color;
//   ShapeType shape;
//   // Add other properties like size, lifespan, etc.
//
//   Particle({required this.position, required this.velocity, required this.color, required this.shape});
// }
//
// class FireworksAnimation extends StatefulWidget {
//   const FireworksAnimation({super.key});
//
//   @override
//   State<FireworksAnimation> createState() => _FireworksAnimationState();
// }
//
// class _FireworksAnimationState extends State<FireworksAnimation> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   List<Particle> _particles = []; // List to hold your particle objects
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3), // Adjust duration as needed
//       vsync: this,
//     )..addListener(() {
//       setState(() {
//         _updateParticles(); // Update particle positions and states
//       });
//     })..addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         // Optionally reset or restart the animation
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// class FireworksPainter extends CustomPainter {
//   final List<Particle> particles;
//
//   FireworksPainter(this.particles);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     for (var particle in particles) {
//       final paint = Paint()..color = particle.color;
//
//       switch (particle.shape) {
//         case ShapeType.circle:
//           canvas.drawCircle(particle.position, 5.0, paint); // Adjust size
//           break;
//         case ShapeType.square:
//           canvas.drawRect(Rect.fromCenter(center: particle.position, width: 10.0, height: 10.0), paint); // Adjust size
//           break;
//         case ShapeType.triangle:
//           final path = Path();
//           path.moveTo(particle.position.dx, particle.position.dy - 5);
//           path.lineTo(particle.position.dx - 5, particle.position.dy + 5);
//           path.lineTo(particle.position.dx + 5, particle.position.dy + 5);
//           path.close();
//           canvas.drawPath(path, paint);
//           break;
//       // Add cases for other custom shapes or paths
//       }
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true; // Or optimize by checking if particles have changed
//   }
// }