import 'package:CUDI/routes.dart';
import 'package:CUDI/screens/components/icons/svg_icon.dart';
import 'package:CUDI/utils/provider.dart';
import 'package:CUDI/widgets/cudi_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../models/cart.dart';

class CartIcon extends StatefulWidget {
  const CartIcon({super.key});

  @override
  State<CartIcon> createState() => _CartIconState();
}

class _CartIconState extends State<CartIcon> {
  @override
  Widget build(BuildContext context) {
    // var userProvider = Provider.of<UserProvider>(context, listen: false);
    return Selector<UserProvider, List<Cart>>(
      selector: (context, u) => u.cart,
      builder: (context, cart, child) {
        // someValue를 직접 사용
        print(cart);
        return Stack(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.cart);
                },
                child: svgIcon('assets/icon/ico-line-cart-white-24px.svg')),
            cart.isNotEmpty? newBadge() : sb,
          ],
        );
      },
    );
  }
}