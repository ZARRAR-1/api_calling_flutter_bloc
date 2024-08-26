import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/Post_Model.dart';
import '../repo/posts_repo.dart';

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

    fetchedPosts = await PostsRepo.fetchPosts();

    emit(PostFetchSuccessState(myPosts: fetchedPosts));
  }

  Future<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool response = await PostsRepo.addPosts();
    print("Response: $response");

    if (response) {
      emit(PostAddSuccessState());
    } else {
      emit(PostAddFailureState());
    }
    // if (success) {
    //   emit(PostAddSuccessState());
    // } else {
    //   emit(PostAddFailureState());
    // }
  }
}
