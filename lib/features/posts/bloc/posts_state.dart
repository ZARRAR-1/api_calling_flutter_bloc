part of 'posts_bloc.dart';

@immutable
sealed class PostsState {} //Auto generated

abstract class PostsActionState {}//self-made

final class PostsInitial extends PostsState {} //Auto generated

//Non-Action States
class PostFetchingState extends PostsState {}

class PostLoadingState extends PostsState {}

class PostErrorState extends PostsState {}

class PostFetchSuccessState extends PostsState {

  final List<PostModel> myPosts;

  PostFetchSuccessState({required this.myPosts});
}

//Action States
class PostAddSuccessState extends PostsActionState {}

class PostAddFailureState extends PostsActionState {}

