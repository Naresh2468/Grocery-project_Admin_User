import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuController.dart';
import '../responsive.dart';
import '../services/utils.dart';
import '../widgets/Grid_Product.dart';
import '../widgets/header.dart';
import '../widgets/side_menu.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({Key? key}) : super(key: key);

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    return Scaffold(
      key: context.read<MenuController>().getgridscaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Column(
                    children: [
                      Header(
                        fct: () {
                          context
                              .read<MenuController>()
                              //.controlAddProductsMenu(); //Fixing Later
                              .controlProductsMenu();
                        },
                        title: 'All Products',
                      ),
                      Responsive(
                        mobile: GridProductWidget(
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                          crossAxisCount: size.width < 650 ? 2 : 4,
                          isInMain: false,
                        ),
                        desktop: GridProductWidget(
                          childAspectRatio: size.width < 1400
                              ? 0.8
                              : 1.05, // Task :- set the correct value for this view PAGE SIZE height && width  Customization
                          isInMain: false,
                          // crossAxisCount: size.width < 650 ? 2 : 4,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
