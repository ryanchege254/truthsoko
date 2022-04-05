import 'package:truthsoko/src/Widget/color.dart';
import 'package:truthsoko/src/controllers/home_controller.dart';
import 'package:truthsoko/src/models/Product.dart';
import 'package:truthsoko/src/models/ProductItem.dart';
import 'package:truthsoko/Pages/deatils/details_screen.dart';
import 'package:flutter/material.dart';

import 'components/cart_details_view.dart';
import 'components/cart_short_view.dart';
import 'components/header.dart';
import 'components/product_card.dart';

// Today i will show you how to implement the animation
// So starting project comes with the UI
// Run the app

class HomeScreen extends StatelessWidget {
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
                        AnimatedPositioned(
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
                        ),
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
}
