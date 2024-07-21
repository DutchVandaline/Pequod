import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:pequod/API/ApiServices.dart';
import 'package:pequod/Screens/AddHabitScreen.dart';
import 'package:pequod/Screens/ArchiveScreen.dart';
import 'package:pequod/Screens/DetailScreen.dart';
import 'package:pequod/Widgets/ClimateCrisisCurrentDateWidget.dart';
import 'package:pequod/Constants/Constants.dart';

class HabitScreen extends StatefulWidget {
  const HabitScreen({super.key});

  @override
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  List<Habit> habits = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Habit> fetchedHabits = await ApiServices.getHabit();
      setState(() {
        habits = fetchedHabits;
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onRefresh() {
    _loadHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: false,
        elevation: 0.0,
        shadowColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ArchiveScreen()));
              },
              icon: Icon(
                Icons.book_outlined,
                size: MediaQuery.of(context).size.width * 0.07,
                color: Theme.of(context).primaryColorLight,
              )),
          IconButton(
            onPressed: _onRefresh, // Refresh button action
            icon: Icon(
              Icons.refresh,
              size: MediaQuery.of(context).size.width * 0.07,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          if (habits.length < 8)
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddHabitScreen()));
                },
                icon: Icon(
                  Icons.add,
                  size: MediaQuery.of(context).size.width * 0.07,
                  color: Theme.of(context).primaryColorLight,
                )),
        ],
        title: const ClimateCrisisCurrentDateWidget(),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColorLight,
            ))
          : FutureBuilder(
              future: ApiServices.getHabitStatus(
                  Constants.changeDateFormat(DateTime.now())),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      "Error",
                      style: TextStyle(
                        fontFamily: 'FjallaOne',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  List<dynamic>? archiveData = snapshot.data;
                  if (archiveData != null && archiveData.isNotEmpty) {
                    List<int> habitIds = archiveData
                        .map<int>((item) => item['habit'] as int)
                        .toList();
                    return GameWidget(
                      game: MyGame(
                          context: context,
                          scaffoldBackgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          habits: habits,
                          habitIds: habitIds),
                    );
                  } else {
                    return const Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          fontFamily: 'FjallaOne',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    );
                  }
                } else {
                  return const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(
                        fontFamily: 'FjallaOne',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}

class MyGame extends Forge2DGame {
  final BuildContext context;
  final Color scaffoldBackgroundColor;
  final List<Habit> habits;
  final List<int> habitIds;

  MyGame(
      {required this.scaffoldBackgroundColor,
      required this.context,
      required this.habits,
      required this.habitIds})
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

    // Maximum is 8
    List<Habit> displayedHabits = habits.take(8).toList();

    for (int i = 0; i < displayedHabits.length; i++) {
      print(habitIds);
      Habit habit = displayedHabits[i];

      if(habitIds.contains(habit.id)){
        continue;
      }

      double yVelocity = (Random().nextInt(60) - 30).toDouble();
      int j = habit.id % 8;
      List<Vector2> position = [
        Vector2(120, 120),
        Vector2(320, 120),
        Vector2(170, -50),
        Vector2(310, -50),
        Vector2(130, -140),
        Vector2(320, -140),
        Vector2(150, -220),
        Vector2(300, -300),
      ];
      List<double> size = [
        MediaQuery.of(context).size.width * 0.25,
        MediaQuery.of(context).size.width * 0.3,
        MediaQuery.of(context).size.width * 0.35,
        MediaQuery.of(context).size.width * 0.25,
        MediaQuery.of(context).size.width * 0.25,
        MediaQuery.of(context).size.width * 0.3,
        MediaQuery.of(context).size.width * 0.3,
        MediaQuery.of(context).size.width * 0.25,
      ];
      List<Color> color = [
        Colors.red,
        Colors.amber,
        Colors.blue,
        Colors.teal,
        Colors.deepPurple,
        Colors.grey,
        Colors.orangeAccent,
        Colors.indigo,
      ];
      if (j == 0) {
        add(Circle(
            radius: size[j],
            position: position[i],
            color: color[j],
            text: habit.name,
            yVelocity: yVelocity,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            habitName: habit.name,
                            habitId: habit.id,
                          )));
            }));
      } else if (j == 1) {
        add(Rectangle(
            position: position[i],
            color: color[j],
            width: size[j],
            height: size[j],
            text: habit.name,
            yVelocity: yVelocity,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            habitName: habit.name,
                            habitId: habit.id,
                          )));
            }));
      } else if (j == 2) {
        add(Triangle(
          position: position[i],
          color: color[j],
          text: habit.name,
          yVelocity: yVelocity,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          habitName: habit.name,
                          habitId: habit.id,
                        )));
          },
          borderRadius: 10.0,
          size: size[i],
        ));
      } else if (j == 3) {
        add(Circle(
            radius: size[j],
            position: position[i],
            color: color[j],
            text: habit.name,
            yVelocity: yVelocity,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            habitName: habit.name,
                            habitId: habit.id,
                          )));
            }));
      } else if (j == 4) {
        add(Rectangle(
            position: position[i],
            color: color[j],
            width: size[j],
            height: size[j],
            text: habit.name,
            yVelocity: yVelocity,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            habitName: habit.name,
                            habitId: habit.id,
                          )));
            }));
      } else if (j == 5) {
        add(Triangle(
          position: position[i],
          color: color[j],
          text: habit.name,
          yVelocity: yVelocity,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailScreen(
                          habitName: habit.name,
                          habitId: habit.id,
                        )));
          },
          borderRadius: 10.0,
          size: size[i],
        ));
      } else if (j == 6) {
        add(Rectangle(
            position: position[i],
            color: color[j],
            width: size[j],
            height: size[j],
            text: habit.name,
            yVelocity: yVelocity,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            habitName: habit.name,
                            habitId: habit.id,
                          )));
            }));
      } else if (j == 7) {
        add(Circle(
            radius: size[j],
            position: position[i],
            color: color[j],
            text: habit.name,
            yVelocity: yVelocity,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            habitName: habit.name,
                            habitId: habit.id,
                          )));
            }));
      }
    }
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

  Circle({
    required this.radius,
    required this.text,
    required this.position,
    required Color color,
    required this.onTap,
    required this.yVelocity,
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
    final shape = CircleShape()..radius = radius;
    final fixtureDef =
        FixtureDef(shape, density: 1.0, restitution: 0.7, friction: 0.5);

    final bodyDef = BodyDef(
        position: position,
        type: BodyType.dynamic,
        linearVelocity: Vector2(yVelocity, 100));
    return world.createBody(bodyDef)..createFixture(fixtureDef);
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

  Rectangle(
      {required this.position,
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

    return world.createBody(bodyDef)..createFixture(fixtureDef);
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
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap();
  }
}

// Restrictions Ground, Walls coming up.
class Ground extends BodyComponent {
  final Vector2 gameSize;

  Ground({required this.gameSize});

  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(Vector2(0, gameSize.y), Vector2(gameSize.x, gameSize.y));
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)..createFixture(fixtureDef);
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
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class LeftWall extends BodyComponent {
  final Vector2 gameSize;

  LeftWall({required this.gameSize});

  @override
  Body createBody() {
    final shape = EdgeShape()..set(Vector2(0, 0), Vector2(0, gameSize.y));
    final fixtureDef = FixtureDef(shape, friction: 0.3);
    final bodyDef = BodyDef(userData: this, position: Vector2.zero());
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
