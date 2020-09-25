import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/delivery_addresses_controller.dart';
import '../elements/DeliveryAddressDialog.dart';
import '../elements/DeliveryAddressesItemWidget.dart';
import '../models/address.dart';
import '../models/payment_method.dart';
import '../models/route_argument.dart';
import '../repository/settings_repository.dart';

class SetupDeliveryAddressWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  SetupDeliveryAddressWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _SetupDeliveryAddressWidgetState createState() => _SetupDeliveryAddressWidgetState();
}

class _SetupDeliveryAddressWidgetState extends StateMVC<SetupDeliveryAddressWidget> {
  DeliveryAddressesController _con;
  PaymentMethodList list;

  _SetupDeliveryAddressWidgetState() : super(DeliveryAddressesController()) {
    _con = controller;
  }

  @override
  Widget build(BuildContext context) {
    list = new PaymentMethodList(context);
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/img/journey.png',
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 40),
              Text('Enter your Delivery Address',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(237, 6, 5, 1),
                ),
              ),
              SizedBox(height: 20),
              IconButton(
                icon: Icon(Icons.add_circle),
                iconSize: 70.0,
                color: Colors.red,
                tooltip: 'Click to add address',
                onPressed: () async {
                  LocationResult result = await showLocationPicker(
                    context,
                    setting.value.googleMapsKey,
                    initialCenter: LatLng(deliveryAddress.value?.latitude ?? 0, deliveryAddress.value?.longitude ?? 0),
                    //automaticallyAnimateToCurrentLocation: true,
                    //mapStylePath: 'assets/mapStyle.json',
                    myLocationButtonEnabled: true,
                    //resultCardAlignment: Alignment.bottomCenter,
                  );
                  _con.addAddress(new Address.fromJSON({
                    'address': result.address,
                    'latitude': result.latLng.latitude,
                    'longitude': result.latLng.longitude,
                  }));
                  print("result = $result");
                  //setState(() => _pickedLocation = result);
                },
              ),
              ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 15),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                primary: false,
                itemCount: _con.addresses.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 15);
                },
                itemBuilder: (context, index) {
                  return DeliveryAddressesItemWidget(
                    address: _con.addresses.elementAt(index),
                    onPressed: (Address _address) {
                      DeliveryAddressDialog(
                        context: context,
                        address: _address,
                        onChanged: (Address _address) {
                          _con.updateAddress(_address);
                        },
                      );
                    },
                    onLongPress: (Address _address) {
                      DeliveryAddressDialog(
                        context: context,
                        address: _address,
                        onChanged: (Address _address) {
                          _con.updateAddress(_address);
                        },
                      );
                    },
                    onDismissed: (Address _address) {
                      _con.removeDeliveryAddress(_address);
                    },
                  );
                },
              ),
              FlatButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: () {
                  if( _con.addresses.isEmpty){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: Wrap(
                              spacing: 10,
                              children: <Widget>[
                                Icon(Icons.not_listed_location, color: Colors.deepOrange),
                                Text(
                                  'Address not found',
                                  style: TextStyle(color: Colors.deepOrange)
                                ),
                              ],
                            ),
                            content: new Text('Please enter your delivery address first'),
                            contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 25),
                            actions: <Widget>[
                              FlatButton(
                                child: new Text(
                                  "Ok",
                                  style: TextStyle(color: Theme.of(context).hintColor),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                  }else{
                    Navigator.of(context).pushReplacementNamed('/Pages', arguments: 2);
                  }
                },
                child: Text(
                  "Start Exploring",
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
