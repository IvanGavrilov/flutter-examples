import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(SampleMultiNavColors());
}

class SampleMultiNavColors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => _RootController(), fenix: true);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: _Root(),
    );
  }
}

/// screen model
class ScreenModel {
  final String name;
  final int navKey;
  final MaterialColor colors;
  static const _shades = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
  get shades => _shades;
  ScreenModel({this.name, this.colors, this.navKey});
  Color getColorByShade(shade) => colors[shade];
}

/// screens models list
final screensData = <ScreenModel>[
  ScreenModel(name: 'red', colors: Colors.red, navKey: 1),
  ScreenModel(name: 'green', colors: Colors.green, navKey: 2),
  ScreenModel(name: 'blue', colors: Colors.blue, navKey: 3),
];

/// main controller
class _RootController extends GetxController {
  final navMenuIndex = 0.obs;

  ScreenModel get currentScreenModel => screensData[navMenuIndex()];
  Color get navMenuItemColor => currentScreenModel.colors;

  // store the pages stack.
  List<Widget> _pages;

  // get navigators.
  List<Widget> get menuPages => _pages ??= screensData.map((e) => _TabNav(e)).toList();

  // widget stuffs.
  List<BottomNavigationBarItem> get navMenuItems => screensData.map((e) => BottomNavigationBarItem(icon: Icon(Icons.widgets), label: e.name)).toList();

  void openDetails(int shade) {
    final model = currentScreenModel;
    Get.to(
      PageColorDetails(
        title: model.name,
        color: model.colors,
        shade: shade,
      ),
      transition: Transition.fade,
      id: model.navKey,
    );
  }
}

/// entry page (persistent)
class _Root extends GetView<_RootController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          children: controller.menuPages,
          index: controller.navMenuIndex(),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.navMenuIndex(),
          items: controller.navMenuItems,
          onTap: controller.navMenuIndex,
          selectedItemColor: controller.navMenuItemColor,
        ),
      ),
    );
  }
}

/// sub navigators.
class _TabNav extends GetView<_RootController> {
  final ScreenModel model;
  _TabNav(this.model);
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(model.navKey),
      onGenerateRoute: (settings) => MaterialPageRoute(builder: (_) => PageColorList(model: model)),
    );
  }
}

/// home of each subnavigator
class PageColorList extends StatelessWidget {
  final ScreenModel model;
  const PageColorList({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(model.name), backgroundColor: model.colors),
      body: ListView.builder(
        itemBuilder: (_, idx) {
          final shade = model.shades[idx];
          return Container(
            color: model.colors[shade],
            child: ListTile(
              title: Text(
                'shade [$shade]',
                style: Get.textTheme.bodyText2.copyWith(color: Colors.white, backgroundColor: Colors.black26),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Get.find<_RootController>().openDetails(shade),
            ),
          );
        },
        itemCount: model.shades.length,
      ),
    );
  }
}

/// details of colors.
class PageColorDetails extends StatelessWidget {
  final String title;
  final int shade;
  final MaterialColor color;

  const PageColorDetails({Key key, this.title, this.shade, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      backgroundColor: color[shade],
      body: Center(
        child: Text(
          '$title [$shade]',
          style: Get.textTheme.headline3.copyWith(
            color: Colors.white,
            backgroundColor: Colors.black45,
          ),
        ),
      ),
    );
  }
}
