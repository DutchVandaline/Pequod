import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:pequod/Screens/AddHabitScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisCurrentDateWidget.dart';
import 'VerificationScreen.dart';

class HabitScreen extends StatelessWidget {
  const HabitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.book_outlined,
                size: 35.0,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddHabitScreen()));
              },
              icon: const Icon(
                Icons.add,
                size: 35.0,
              )),
        ],
        title: const ClimateCrisisCurrentDateWidget(),
      ),
      body: GameWidget(
          game: MyGame(
              context: context,
              scaffoldBackgroundColor:
              Theme
                  .of(context)
                  .scaffoldBackgroundColor)),
    );
  }
}

class MyGame extends Forge2DGame {
  final BuildContext context;
  final Color scaffoldBackgroundColor;

  MyGame({required this.scaffoldBackgroundColor, required this.context})
      : super(gravity: Vector2(0, 80));

  @override
  Color backgroundColor() => scaffoldBackgroundColor;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Vector2 gameSize = Vector2(size.x, size.y);
    add(Ground(gameSize: gameSize));
    add(LeftWall(gameSize: gameSize));
    add(RightWall(gameSize: gameSize));

    add(Circle(
        radius: 80.0,
        position: Vector2(170, -200),
        color: Colors.teal,
        text: 'Rectangle 2',
        yVelocity: (Random().nextInt(60) - 30).toDouble(),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const VerificationScreen(
                    habitName: "Habit 3",
                  )));
        }));
    add(Circle(
        radius: 100.0,
        text: "Habit 3",
        position: Vector2(100, 0),
        color: Colors.red,
        yVelocity: (Random().nextInt(60) - 30).toDouble(),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const VerificationScreen(
                    habitName: "Habit 3",
                  )));
        }));
    add(Rectangle(
        position: Vector2(320, 0),
        color: Colors.blue,
        width: 180,
        height: 180,
        text: "Habit2",
        yVelocity: (Random().nextInt(60) - 30).toDouble(),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const VerificationScreen(
                    habitName: "Habit 2",
                  )));
        }));
    add(Triangle(
      position: Vector2(300, -200),
      color: Colors.amber,
      text: "Habit2",
      yVelocity: (Random().nextInt(60) - 30).toDouble(),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                const VerificationScreen(
                  habitName: "Habit 2",
                )));
      },
      borderRadius: 10.0,
      size: 150.0,
    ));
    add(Triangle(
      position: Vector2(100, -200),
      color: Colors.deepPurple,
      text: "Habit2",
      yVelocity: (Random().nextInt(60) - 30).toDouble(),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                const VerificationScreen(
                  habitName: "Habit 2",
                )));
      },
      borderRadius: 10.0,
      size: 150.0,
    ));
    add(Rectangle(
        position: Vector2(320, -300),
        color: Colors.grey,
        width: 130,
        height: 130,
        text: "Habit2",
        yVelocity: (Random().nextInt(60) - 30).toDouble(),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                  const VerificationScreen(
                    habitName: "Habit 2",
                  )));
        }));
  }
}

class Circle extends BodyComponent with TapCallbacks {
  @override
  final Vector2 position;
  @override
  final Paint paint;
  final String text;
  final Function onTap;
  final double radius;
  final double yVelocity;

  Circle({required this.radius,
    required this.text,
    required this.position,
    required Color color,
    required this.onTap,
    required this.yVelocity,
  })
      : paint = Paint() {
    paint.color = color;
    paint.style = PaintingStyle.fill;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontFamily: 'FjallaOne'),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 2 * radius,
    );
    final offset = Offset(-textPainter.width / 2, -textPainter.height / 2);
    textPainter.paint(canvas, offset);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  Body createBody() {
    final shape = CircleShape()
      ..radius = radius;
    final fixtureDef =
    FixtureDef(shape, density: 1.0, restitution: 0.7, friction: 0.5);

    final bodyDef = BodyDef(
        position: position,
        type: BodyType.dynamic,
        linearVelocity: Vector2(yVelocity, 100));
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef);
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
  }
}

class Rectangle extends BodyComponent with TapCallbacks {
  @override
  final Vector2 position;
  final double width;
  final double height;
  final Function onTap;
  final Paint paint;
  final String text;
  final double yVelocity;

  Rectangle({required this.position,
    required this.width,
    required this.height,
    required this.text,
    required Color color,
    required this.yVelocity,
    required this.onTap})
      : paint = Paint() {
    paint.color = color;
    paint.style = PaintingStyle.fill;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontFamily: 'FjallaOne'),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: width,
    );
    final offset = Offset(-textPainter.width / 2, -textPainter.height / 2);
    textPainter.paint(canvas, offset);
  }

  @override
  Body createBody() {
    final shape = PolygonShape();
    final halfWidth = width / 2;
    final halfHeight = height / 2;
    shape.setAsBox(halfWidth, halfHeight, Vector2.zero(), 0);

    final fixtureDef =
    FixtureDef(shape, density: 1.0, restitution: 0.7, friction: 0.5);
    final bodyDef = BodyDef(
        position: position,
        type: BodyType.dynamic,
        linearVelocity: Vector2(yVelocity, 30));

    return world.createBody(bodyDef)
      ..createFixture(fixtureDef);
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
  }
}

class Triangle extends BodyComponent with TapCallbacks {
  @override
  final Vector2 position;
  @override
  final Paint paint;
  final String text;
  final Function onTap;
  final double size;
  final double borderRadius;
  final double yVelocity;

  Triangle({
    required this.size,
    required this.borderRadius,
    required this.text,
    required this.position,
    required Color color,
    required this.yVelocity,
    required this.onTap,
  }) : paint = Paint() {
    paint.color = color;
    paint.style = PaintingStyle.fill;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final textSpan = TextSpan(
      text: text,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontFamily: 'FjallaOne'),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 2 * size,
    );
    final offset = Offset(-textPainter.width / 2, textPainter.height / 3);
    textPainter.paint(canvas, offset);

    canvas.restore();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }

  @override
  Body createBody() {
    final shape = PolygonShape();
    final halfSize = size / 2;
    final vertices = [
      Vector2(0, -halfSize),
      Vector2(halfSize, halfSize),
      Vector2(-halfSize, halfSize),
    ];
    shape.set(vertices);

    final fixtureDef =
    FixtureDef(shape, density: 0.2, restitution: .7, friction: 0.5);
    final bodyDef = BodyDef(
        position: position,
        type: BodyType.dynamic,
        linearVelocity: Vector2(yVelocity, 70));
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef);
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
  }
}

//Restrictions Ground, Walls coming up.
class Ground extends BodyComponent {
  final Vector2 gameSize;

  Ground({required this.gameSize});

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(Vector2(0, gameSize.y), Vector2(gameSize.x, gameSize.y));
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef);
  }
}

class RightWall extends BodyComponent {
  final Vector2 gameSize;

  RightWall({required this.gameSize});

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(Vector2(gameSize.x, 0), Vector2(gameSize.x, gameSize.y));
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef);
  }
}

class LeftWall extends BodyComponent {
  final Vector2 gameSize;

  LeftWall({required this.gameSize});

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(Vector2(0, 0), Vector2(0, gameSize.y));
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)
      ..createFixture(fixtureDef);
  }
}
