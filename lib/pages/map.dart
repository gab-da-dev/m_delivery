import 'package:flutter/material.dart';
import 'package:m_delivery/models/store_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import '../models/checkout_provider.dart';
import '../utils/constants.dart';
import '../widget/bottom_nav.dart';
import 'package:location/location.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late WebViewPlusController controller;
  var loadingPercentage = 0;
  var location;

  @override
  void initState() {
    super.initState();



  }


    Future<dynamic> getUserLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  @override
  Widget build(BuildContext context) {
    final providerCheckout = Provider.of<CheckoutProvider>(context);
    final providerStore = Provider.of<StoreProvider>(context);
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
        child: Column(children: [
          Expanded(
            flex: 3,
            child: WebViewPlus(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'assets/web/map.html',
              onWebViewCreated: (controller) {
                this.controller = controller;

                // get phone location




                // push it to the map

                // show on map

                // remove the path from user and store

                // from coordinates reverse geocoder to get address


              },
              onPageFinished: (amount){
                getUserLocation().then((value) {
                  location = value;
                  print(location);
                  print(location.latitude);
                  controller.webViewController.runJavascript('setCoordinates(${location.latitude}, ${location.longitude},${providerStore.store['lat']}, ${providerStore.store['lng']})');
                });

              },
              javascriptChannels: [
                JavascriptChannel(name: 'JavascriptChannel', onMessageReceived: (onMessageReceived) async{
                  providerCheckout.setCoordinates(onMessageReceived.message);
                  // print(onMessageReceived.message);
                }),
                JavascriptChannel(name: 'JavascriptAddressChannel', onMessageReceived: (onMessageReceived)async{
                  providerCheckout.setAddress(onMessageReceived.message);
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
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kMainColor),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Save location',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
