import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:m_delivery/pages/success.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import '../models/cart_provider.dart';
import '../models/checkout_provider.dart';
import '../models/store_provider.dart';
import '../models/user_provider.dart';
import '../network_services/payment_service.dart';
import '../widget/bottom_nav.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final PaymentService paymentService = PaymentService();
  bool _asyncCall = false;
  var loadingPercentage = 0;
  late WebViewPlusController controller;

  @override
  Widget build(BuildContext context) {
    final providerCart = Provider.of<CartProvider>(context);
    final providerCheckout = Provider.of<CheckoutProvider>(context);
    final providerStore = Provider.of<StoreProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: _asyncCall,
      child: Scaffold(
        bottomNavigationBar: BottomNav(),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: WebViewPlus(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'assets/web/payment.html',
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onPageFinished: (amount){
                  if(providerCheckout.isDelivery){
                    controller.webViewController.runJavascript('setAmount(${providerCart.cartTotal + providerStore.store['delivery_cost']})');
                  }
                  if(providerCheckout.isCollect){
                    controller.webViewController.runJavascript('setAmount(${providerCart.cartTotal})');
                  }
                },
                javascriptChannels: [
                  JavascriptChannel(
                      name: 'JavascriptChannel',
                      onMessageReceived: (onMessageReceived) async {
                        setState(() {
                          _asyncCall = true;
                        });
                        SharedPreferences localStorage = await SharedPreferences.getInstance();
                        dynamic user = json.decode(localStorage.getString('user').toString());

                        paymentService.getPaymentToken(onMessageReceived.message, providerCart.getCartJson(), user["id"],  providerCheckout.coordinates, providerCheckout.address).then((value) {
                          providerCart.clearCart();
                          if (value['status'] == 'successful') {
                            setState(() {
                              _asyncCall = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Success()));
                          }
                        });
                      }),
                ].toSet(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
