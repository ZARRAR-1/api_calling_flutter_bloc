import 'package:api_calling_flutter_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integrating API Calls with Flutter Bloc',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Posts'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        body: BlocConsumer<PostsBloc, PostsState>(
          bloc: bloc,
          listenWhen: (previous, current) => current is PostsActionState,
          listener: (context, state) {
            // TODO: implement listener
          },
          buildWhen: (previous, current) => current is! PostsActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case PostFetchLoadingState:
                {
                  return const CircularProgressIndicator(
                    color: Colors.blueAccent,
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
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Title: ${successState.myPosts[index].title}", textAlign: TextAlign.left, ),
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
                return SizedBox();
            }
          },
        )
        // floatingActionButton: FloatingActionButton(
        //   onPressed:()  ,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.update),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
