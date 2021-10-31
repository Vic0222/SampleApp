import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/blocs/news/news_bloc.dart';
import 'package:sample_app/blocs/news/news_state.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onTap: () => _openNews(context, state.news.url ?? ""),
              title: Text(state.news.title ?? ""),
              subtitle: Text("by: " + (state.news.by ?? "")),
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
