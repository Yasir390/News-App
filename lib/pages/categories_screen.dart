import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_model.dart';

import '../view_model/news_view_model.dart';
import 'home_page.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  FilterList? selectedMenu;

  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MMMM dd, yyyy');
  String categoryName = 'General';

  List<String> categoriesList = [
    'General',
    'Entertainment',
    'Health',
    'Business',
    'Technology'
  ];

  CategoriesNewsModel categoriesNewsModel = CategoriesNewsModel();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                 scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    itemBuilder:(context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            categoryName = categoriesList[index];
                          });

                        },
                        child: Card(
                          color: categoryName == categoriesList[index] ?Colors.blue:Colors.grey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(categoriesList[index],
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 13,
                              color: Colors.white
                            ),
                            ),
                          ),
                        ),
                      );
                    },),
              ),
              Expanded(
                child: FutureBuilder<CategoriesNewsModel>(
                  future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCubeGrid(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                       // scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                          return Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
                                    fit:BoxFit.cover,
                                    height:height*0.18,
                                    width:width*0.3,
                                    placeholder: (context, url) => const SpinKitChasingDots(
                                      color: Colors.amber,
                                      size: 50,
                                    ),
                                    errorWidget: (context, url, error) => const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(child: Container(
                                height: height*0.18,
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(snapshot.data!.articles![index].title.toString(),
                                    style: GoogleFonts.poppins().copyWith(
                                      fontSize: 15,
                                      color: Colors.black54,

                                    ),overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                    ),
                                    SizedBox(height: 4,),

                                    Text(snapshot.data!.articles![index].source!.name.toString(),
                                      style: GoogleFonts.poppins().copyWith(
                                        fontSize: 11,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold

                                      ),
                                      maxLines: 3,
                                    ),
                                    Text(format.format(dateTime),
                                      style: GoogleFonts.poppins().copyWith(
                                        fontSize: 11,
                                       // fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                            ],
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
