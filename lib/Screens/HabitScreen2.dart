import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pequod/Screens/VerificationScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisTextWidget.dart';

class HabitScreen2 extends StatelessWidget {
  const HabitScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: ClimateChangeTextWidget("Habit"),
      ),
      body: GameWidget(
        game: FallingContainerGame(
          context: context,
          scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}

class FallingContainerGame extends FlameGame with TapDetector {
  final BuildContext context;
  final Color scaffoldBackgroundColor;

  FallingContainerGame(
      {required this.context, required this.scaffoldBackgroundColor});

  final List<Shape> shapes = [];

  @override
  Color backgroundColor() => scaffoldBackgroundColor;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    shapes.addAll([
      CircleShape(
          context: context,
          radius: 80,
          x: 100,
          y: -300,
          screenSize: size,
          color: Colors.red,
          text: 'Circle'),
      RectangleShape(
          context: context,
          height: 100,
          width: 350,
          x: 10,
          y: -200,
          screenSize: size,
          color: Colors.blue,
          borderRadius: 20.0,
          text: 'Rectangle 2'),
      RectangleShape(
          context: context,
          height: 100,
          width: 300,
          x: 20,
          y: 0,
          screenSize: size,
          color: Colors.green,
          borderRadius: 20.0,
          text: 'Rectangle'),
    ]);
    shapes.forEach(add);
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (var shape in shapes) {
      if (!shape.isResting || shouldFall(shape)) {
        shape.applyGravity(dt);
        shape.isResting = false;
      }
    }
    checkCollisions();
  }

  bool shouldFall(Shape shape) {
    bool supported = false;
    for (var other in shapes) {
      if (shape != other && shape.y + shape.height == other.y) {
        supported = true;
        break;
      }
    }
    return !supported;
  }

  void checkCollisions() {
    for (var i = 0; i < shapes.length; i++) {
      for (var j = 0; j < shapes.length; j++) {
        if (i != j && shapes[i].checkCollision(shapes[j])) {
          shapes[i].isResting = true;
          break;
        }
      }
    }
  }
}

abstract class Shape extends PositionComponent with TapCallbacks {
  final BuildContext context;
  double velocity = 0;
  bool isResting = false;
  Vector2 screenSize;
  final Paint paint;
  final String text;
  final TextPainter textPainter;
  final TextStyle textStyle;

  Shape({
    required this.context,
    required this.screenSize,
    required Color color,
    required this.text,
  })  : paint = Paint()..color = color,
        textStyle = const TextStyle(color: Colors.white, fontSize: 20),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        ),
        super();

  void applyGravity(double dt) {
    if (!isResting) {
      if (y + height < screenSize.y) {
        velocity += 980 * dt;
        y += velocity * dt;
      } else {
        y = screenSize.y - height;
        velocity = 0;
        isResting = true;
      }
    }
  }

  @override
  bool checkCollision(Shape other);

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderText(canvas);
  }

  void renderText(Canvas canvas) {
    textPainter.text = TextSpan(text: text, style: textStyle);
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.x - textPainter.width) / 2,
        (size.y - textPainter.height) / 2,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => VerificationScreen(habitName: text)),
    );
  }
}

class CircleShape extends Shape {
  final double radius;

  CircleShape({
    required BuildContext context,
    required this.radius,
    required double x,
    required double y,
    required Vector2 screenSize,
    required Color color,
    required String text,
  }) : super(
            context: context,
            screenSize: screenSize,
            color: color,
            text: text) {
    this.x = x;
    this.y = y;
    size = Vector2.all(radius * 2);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(Offset(radius, radius), radius, paint);
    renderText(canvas);
  }

  @override
  bool checkCollision(Shape other) {
    if (x < other.x + other.width &&
        x + width > other.x &&
        y + height > other.y &&
        y < other.y + other.height) {
      if (y + height - velocity * 0.5 <= other.y) {
        y = other.y - height;
        velocity = 0;
        return true;
      }
    }
    return false;
  }
}

class RectangleShape extends Shape {
  final double height;
  final double width;
  final double borderRadius;

  RectangleShape({
    required BuildContext context,
    required this.height,
    required this.width,
    required double x,
    required double y,
    required Vector2 screenSize,
    required Color color,
    required String text,
    this.borderRadius = 0.0, // Adding a default value for borderRadius
  }) : super(
            context: context,
            screenSize: screenSize,
            color: color,
            text: text) {
    this.x = x;
    this.y = y;
    size = Vector2(width, height);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // Create a rounded rectangle
    final RRect rrect = RRect.fromRectAndRadius(
      size.toRect(),
      Radius.circular(borderRadius),
    );
    // Draw the rounded rectangle
    canvas.drawRRect(rrect, paint);
    renderText(canvas);
  }

  @override
  bool checkCollision(Shape other) {
    if (x < other.x + other.width &&
        x + width > other.x &&
        y + height > other.y &&
        y < other.y + other.height) {
      if (y + height - velocity * 0.5 <= other.y) {
        y = other.y - height;
        velocity = 0;
        return true;
      }
    }
    return false;
  }
}
