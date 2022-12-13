import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gstore_admin_panel/services/utils.dart';
import 'package:gstore_admin_panel/widgets/text_widget.dart';

import '../Inner_Screens/edit_prod.dart';
import '../services/global_method.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

///*********show the Product in the dash broad screen */
class _ProductWidgetState extends State<ProductWidget> {
  // bool _isLoading = false;
  String title = '';
  String productCat = '';
  String? imageUrl;
  String price = '0.0';
  double salePrice = 0.0;
  bool isOnSale = false;
  bool isPiece = false;

  @override
  void initState() {
    getProductsData();
    super.initState();
  }

  Future<void> getProductsData() async {
    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.id)
          .get();
      if (productsDoc == null) {
        return;
      } else {
        setState(() {
          title = productsDoc.get('title');
          productCat = productsDoc.get('productCategroyName');
          imageUrl = productsDoc.get('imageAsset');
          price = productsDoc.get('price');
          salePrice = productsDoc.get('salePrice');
          isOnSale = productsDoc.get('isOnSale');
          isPiece = productsDoc.get('isPiece');
        });
      }
    } catch (error) {
      GlobalMethods.ErrorDialog(subtitle: '$error', context: context);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final color = Utils(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditProductScreen(
                  id: widget.id,
                  title: title,
                  price: price,
                  salePrice: salePrice,
                  productCat: productCat,
                  imageUrl: imageUrl == null
                      ? 'asset/images/DisplayProduct/Apple2.png'
                      : imageUrl!,
                  isOnSale: isOnSale,
                  isPiece: isPiece,
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 3,
                        child: Image.asset(
                          //Focus Changes
                          imageUrl == null
                              ? 'asset/images/DisplayProduct/Apple2.png'
                              : imageUrl!,
                          fit: BoxFit.fill,
                          height: size.width * 0.12,
                        )),
                    const Spacer(),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {},
                          child: Text('Edit'),
                          value: 1,
                        ),
                        PopupMenuItem(
                          onTap: () {},
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                          value: 2,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    TextWidget(
                      text: isOnSale
                          ? '\Rs:-${salePrice.toStringAsFixed(2)}'
                          : '\RS:-$price',
                      color: color,
                      textSize: 18,
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Visibility(
                      visible: isOnSale,
                      child: Text(
                        '\RS:-$price',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: color,
                        ),
                      ),
                    ),
                    const Spacer(),
                    TextWidget(
                        text: isPiece ? 'Piece' : '1Kg',
                        color: color,
                        textSize: 18),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(
                  // text: 'Apple',
                  text: title,
                  color: Colors.red,
                  textSize: 22,
                  isTitle: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
