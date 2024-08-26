part of 'posts_bloc.dart';

@immutable
abstract class PostsState {} //Auto generated

abstract class PostsActionState extends PostsState {} //self-made

final class PostsInitial extends PostsState {} //Auto generated

//Non-Action States
class PostFetchLoadingState extends PostsState {}

class PostErrorState extends PostsState {}

class PostFetchSuccessState extends PostsState {
  final List<PostModel> myPosts;

  PostFetchSuccessState({required this.myPosts});
}

//Action States
class PostAddSuccessState extends PostsActionState {}

class PostAddFailureState extends PostsActionState {}
