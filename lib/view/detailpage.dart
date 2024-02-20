import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/controller/planet_provider.dart';
import 'package:solar_system/controller/theme_provider.dart';
import 'package:solar_system/model/planets_model.dart';

class DetailsPage extends StatefulWidget {
  DetailsPage({
    super.key,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Planets planetmodel;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
      lowerBound: 0,
      upperBound: 2 * pi,
    );
    animationController.repeat();
    var provider = Provider.of<PlanetProvider>(context, listen: false);
    provider.loadData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    planetmodel = ModalRoute.of(context)!.settings.arguments as Planets;
    super.didChangeDependencies();
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
            color:
            Provider.of<ThemeProvider>(context,listen: false).isDark ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          Consumer<PlanetProvider>(
            builder: (context, pp, child) {
              return Padding(
                padding: const EdgeInsets.only(left: 300, top: 10),
                child: IconButton(
                  onPressed: () {
                    if (pp.isFavorite(planetmodel)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Already in favorites'),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Added to favorites'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    pp.addFavorite(planetmodel);
                    pp.saveData();
                  },
                  icon: (pp.isFavorite(planetmodel))
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border_outlined),
                  color: Colors.grey,
                ),
              );
            },
          ),
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
          child: Center(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 250),
                  height: MediaQuery.sizeOf(context).height * 0.7,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(
                    color: tp.isDark ? Colors.white : Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 150, left: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Name:- ",
                                style:
                                    TextStyle(fontSize: 23, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                planetmodel.name ?? "",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color:
                                      tp.isDark ? Colors.black : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Position:-",
                                style:
                                    TextStyle(fontSize: 23, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                planetmodel.position ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22,color:
                                tp.isDark ? Colors.black : Colors.white,),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Type:-",
                                style:
                                    TextStyle(fontSize: 23, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                planetmodel.type ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22,color:
                                tp.isDark ? Colors.black : Colors.white,),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Radius:-",
                                style:
                                    TextStyle(fontSize: 23, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                planetmodel.radius ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22,color:
                                tp.isDark ? Colors.black : Colors.white,),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 165),
                            child: Text(
                              "Orbital_Period:-",
                              style:
                                  TextStyle(fontSize: 23, color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            planetmodel.orbitalPeriod ?? "",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22,color:
                            tp.isDark ? Colors.black : Colors.white,),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Gravity:-",
                                style:
                                    TextStyle(fontSize: 23, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                planetmodel.gravity ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22,color:
                                tp.isDark ? Colors.black : Colors.white,),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Velocity:-",
                                style:
                                    TextStyle(fontSize: 23, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                planetmodel.velocity ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22,color:
                                tp.isDark ? Colors.black : Colors.white,),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Distance:-",
                                style:
                                    TextStyle(fontSize: 23, color: Colors.grey),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                planetmodel.distance ?? "",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22,color:
                                tp.isDark ? Colors.black : Colors.white,),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 193, bottom: 5),
                            child: Text(
                              "Description:-",
                              style:
                                  TextStyle(fontSize: 23, color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10, bottom: 10),
                            child: Text(
                              planetmodel.description ?? "",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22,color:
                              tp.isDark ? Colors.black : Colors.white,),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 340),
                  child: InkWell(
                    onTap: () {
                      if (animationController.isAnimating) {
                        animationController.stop();
                      } else {
                        animationController.repeat();
                      }
                    },
                    child: AnimatedBuilder(
                      animation: animationController,
                      child: Image.asset(
                        planetmodel.image ?? "",
                        height: MediaQuery.sizeOf(context).height * 0.9,
                        width: MediaQuery.sizeOf(context).width * 0.9,
                      ),
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: animationController.value,
                          child: child,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
