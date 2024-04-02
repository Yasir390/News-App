import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  final String newImage,
      newsTitle,
      newsDate,
      author,
      description,
      content,
      source;

  const NewsDetailsScreen(
      {super.key,
      required this.newImage,
      required this.newsTitle,
      required this.newsDate,
      required this.author,
      required this.description,
      required this.content,
      required this.source});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {

  final format = DateFormat('MMMM dd, yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.source),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              height: height*0.45,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                child: CachedNetworkImage(
                  imageUrl: widget.newImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: height*0.46),
              padding: EdgeInsets.only(top: 10,right: 10,left: 10),
              child: Column(
                children: [
                  Text(widget.newsTitle,textAlign: TextAlign.justify,style: GoogleFonts.poppins().copyWith(
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(
                    height: height*0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.source,style: GoogleFonts.podkova().copyWith(
                        fontWeight: FontWeight.bold
                      ),),
                      Text(format.format(dateTime),style: GoogleFonts.podkova().copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(
                    height: height*0.01,
                  ),
                  Text(widget.content,style: GoogleFonts.podkova().copyWith()),

                ],
              ),
            )
          ],
        ));
  }
}
