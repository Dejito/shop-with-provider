
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_using_provider/provider/auth.dart';
import 'package:shop_using_provider/provider/cart.dart';
import 'package:shop_using_provider/provider/orders.dart';
import 'package:shop_using_provider/provider/products.dart';
import 'package:shop_using_provider/screens/auth_screen.dart';
import 'package:shop_using_provider/screens/cart_screen.dart';
import 'package:shop_using_provider/screens/edit_product_screen.dart';
import 'package:shop_using_provider/screens/order_screen.dart';
import 'package:shop_using_provider/screens/products_detail_screen.dart';
import 'package:shop_using_provider/screens/products_overview_screen.dart';
import 'package:shop_using_provider/screens/user_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (context) => Auth()
      ),
      ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products('', [], '', ''),
          update: (ctx, auth, previousProducts ) =>
              Products(auth.token!, previousProducts!.items.isEmpty ? [] : previousProducts.items, auth.userId, '')
      ),
      ChangeNotifierProvider(
          create: (context) => Cart()
      ),
      ChangeNotifierProxyProvider<Auth, Orders>(
        create: (context) => Orders('', []),
        update: (ctx, auth, previousOrders) =>
            Orders(auth.token, previousOrders!.order.isEmpty ? [] : previousOrders.order),
          ),

    ],
      child: Consumer<Auth>(
        builder: (context, auth, _) =>
            MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: Colors.purple,
                primarySwatch: Colors.purple,
                colorScheme:  ColorScheme.fromSwatch(
                    accentColor: Colors.deepOrange),
                fontFamily: 'Lato',

              ),
              home:  auth.isAuth ? const ProductsOverviewScreen() : const AuthScreen(),
              routes: {
                ProductsOverviewScreen.id: (context) => const ProductsOverviewScreen(),
                ProductDetailScreen.id: (context) => const ProductDetailScreen(),
                CartScreen.pageID: (context) => const CartScreen(),
                OrdersScreen.id: (context) => const OrdersScreen(),
                UserProductsScreen.id: (context) => const UserProductsScreen(),
                EditProductScreen.id: (context) => const EditProductScreen(),
                AuthScreen.id: (context) => const AuthScreen(),
              },
            ),
      ),
    );
  }
}

