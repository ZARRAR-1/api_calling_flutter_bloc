import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/posts_bloc.dart';

class MyPostsPage extends StatefulWidget {
  const MyPostsPage({super.key, required this.title});

  final String title;

  @override
  State<MyPostsPage> createState() => _MyPostsPageState();
}

class _MyPostsPageState extends State<MyPostsPage> {
  late final PostsBloc bloc;

  @override
  void initState() {
    bloc = PostsBloc();
    bloc.add(PostsFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        child:  Icon(Icons.add),
        onPressed: () {
          bloc.add(PostAddEvent());
        },
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: bloc,
        listenWhen: (previous, current) => current is PostsActionState,
        listener: (context, state) {

         if(state is PostAddSuccessState)
           {
             ScaffoldMessenger.of(context).showSnackBar(
               const SnackBar(
                 content: Text('Post Added Successfully !'),
                 duration: Duration(seconds: 1),
                 backgroundColor: Colors.green,
               ),
             );
           }
         else if (state is PostAddFailureState)
           {
             const SnackBar(
               content: Text('Post Failed To Add !'),
               duration: Duration(seconds: 1),
               backgroundColor: Colors.redAccent,
             );
           }
        },
        buildWhen: (previous, current) => current is! PostsActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchLoadingState:
              {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ),
                );
              }
            case PostFetchSuccessState:
              {
                final successState = state as PostFetchSuccessState;

                return Container(
                  child: ListView.builder(
                    itemCount: successState.myPosts.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey.shade200,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Title: ${successState.myPosts[index].title}",
                              textAlign: TextAlign.left,
                            ),
                            Text("Post: ${successState.myPosts[index].body}"),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            case PostErrorState:
              {
                return const Center(child: Text('Error Loading Posts !'));
              }
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
