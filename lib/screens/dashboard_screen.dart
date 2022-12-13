import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gstore_admin_panel/Inner_Screens/AddNewProduct.dart';
import 'package:gstore_admin_panel/services/global_method.dart';
import 'package:gstore_admin_panel/services/utils.dart';
import 'package:gstore_admin_panel/widgets/Grid_Product.dart';
import 'package:gstore_admin_panel/widgets/Product_Widget.dart';
import 'package:gstore_admin_panel/widgets/buttons.dart';
import 'package:gstore_admin_panel/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../consts/constants.dart';
import '../controllers/MenuController.dart';
import '../responsive.dart';
import '../widgets/Orders/orders_list.dart';
import '../widgets/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    Color color = Utils(context).color;
    return SafeArea(
      child: SingleChildScrollView(
        //controller: ScrollController(),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(
              fct: () {
                context.read<MenuController>().controlDashboarkMenu();
              },
              title: 'DashBoard',
            ),
            const SizedBox(height: 20),
            TextWidget(
              text: 'Latest Products',
              color: Color.fromARGB(255, 57, 224, 20),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ButtonsWidget(
                    onPressed: () {},
                    text: 'View All',
                    icon: Icons.store,
                    backgroundColor: Colors.blue,
                  ),
                  Spacer(),
                  ButtonsWidget(
                    onPressed: () {
                      // GlobalMethods.navigateTo(ctx: context, routeName: UploadProductForm.routeName);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UploadProductForm()));
                    },
                    text: 'Add Product',
                    icon: Icons.add_box,
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  //flex: 5,
                  child: Column(
                    children: [
                      Responsive(
                        mobile: GridProductWidget(
                          childAspectRatio:
                              size.width < 650 && size.width > 350 ? 1.1 : 0.8,
                          crossAxisCount: size.width < 650 ? 2 : 4,
                        ),
                        desktop: GridProductWidget(
                          childAspectRatio: size.width < 1400
                              ? 0.8
                              : 1.05, // Task :- set the correct value for this view PAGE SIZE height && width  Customization
                          // crossAxisCount: size.width < 650 ? 2 : 4,
                        ),
                      ),
                      const OrdersList(),

                      // MyProductsHome(),
                      // GridView.builder(
                      //   physics: NeverScrollableScrollPhysics(),
                      //   shrinkWrap: true,
                      //   itemCount: 4,
                      //   gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      //     crossAxisCount: size.width < 650 ? 2:4,
                      //     childAspectRatio: size.width < 1400 ?0.9 :1.08,
                      //     crossAxisSpacing: defaultPadding,
                      //     mainAxisSpacing: defaultPadding,
                      //     ),
                      //      itemBuilder: (context, index)
                      // {
                      //   return ProductWidget();
                      // }),

                      // SizedBox(height: defaultPadding),
                      // OrdersScreen(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
