import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/blocs/news/news_bloc.dart';
import 'package:sample_app/blocs/news/news_state.dart';
import 'package:sample_app/blocs/top_news_list/top_news_list_bloc.dart';
import 'package:sample_app/blocs/top_news_list/top_news_list_state.dart';
import 'package:sample_app/services/hacker_news_service.dart';
import 'package:url_launcher/url_launcher.dart';

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

class NewsTile extends StatefulWidget {
  final int id;
  const NewsTile(
    this.id, {
    Key? key,
  }) : super(key: key);

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _loadNews(context));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        switch (state.status) {
          case NewsStatus.loadSuccess:
            return ListTile(
              onTap: () => _openNews(context, state.news.url),
              title: Text(state.news.title),
              subtitle: Text("by: " + state.news.by),
            );
          case NewsStatus.loadFailure:
            return Text(state.errorMessage);
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _loadNews(BuildContext context) {
    context.read<NewsBloc>().loadNews(widget.id);
  }

  Future<void> _openNews(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("There was an error opening this news")));
    }
  }
}
