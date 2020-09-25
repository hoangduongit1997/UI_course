import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:location/location.dart';
import '../models/address.dart' as model;
import '../helpers/helper.dart';
import '../models/category.dart';
import '../models/food.dart';
import '../models/restaurant.dart';
import '../models/review.dart';
import '../repository/category_repository.dart';
import '../repository/food_repository.dart';
import '../repository/restaurant_repository.dart';
import '../repository/settings_repository.dart';
class HomeController extends ControllerMVC {
  List<Category> categories = <Category>[];
  List<Restaurant> topRestaurants = <Restaurant>[];
//  List<Restaurant> popularRestaurants = <Restaurant>[];
  List<Restaurant> allRestaurants = <Restaurant>[];
  List<Review> recentReviews = <Review>[];
  List<Food> trendingFoods = <Food>[];

  HomeController() {
    listenForTopRestaurants();
    listenForTrendingFoods();
    listenForCategories();
//    listenForPopularRestaurants();
    listenForAllRestaurants();
    listenForRecentReviews();
    onLocation();
  }

  Future<void> listenForCategories() async {
    final Stream<Category> stream = await getCategories();
    stream.listen((Category _category) {
      setState(() => categories.add(_category));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  Future<void> listenForTopRestaurants() async {
    final Stream<Restaurant> stream = await getNearRestaurants(deliveryAddress.value, deliveryAddress.value);
    stream.listen((Restaurant _restaurant) {
      setState(() => topRestaurants.add(_restaurant));
    }, onError: (a) {}, onDone: () {});
  }

//  Future<void> listenForPopularRestaurants() async {
//    final Stream<Restaurant> stream = await getPopularRestaurants(deliveryAddress.value);
//    stream.listen((Restaurant _restaurant) {
//      setState(() => popularRestaurants.add(_restaurant));
//    }, onError: (a) {}, onDone: () {});
//  }
  Future<void> listenForAllRestaurants() async {
    final Stream<Restaurant> stream = await getAllRestaurants();
    stream.listen((Restaurant _restaurant) {
      setState(() => allRestaurants.add(_restaurant));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForRecentReviews() async {
    final Stream<Review> stream = await getRecentReviews();
    stream.listen((Review _review) {
      setState(() => recentReviews.add(_review));
    }, onError: (a) {}, onDone: () {});
  }

  Future<void> listenForTrendingFoods() async {
    final Stream<Food> stream = await getTrendingFoods(deliveryAddress.value);
    stream.listen((Food _food) {
      setState(() => trendingFoods.add(_food));
    }, onError: (a) {
      print(a);
    }, onDone: () {});
  }

  void requestForCurrentLocation(BuildContext context) {
    OverlayEntry loader = Helper.overlayLoader(context);
    Overlay.of(context).insert(loader);
    setCurrentLocation().then((_address) async {
      deliveryAddress.value = _address;
      await refreshHome();
      loader.remove();
    }).catchError((e) {
      loader.remove();
    });
  }

// THIS IS WORKING BUT HAS BUGS
// THIS IS WORKING BUT HAS BUGS
  // THIS IS WORKING BUT HAS BUGS
  // THIS IS WORKING BUT HAS BUGS

  Future<void> onLocation() async{
    Location location = new Location();

    bool _serviceEnabled;
    bool _serviceEnabledService;
    PermissionStatus _permissionGranted;

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _serviceEnabled = await location.serviceEnabled();

    if(_serviceEnabled) {
      _serviceEnabledService = await location.requestService();
      if (_serviceEnabledService) {
        model.Address _address = await setCurrentLocation();
        setState(() {
          deliveryAddress.value = _address;
        });
        deliveryAddress.notifyListeners();
      }
    }else{
      _serviceEnabledService = await location.requestService();
      if (_serviceEnabledService) {
        model.Address _address = await setCurrentLocation();
        setState(() {
          deliveryAddress.value = _address;
        });
        deliveryAddress.notifyListeners();
      }
    }

  }


  Future<void> refreshHome() async {
    setState(() {
      categories = <Category>[];
      topRestaurants = <Restaurant>[];
//      popularRestaurants = <Restaurant>[];
      allRestaurants = <Restaurant>[];
      recentReviews = <Review>[];
      trendingFoods = <Food>[];
    });
    await listenForTopRestaurants();
    await listenForTrendingFoods();
    await listenForCategories();
//    await listenForPopularRestaurants();
    await listenForAllRestaurants();
    await listenForRecentReviews();
    await onLocation();
  }
}
