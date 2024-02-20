import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solar_system/controller/theme_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
        backgroundColor: Colors.transparent,
        title: Text(
          "Settings",
          style: TextStyle(color: Provider.of<ThemeProvider>(context,listen: false).isDark ? Colors.white : Colors.black,),
        ),
        centerTitle: true,
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
            child: Container(
              margin: EdgeInsets.only(bottom: 500),
              height: MediaQuery.sizeOf(context).height * 0.1,
              width: MediaQuery.sizeOf(context).width * 1,
              color: tp.isDark ? Colors.white : Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      "Thememode",
                      style: TextStyle(fontSize: 25,color: tp.isDark ? Colors.black : Colors.white,),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Switch(
                        value: tp.isDark,
                        onChanged: (val) {
                          tp.changeTheme(val);
                        }),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
