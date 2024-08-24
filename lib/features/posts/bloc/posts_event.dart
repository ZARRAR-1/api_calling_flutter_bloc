part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class PostsFetchEvent extends PostsEvent {

}

class PostAddEvent extends PostsEvent {}