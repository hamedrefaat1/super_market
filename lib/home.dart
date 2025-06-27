// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruits_app/model.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool addProduct = false;

  List<String> items = [
    "assets/images/Slider 1.png",
    "assets/images/Slider 2.png",
    "assets/images/Slider 3.png"
  ];

  List<CategoryModel> category = [
    CategoryModel(name: "Fruits", image: "assets/images/image 38.png"),
    CategoryModel(name: "Milk & egg", image: "assets/images/image 39.png"),
    CategoryModel(name: "Beverages", image: "assets/images/image 37.png"),
    CategoryModel(name: "Laundry", image: "assets/images/image 41.png"),
    CategoryModel(name: "Vegetables", image: "assets/images/image 36.png"),
  ];

  List<ProductModel> product = [
    ProductModel(
      name: "Banana",
      image: "assets/images/image 44.png",
      price: "3.99",
      rate: "5",
      rateCount: "15",
    ),
    ProductModel(
      name: "Papper",
      image: "assets/images/image 42.png",
      price: "2.99",
      rate: "4",
      rateCount: "287",
    ),
    ProductModel(
      name: "Orange",
      image: "assets/images/image 44 (1).png",
      price: "1.99",
      rate: "4",
      rateCount: "457",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(200),
          child: SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                const Icon(Icons.delivery_dining, color: Colors.black),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "61 Hopper street..",
                  style: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 4,
                ),
                SvgPicture.asset("assets/images/Vector.svg"),
                Spacer(),
                //  SvgPicture.asset("assets/images/cart.svg")
              ],
            ),
          ))),
     body: Stack(
  children: [
    SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          CarouselSlider.builder(
              itemCount: items.length,
              itemBuilder: (context, itemIndex, pageViewIndex) {
                return Image.asset(items[itemIndex]);
              },
              options: CarouselOptions(
                  height: 222,
                  aspectRatio: 1,
                  viewportFraction: 0.8,
                  autoPlayInterval: Duration(seconds: 2),
                  autoPlayAnimationDuration: Duration(seconds: 2),
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayCurve: Curves.linear)),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(category.length, (index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffF6F6F6)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(category[index].image),
                        ),
                      ),
                      Text(
                        category[index].name,
                        style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Color(0xff5A5555),
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Fruits",
                  style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Color(0xff0A0B0A),
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Text(
                  "See all",
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Color(0xff0CA201),
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: List.generate(product.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: cart(product[index]),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 100), // علشان تسيب مساحة تحت السلة
        ],
      ),
    ),

    /// ✅ هنا سلة الشراء بتظهر لما في منتج مضاف
    if (product.any((item) => item.quantity > 0))
      Positioned(
        bottom: 10,
        left: 15,
        right: 15,
        child: Container(
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              // صور المنتجات
              ...product
                  .where((item) => item.quantity > 0)
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        backgroundImage: AssetImage(item.image),
                      ),
                    ),
                  )
                  .toList(),
              SizedBox(width: 8),

              // View Basket
              Expanded(
                child: Text(
                  "View Basket",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              // أيقونة سلة وعدد المنتجات
              Stack(
                children: [
                  Icon(Icons.shopping_basket, color: Colors.white),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                        child: Text(
                          "${product.where((e) => e.quantity > 0).length}",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
  ],
),

    );
  }

  Column cart(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(children: [
          Container(
            height: 147,
            width: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xffF6F6F6),
            ),
            child: Image.asset(
              product.image,
              height: 119,
              width: 146,
            ),
          ),
          Positioned(
              right: 3,
              bottom: 3,
              child: product.quantity == 0
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          product.quantity = 1;
                        });
                      },
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFFFFFF)),
                        child: Center(
                          child: Icon(
                            Icons.add,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if(product.quantity>0){
                                 setState(() {
                                    product.quantity--;
                                 });
                                }
                              },
                              icon: Icon(
                                Icons.remove,
                                size: 16,
                              )),
                          Text(product.quantity.toString(),
                              style: GoogleFonts.inter(
                                  fontSize: 14, fontWeight: FontWeight.w600)),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  product.quantity++;
                                });
                              },
                              icon: Icon(
                                Icons.add,
                                size: 16,
                              ))
                        ],
                      ),
                    ))
        ]),
        SizedBox(
          height: 12,
        ),
        Text(
          product.name,
          style: GoogleFonts.inter(
              fontSize: 16,
              color: Color(0xff000000),
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SvgPicture.asset("assets/images/star.svg"),
            SizedBox(
              width: 8,
            ),
            Text(
              "${product.rate} ${product.rateCount}",
              style:
                  GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "\$${product.price}",
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
