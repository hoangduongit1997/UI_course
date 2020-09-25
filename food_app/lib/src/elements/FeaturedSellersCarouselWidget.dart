import 'package:flutter/material.dart';

import '../elements/CardsCarouselLoaderWidget.dart';
import '../models/restaurant.dart';
import '../models/route_argument.dart';
import 'FeaturedSellerWidget.dart';

// ignore: must_be_immutable
class FeaturedSellersCarouselWidget extends StatefulWidget {
  List<Restaurant> restaurantsList;
  String heroTag;

  FeaturedSellersCarouselWidget({Key key, this.restaurantsList, this.heroTag}) : super(key: key);

  @override
  _FeaturedSellersCarouselWidgetState createState() => _FeaturedSellersCarouselWidgetState();
}

class _FeaturedSellersCarouselWidgetState extends State<FeaturedSellersCarouselWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.restaurantsList.isEmpty
        ? CardsCarouselLoaderWidget()
        : Container(
            height: 288,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.restaurantsList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    print(widget.heroTag);
                    Navigator.of(context).pushNamed('/Details',
                        arguments: RouteArgument(
                          id: widget.restaurantsList.elementAt(index).id,
                          heroTag: widget.heroTag,
                        ));
                  },
                  child: FeaturedSellerWidget(restaurant: widget.restaurantsList.elementAt(index), heroTag: widget.heroTag),
                );
              },
            ),
          );
  }
}
