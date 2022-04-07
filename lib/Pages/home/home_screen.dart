import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:truthsoko/Pages/home/components/Product_bottom_sheet.dart';
import 'package:truthsoko/Pages/home/components/Search_text_field.dart';
import 'package:truthsoko/Pages/home/components/category.dart';
import 'package:truthsoko/src/Widget/color.dart';
import 'package:truthsoko/src/controllers/home_controller.dart';
import 'package:truthsoko/src/models/Product.dart';
import 'package:truthsoko/src/models/ProductItem.dart';
import 'package:truthsoko/Pages/deatils/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:truthsoko/Pages/home/components/Drawer.dart';
import '../../src/Widget/bezierContainer.dart';
import 'components/cart_details_view.dart';
import 'components/cart_short_view.dart';
import 'components/header.dart';
import 'components/product_card.dart';

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
  final User? user;
  const HomeScreen({Key? key, this.user}) : super(key: key);
  static _HomeScreen? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeScreen>();
  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static const double maxSlide = 225.0;
  final controller = HomeController();
  void _onVerticalGesture(DragUpdateDetails details) {
    if (details.primaryDelta! < -0.7) {
      controller.changeHomeState(HomeState.cart);
    } else if (details.primaryDelta! > 12) {
      controller.changeHomeState(HomeState.normal);
    }
  }

  static const double minDragStartEdge = 60;
  static const double maxDragStartEdge = maxSlide - 16;
  late AnimationController animationController;
  bool _canBeDragged = false;

  final drawer = Container(
    color: Colors.blue,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
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
    final height = MediaQuery.of(context).size.height;

    return WillPopScope(
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
        onTap: toggle,
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
                    child: SafeArea(
                      child: Scaffold(
                        appBar: AppBar(
                          leading: IconButton(
                            icon: const Icon(Icons.menu),
                            onPressed: () {
                              toggle();
                            },
                          ),
                          shadowColor: Global.green,
                          foregroundColor: Global.green,
                          backgroundColor: Global.yellow,
                          title: Text(
                            "Welcome ",
                            style: GoogleFonts.balooThambi2(),
                          ),
                        ),
                        body: Stack(
                          children: [
                            Container(
                                decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [Global.orange, Global.white],
                                        begin: Alignment.topCenter))),
                            SafeArea(
                              child: Column(
                                children: const [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SearchWidget(searchController: null),
                                  Categories()
                                ],
                              ),
                            ),
                            const ProductBottomSheet()
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
