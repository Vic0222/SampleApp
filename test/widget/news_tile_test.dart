// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sample_app/blocs/news/news_bloc.dart';
import 'package:sample_app/components/news_tile.dart';
import 'package:sample_app/models/news.dart';
import 'package:sample_app/services/hacker_news_service.dart';

import 'news_tile_test.mocks.dart';

@GenerateMocks([HackerNewsService])
void main() {
  testWidgets('News tile test', (WidgetTester tester) async {
    //arrange
    var hackerRankService = MockHackerNewsService();
    var storyId = 1;
    var mockNews = const News(
        "MockUser", 0, 1, null, 1, 0, "Mock News", "", "http://mock.com");

    when(hackerRankService.getNews(storyId)).thenAnswer((_) => mockNews);

    var sut = MaterialApp(
      home: Scaffold(
        body: BlocProvider(
          create: (context) => NewsBloc(hackerRankService),
          child: NewsTile(storyId),
        ),
      ),
    );

    //act
    // Build our app and trigger a frame.
    await tester.pumpWidget(sut);
    await tester.pump();
    //assert
    verify(hackerRankService.getNews(storyId)).called(1);
    expect(find.textContaining(mockNews.by ?? ""), findsOneWidget);
    expect(find.text(mockNews.title ?? ""), findsOneWidget);
  });
}
