import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/Post_Model.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsFetchEvent>(postsFetchEvent);
    on<PostAddEvent>(postAddEvent);
  }

  Future<void> postsFetchEvent(
      PostsFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostFetchLoadingState());

    List<PostModel> fetchedPosts = [];

    var client = http.Client();
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      //Parses the String Array and returns the resulting list of Json objects
      final List<dynamic> jsonArray = jsonDecode(response.body);

      // Replaced this:
      // for (int i = 0; i < dataList.length ; i++)
      //   {
      //     fetched_posts.add(PostModel.fromJson(dataList[i]));
      //   }

      //With this:
      fetchedPosts =
          jsonArray.map((jsonItem) => PostModel.fromJson(jsonItem)).toList();

      emit(PostFetchSuccessState(myPosts: fetchedPosts));

    } finally {
      client.close();
    }
  }

  FutureOr<void> postAddEvent(PostAddEvent event, Emitter<PostsState> emit) {}
}
