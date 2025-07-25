import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ambrosia_ayurved/cosmetics/common_widgets/snackbar.dart';
import 'package:ambrosia_ayurved/cosmetics/thankyou/thankyou.dart';
import 'package:ambrosia_ayurved/cosmetics/view/home/cart/new_cart/provider.dart';
import 'package:ambrosia_ayurved/cosmetics/view/home/cart/order_now/order_grandtotal_provider.dart';
import 'package:ambrosia_ayurved/cosmetics/view/home/cart/order_now/order_item_total_price_provider.dart';
import 'package:ambrosia_ayurved/provider/user_provider.dart';
import 'package:provider/provider.dart';

class PlaceOrderProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _message;
  String? _orderId; // Store order ID

  bool get isLoading => _isLoading;
  String? get message => _message;
  String? get orderId => _orderId;

  Future<void> placeOrder(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final grandTotalProvider =
        Provider.of<GrandTotalProvider>(context, listen: false);
    final String userId = userProvider.id;

    final double grandTotal = grandTotalProvider.grandTotal;

    // Create an instance of ItemTotalPriceProvider
    final itemTotalPriceProvider = ItemTotalPriceProvider();

    _isLoading = true;
    _message = null;
    _orderId = null;
    notifyListeners();

    for (var item in cartProvider.cartItems) {
      // Calculate total price for this item using the provider function
      double totalPrice = itemTotalPriceProvider.calculateTotalPrice(
        item.price.toString(),
        item.quantity.toString(),
      );

      final Map<String, String> orderData = {
        "user_id": userId,
        "product_id": item.productId.toString(),
        "quantity": item.quantity.toString(),
        "product_price": item.price.toString(),
        "total_price": totalPrice.toString(),
      };
      print(orderData);

      try {
        final response = await http.post(
          Uri.parse("https://ambrosiaayurved.in/api/order_data"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(orderData),
        );

        final responseData = jsonDecode(response.body);

        if (responseData["status"] == "success" &&
            responseData['order_id'] != null) {
          _message = responseData["message"];
          _orderId = responseData["order_id"]
              .toString(); // Extract order_id from API response
          print("Order ID: $_orderId");
          print(responseData);

          // SnackbarMessage.showSnackbar(context, 'Order placed successfully');
        } else {
          //  SnackbarMessage.showSnackbar(context, 'Failed to place order');
          _message = "Order placement failed!";
        }
      } catch (error) {
        print(error);
        //  SnackbarMessage.showSnackbar(context, '$error');
        _message = "An error occurred!";
      }
    }

    _isLoading = false;
    notifyListeners();
  }
}
