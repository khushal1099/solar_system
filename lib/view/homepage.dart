import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/controller/planet_provider.dart';
import 'package:solar_system/controller/theme_provider.dart';
import 'package:solar_system/model/planets_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController animcontroller;
  bool? isFav;

  @override
  void initState() {
    var provider = Provider.of<PlanetProvider>(context, listen: false);
    provider.loadData();

    animcontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
      lowerBound: 0,
      upperBound: 2 * pi,
    );
    animcontroller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Planets",
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context, listen: false).isDark
                ? Colors.white
                : Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.menu,
              color: Provider.of<ThemeProvider>(context,listen: false).isDark ? Colors.white : Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text("Settings"),
                  onTap: () {
                    Navigator.pushNamed(context, "setting");
                  },
                ),
                PopupMenuItem(
                  child: Text("Favorite"),
                  onTap: () {
                    Navigator.pushNamed(context, "favorite");
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: Consumer<ThemeProvider>(builder: (context, tp, child) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(tp.isDark
                  ? 'assets/images/BackgroundBlack.gif'
                  : 'assets/images/white bg.gif'),
              fit: BoxFit.cover,
            ),
          ),
          child: Consumer<PlanetProvider>(builder: (context, pp, child) {
            return FutureBuilder(
              future: pp.getData(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    Planets data = pp.planets[index];
                    return Center(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 60),
                            height: MediaQuery.sizeOf(context).height * 0.2,
                            width: MediaQuery.sizeOf(context).width * 0.75,
                            color: tp.isDark ? Colors.white : Colors.black,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data.name ?? "",
                                  style: TextStyle(
                                      color: tp.isDark
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "detail",
                                        arguments: data);
                                  },
                                  child: Text(
                                    "Know more ->",
                                    style: TextStyle(
                                      color: tp.isDark
                                          ? Colors.blue
                                          : Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 230),
                            child: InkWell(
                              onTap: () {
                                if (animcontroller.isAnimating) {
                                  animcontroller.stop();
                                } else {
                                  animcontroller.repeat();
                                }
                              },
                              child: AnimatedBuilder(
                                animation: animcontroller,
                                child: Image.asset(
                                  data.image ?? "",
                                  height: 180,
                                  width: 200,
                                ),
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle: animcontroller.value,
                                    child: child,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: pp.planets.length,
                );
              },
            );
          }),
        );
      }),
    );
  }

  @override
  void dispose() {
    animcontroller.dispose();
    super.dispose();
  }
}
