import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(name: '/plus', page: () => PlusPage(),),
        GetPage(name: '/minus', page: () => MinusPage(), transition: Transition.zoom,)
      ],
      unknownRoute: GetPage(
        name: '/',
        page: () => HomePage(),
      ),
    );
  }
}

void main() => runApp(MyApp());

class Controller extends GetxController {
  var count = 0.obs;
}

class HomePage extends StatelessWidget {
  @override
  Widget build(context) {
    final Controller c = Get.put(Controller());
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text("Count = ${c.count}"))),
      body: Row(
        children: [
          TextButton(child: Text("+"), onPressed: () => Get.toNamed('/plus')),
          TextButton(child: Text("-"), onPressed: () => Get.toNamed('/minus')),
        ],
      ),
    );
  }
}

class PlusPage extends StatelessWidget {
  @override
  Widget build(context) {
    Controller c = Get.find();
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text("Count = ${c.count}"))),
      body: TextButton(child: Text("+"), onPressed: () => c.count++),
    );
  }
}

class MinusPage extends StatelessWidget {
  @override
  Widget build(context) {
    Controller c = Get.find();
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text("Count = ${c.count}"))),
      body: TextButton(child: Text("-"), onPressed: () => c.count--),
    );
  }
}
