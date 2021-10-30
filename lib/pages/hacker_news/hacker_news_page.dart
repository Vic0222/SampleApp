import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/blocs/top_news_list/top_news_list_bloc.dart';
import 'package:sample_app/blocs/top_news_list/top_news_list_state.dart';

class HackerNewsPage extends StatefulWidget {
  const HackerNewsPage({Key? key}) : super(key: key);

  @override
  State<HackerNewsPage> createState() => _HackerNewsPageState();
}

class _HackerNewsPageState extends State<HackerNewsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _loadTopNews(context));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hacker News"),
        ),
        body: BlocBuilder<TopNewsListBloc, TopNewsListState>(
          builder: (context, state) {
            if (state.status == TopNewsListStatus.loadSuccess) {
              return buildList(context, state);
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, TopNewsListState state) {
    return ListView.builder(
        itemCount: state.topNewsIds.length,
        itemBuilder: (context, i) {
          return Text(i.toString());
        });
  }

  void _loadTopNews(BuildContext context) {
    context.read<TopNewsListBloc>().loadTopNews();
  }
}
