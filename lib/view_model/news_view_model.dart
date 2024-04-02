import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/repository/news_repository.dart';

import '../models/news_channel_headlines_model.dart';

class NewsViewModel{
  final _rep = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async{
    final response = await _rep.fetchNewsChannelHeadlinesApi(channelName);
    return response ;
  }
  
  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String type) async{
    final response = await _rep.fetchCategoriesNewsApi(type);
    return response ;
  }
}