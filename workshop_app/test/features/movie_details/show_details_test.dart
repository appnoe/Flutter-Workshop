import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workshop_app/features/movie_details/presentation/page/show_details.dart';
import 'package:workshop_app/features/movie_list/presentation/bloc/movie_list_bloc.dart';
import 'package:workshop_app/features/movie_list/usecase/get_movie_list.dart';
import 'package:workshop_app/model/show_model.dart';


class MockGetMovieList extends Mock implements GetMovieList {}

void main() {
  late ShowDetails sut;
  late Show show;
  late MockGetMovieList mockGetMovieList;

  setUp(() {
    show = Show(id: 1, image: null, name: 'test_show', summary: 'test_summary');
    sut = ShowDetails(show: show);
    // einmalig

    mockGetMovieList = MockGetMovieList();

    when(() => mockGetMovieList.fetchData(any())).thenAnswer((_) async => null);

    GetIt.I.reset();

  });

  setUpAll(() {
    // vor jedem test
  });

  testWidgets('should render description', (widgetTester) async {
    await widgetTester.pumpWidget(MaterialApp(
      home: sut,
    ));
    await widgetTester.pumpAndSettle();

    final text = find.byKey(ShowDetails.descriptionKey);

    await widgetTester.scrollUntilVisible(text, 55.8);
    await widgetTester.pumpAndSettle();

    expect(text, findsOneWidget);
  });

  test('should do stuff', () {
    final element = sut.createElement();
    
    verify(() => sut.createElement());
    expect(element, element);
  });

  blocTest<MovieListBloc, MovieListState>(
    'emits [MyState] when MyEvent is added.',
    build: () => MovieListBloc(getMovieList: mockGetMovieList),
    act: (bloc) => bloc.add(MovieListRequested('test')),
    expect: () => const <MovieListState>[MyState],
    verify: (_) => [mockGetMovieList.fetchData('simpsons')]
  );
}
