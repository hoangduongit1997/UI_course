import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/restaurant.dart';
import '../models/route_argument.dart';

class GridItemWidget extends StatelessWidget {
  final Restaurant restaurant;
  final String heroTag;

  GridItemWidget({Key key, this.restaurant, this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Theme.of(context).accentColor.withOpacity(0.08),
      onTap: () {
        Navigator.of(context).pushNamed('/Details', arguments: RouteArgument(id: restaurant.id, heroTag: heroTag));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [BoxShadow(color: Theme.of(context).focusColor.withOpacity(0.05), offset: Offset(0, 5), blurRadius: 5)]),
        child: Wrap(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: CachedNetworkImage(
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                  imageUrl: restaurant.image.thumb,
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    height: 90,
                    width: 90,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                        restaurant.name,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Theme.of(context).hintColor)),
                      ),
                    Text(
                        restaurant.address,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.caption.merge(TextStyle(color: Theme.of(context).hintColor)),
                      ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: Helper.getStarsList(double.parse(restaurant.rate)),
                      ),
                  ],
                ),
              )
            ],
          ),
          ],
        ),
      ),
    );
  }
}
