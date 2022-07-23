import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:truthsoko/Pages/About/About.dart';
import 'package:truthsoko/Pages/Categories/Category_screen.dart';
import 'package:truthsoko/Pages/Profile/profile.dart';
import 'package:truthsoko/Pages/home/components/Product_bottom_sheet.dart';
import 'package:truthsoko/Pages/home/components/Search_text_field.dart';
import 'package:truthsoko/Pages/home/components/favorites.dart';
import 'package:truthsoko/Pages/home/components/recent.dart';
import 'package:truthsoko/Utils/Auth/Auth.dart';
import 'package:truthsoko/Pages/screen_changeProvider.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/Pages/home/components/Drawer.dart';
import '../Notification/Notification.dart';
import '../../src/Widget/header.dart';
import 'components/tabs.dart';

// Today i will show you how to implement the animation
// So starting project comes with the UI
// Run the app
/*class HomeScreen extends StatelessWidget {
  final controller = HomeController();

  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Container(
          color: const Color(0xFFEAEAEA),
          child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                return LayoutBuilder(
                  builder: (context, BoxConstraints constraints) {
                    return Stack(
                      children: [
                        Positioned(
                            top: -height * .15,
                            right: -MediaQuery.of(context).size.width * .4,
                            child: const BezierContainer()),
                        AnimatedPositioned(
                          duration: Global.panelTransition,
                          top: controller.homeState == HomeState.normal
                              ? Global.headerHeight
                              : -(constraints.maxHeight -
                                  Global.cartBarHeight * 2 -
                                  Global.headerHeight),
                          left: 0,
                          right: 0,
                          height: constraints.maxHeight -
                              Global.headerHeight -
                              Global.cartBarHeight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Global.defaultPadding),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    Global.defaultPadding * 1.5),
                                bottomRight: Radius.circular(
                                    Global.defaultPadding * 1.5),
                              ),
                            ),
                            child: GridView.builder(
                              itemCount: demo_products.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                mainAxisSpacing: Global.defaultPadding,
                                crossAxisSpacing: Global.defaultPadding,
                              ),
                              itemBuilder: (context, index) => ProductCard(
                                product: demo_products[index],
                                press: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          const Duration(milliseconds: 500),
                                      reverseTransitionDuration:
                                          const Duration(milliseconds: 500),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          FadeTransition(
                                        opacity: animation,
                                        child: DetailsScreen(
                                          product: demo_products[index],
                                          onProductAdd: () {
                                            controller.addProductToCart(
                                                demo_products[index]);
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        // Card Panel
                        /*AnimatedPositioned(
                          duration: Global.panelTransition,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: controller.homeState == HomeState.normal
                              ? Global.cartBarHeight
                              : (constraints.maxHeight - Global.cartBarHeight),
                          child: GestureDetector(
                            onVerticalDragUpdate: _onVerticalGesture,
                            child: Container(
                              padding:
                                  const EdgeInsets.all(Global.defaultPadding),
                              color: const Color(0xFFEAEAEA),
                              alignment: Alignment.topLeft,
                              child: AnimatedSwitcher(
                                duration: Global.panelTransition,
                                child: controller.homeState == HomeState.normal
                                    ? CardShortView(controller: controller)
                                    : CartDetailsView(controller: controller),
                              ),
                            ),
                          ),
                        ),*/
                        const Categories(),

                        // Header
                        AnimatedPositioned(
                          duration: Global.panelTransition,
                          top: controller.homeState == HomeState.normal
                              ? 0
                              : -Global.headerHeight,
                          right: 0,
                          left: 0,
                          height: Global.headerHeight,
                          child: const HomeHeader(),
                        ),
                      ],
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}*/
class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);
  static _HomeScreen? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeScreen>();
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  static const double maxSlide = 225.0;

  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  late AnimationController animationController;
  late AnimationController tabController;
  late Animation animation;

  bool _canBeDragged = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 350));
  }

  @override
  void dispose() {
    animationController.dispose();
    tabController.dispose();
    super.dispose();
  }

  void close() => animationController.reverse();

  void open() => animationController.forward();
  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();
  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragCloseFromRight = animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    //I have no idea what it means, copied from Drawer
    double _kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= _kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      close();
    } else {
      open();
    }
  }

  @override
  Widget build(BuildContext context) {
    //final height = MediaQuery.of(context).size.height;
    tabController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    animation = Tween(begin: 0.0, end: 0.0).animate(CurvedAnimation(
      parent: tabController,
      curve: Curves.easeInOut,
    ));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ScreenChange()),
        ChangeNotifierProvider.value(value: UserRepository.instance()),
      ],
      child: WillPopScope(
        onWillPop: () async {
          if (animationController.isCompleted) {
            close();
            return false;
          }
          return true;
        },
        child: GestureDetector(
          onHorizontalDragStart: _onDragStart,
          onHorizontalDragUpdate: _onDragUpdate,
          onHorizontalDragEnd: _onDragEnd,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              double animValue = animationController.value;
              final slideAmount = maxSlide * animValue;
              final contentScale = 1.0 - (0.3 * animValue);
              return Stack(
                children: [
                  const DrawerWidget(),
                  Transform(
                    transform: Matrix4.identity()
                      ..translate(slideAmount)
                      ..scale(contentScale, contentScale),
                    alignment: Alignment.centerLeft,
                    child: Consumer<ScreenChange>(
                        builder: (context, ScreenChange change, child) {
                      switch (change.state) {
                        case PageState.homescreen:
                          return Home(
                              user: widget.user,
                              controller: tabController,
                              animation: animation);
                        case PageState.categories:
                          return CategoryScreen(user: widget.user);
                        case PageState.notification:
                          return NotificationScreen(user: widget.user);
                        case PageState.about:
                          return const AboutScreen();
                        case PageState.account:
                          return ProfileScreen(
                            user: widget.user,
                          );
                        default:
                      }
                      return Center(
                          child: Text("Something went wrong",
                              style: GoogleFonts.abel(
                                fontSize: 20,
                              )));
                    }),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final User user;
  final AnimationController controller;
  final Animation animation;
  const Home(
      {Key? key,
      required this.controller,
      required this.animation,
      required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return ChangeNotifierProvider.value(
        value: TabSelected(),
        child: Scaffold(
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                        onTap: () => _HomeScreen().toggle(),
                        child: const HomeHeader()),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Expanded(child: SearchWidget(searchController: null)),
                  const SizedBox(height: 8),
                  Tabs(
                    controller: controller,
                  ),
                  const SizedBox(height: 8),
                  //const Favorites(),
                  AnimatedBuilder(
                    builder: (context, child) {
                      return Transform(
                        transform: Matrix4.translationValues(
                            animation.value, 0.0, 0.0),
                        child: Consumer<TabSelected>(
                            builder: (context, TabSelected tabselected, child) {
                          switch (tabselected.selected) {
                            case TabWidget.Favorites:
                              return Favorites(
                                user: user,
                              );
                            case TabWidget.Recent:
                              return Recent(user: user);
                              // ignore: dead_code
                              break;
                            case TabWidget.New:
                              return Recent(
                                user: user,
                              );
                          }
                          //return Container();
                        }),
                      );
                    },
                    animation: controller,
                  ),
                ],
              ),
              ProductBottomSheet(
                user: user,
              )
            ],
          ),
        ));
  }
}
