import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import '../models/checkout_provider.dart';
import '../models/order_provider.dart';
import '../utils/constants.dart';
import '../widget/bottom_nav.dart';

class DeliveryMap extends StatefulWidget {
  const DeliveryMap({Key? key}) : super(key: key);

  @override
  State<DeliveryMap> createState() => _DeliveryMapState();
}

class _DeliveryMapState extends State<DeliveryMap> {
  late WebViewPlusController controller;
  var loadingPercentage = 0;
  var duration;
  var distance;

  @override
  Widget build(BuildContext context) {
    final providerOrder = Provider.of<OrderProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('clicked');
          Navigator.pop(context);
        },
        backgroundColor: Colors.lightGreen,
        child: const Icon(Icons.phone),
      ),
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 4,
            child: WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'assets/web/delivery_map.html',
              onWebViewCreated: (controller) {
                this.controller = controller;
              },
              onPageFinished: (amount){
                // print(providerOrder.order['latitude']);
                // print(providerOrder.order['longitude']);
                controller.webViewController.runJavascript('init(${providerOrder.order['latitude']}, ${providerOrder.order['longitude']}, ${providerOrder.order['driver_latitude']}, ${providerOrder.order['driver_longitude']})');
                // controller.webViewController.runJavascript('setUserCoordinates(${providerOrder.order['latitude']}, ${providerOrder.order['longitude']})');
              },
              javascriptChannels: [
                JavascriptChannel(name: 'durationChannel', onMessageReceived: (onMessageReceived) async{
                  setState(() {
                    duration = onMessageReceived.message;
                  });
                }),
                JavascriptChannel(name: 'distanceChannel', onMessageReceived: (onMessageReceived) async{
                  setState(() {
                    distance = onMessageReceived.message;
                  });
                }),
                JavascriptChannel(name: 'JavascriptAddressChannel', onMessageReceived: (onMessageReceived)async{
                  print(onMessageReceived.message);
                })
                // controller.webViewController.evaluateJavascript('getCoordinates')
              ].toSet(),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.face, size: 30,),
                        SizedBox(width: 50,),
                        Column(
                          children: [
                            Text('Gabriel'),
                            Text('Molopo')
                          ],
                        ),

                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.watch_later_outlined, size: 30,),
                        SizedBox(width: 50,),
                        Text('Arrive in ${duration} min')
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.directions, size: 30,),
                        SizedBox(width: 50,),
                        Text('${distance} km away')
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
