import 'package:cached_network_image/cached_network_image.dart';
import 'package:discounttour/data/data.dart';
import 'package:discounttour/model/country_model.dart';
import 'package:discounttour/model/popular_tours_model.dart';
import 'package:discounttour/views/details.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PopularTourModel> popularTourModels = new List();
  List<CountryModel> country = new List();
  @override
  void initState() {
    country = getCountrys();
    popularTourModels = getPopularTours();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(7),
          child: Image.asset(
            "assets/menu.png",
            height: 20,
            width: 20,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
              height: 30,
            ),
            Text(
              "DiscountTour",
              style:
                  TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          )
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Find the best tour",
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Country",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 240,
                child: ListView.builder(
                    itemCount: country.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CountryListTile(
                        label: country[index].label,
                        countryName: country[index].countryName,
                        noOfTours: country[index].noOfTours,
                        rating: country[index].rating,
                        imgUrl: country[index].imgUrl,
                      );
                    }),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Popular Tours",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: popularTourModels.length,
                  itemBuilder: (context, index) {
                    return PopularTours(
                      desc: popularTourModels[index].desc,
                      imgUrl: popularTourModels[index].imgUrl,
                      title: popularTourModels[index].title,
                      price: popularTourModels[index].price,
                      rating: popularTourModels[index].rating,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class PopularTours extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String price;
  final double rating;
  PopularTours(
      {@required this.imgUrl,
      @required this.rating,
      @required this.desc,
      @required this.price,
      @required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Details(
                      imgUrl: imgUrl,
                      placeName: title,
                      rating: rating,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
            color: Color(0xffE9F4F9), borderRadius: BorderRadius.circular(20)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                width: 110,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4E6059)),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff89A097)),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    price,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4E6059)),
                  )
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 10, right: 8),
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Color(0xff139157)),
                child: Column(
                  children: [
                    Text(
                      "$rating",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class CountryListTile extends StatelessWidget {
  final String label;
  final String countryName;
  final int noOfTours;
  final double rating;
  final String imgUrl;
  CountryListTile(
      {@required this.countryName,
      @required this.label,
      @required this.noOfTours,
      @required this.rating,
      @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              height: 220,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 200,
            width: 150,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 8, top: 8),
                        padding:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white38),
                        child: Text(
                          label ?? "New",
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Thailand",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "18 Tours",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                        margin: EdgeInsets.only(bottom: 10, right: 8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 7),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white38),
                        child: Column(
                          children: [
                            Text(
                              "4.5",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
