import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/controller/planet_provider.dart';
import 'package:solar_system/controller/theme_provider.dart';
import 'package:solar_system/model/planets_model.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with TickerProviderStateMixin {
  late AnimationController animcontroller;

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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Provider.of<ThemeProvider>(context,listen: false).isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          "Favorite Planets",
          style: TextStyle(
            color: Provider.of<ThemeProvider>(context,listen: false).isDark ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Consumer<ThemeProvider>(
        builder: (context,tp,child) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:AssetImage(tp.isDark
                    ? 'assets/images/BackgroundBlack.gif'
                    : 'assets/images/white bg.gif'),
                fit: BoxFit.cover,
              ),
            ),
            child: Consumer<PlanetProvider>(
              builder: (context, pp, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    Planets pl = pp.favoriteplanet[index];
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
                                  pl.name ?? "",
                                  style: TextStyle(
                                      fontSize: 25, fontWeight: FontWeight.bold,color: tp.isDark ? Colors.black : Colors.white,),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "detail",
                                        arguments: pl);
                                  },
                                  child: Text("Know more ->",style: TextStyle(color: tp.isDark ? Colors.blue : Colors.blue,),),
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
                                  pl.image ?? "",
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
                          Positioned(
                            right: 40,
                            top: 60,
                            child: IconButton(
                              onPressed: () {
                                pp.removeFavorite(index);
                                pp.saveData();
                              },
                              icon: Icon(Icons.delete,color: tp.isDark ? Colors.black : Colors.white,),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: pp.favoriteplanet.length,
                );
              },
            ),
          );
        }
      ),
    );
  }

  @override
  void dispose() {
    animcontroller.dispose();
    super.dispose();
  }
}
