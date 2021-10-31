import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/blocs/news/news_bloc.dart';
import 'package:sample_app/blocs/top_news_list/top_news_list_bloc.dart';
import 'package:sample_app/blocs/top_news_list/top_news_list_state.dart';
import 'package:sample_app/components/news_tile.dart';
import 'package:sample_app/services/hacker_news_service.dart';

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
            switch (state.status) {
              case TopNewsListStatus.loadSuccess:
                return buildList(context, state);
              case TopNewsListStatus.loadFailure:
                return Text(state.errorMessage);
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Widget buildList(BuildContext context, TopNewsListState state) {
    return ListView.separated(
        separatorBuilder: (context, index) => const Divider(
              color: Colors.black,
            ),
        itemCount: state.topNewsIds.length,
        itemBuilder: (context, i) {
          return BlocProvider(
            create: (context) => NewsBloc(context.read<HackerNewsService>()),
            child: NewsTile(state.topNewsIds[i]),
          );
        });
  }

  void _loadTopNews(BuildContext context) {
    context.read<TopNewsListBloc>().loadTopNews();
  }
}
