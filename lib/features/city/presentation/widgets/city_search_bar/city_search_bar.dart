import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test/core/base/di/dependency_service.dart';
import 'package:weather_test/features/city/domain/entities/city_entity.dart';
import 'package:weather_test/features/city/presentation/widgets/city_search_bar/blocs/get_cities_by_keyword_bloc/get_cities_by_keyword_bloc.dart';

class CitySearchBar extends StatefulWidget {
  final ValueSetter<CityEntity>? onCitySelected;

  const CitySearchBar({this.onCitySelected, super.key});

  @override
  State<CitySearchBar> createState() => _CitySearchBarState();
}

class _CitySearchBarState extends State<CitySearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dependencyGetter = DependencyService.of(context);

    return BlocProvider<GetCitiesByKeywordBloc>(
      create: (_) => dependencyGetter(),
      child: BlocBuilder<GetCitiesByKeywordBloc, GetCitiesByKeywordState>(
        builder: (context, state) => SearchBar(
          controller: _searchController,
          hintText: 'Start to type the city name...',
          leading: const Icon(Icons.search),
          onChanged: (query) => _openSearchDelegate(context, query),
          onTap: () => _openSearchDelegate(context, _searchController.text),
        ),
      ),
    );
  }

  void _openSearchDelegate(BuildContext context, String query) async {
    FocusScope.of(context).requestFocus(FocusNode());

    final result = await showSearch<CityEntity?>(
      context: context,
      query: query,
      delegate: CitySearchDelegate(context.read<GetCitiesByKeywordBloc>()),
    );

    if (context.mounted && result != null) {
      _searchController.text = result.name;
      widget.onCitySelected?.call(result);
    }
  }
}

class CitySearchDelegate extends SearchDelegate<CityEntity?> {
  final GetCitiesByKeywordBloc cityBloc;

  CitySearchDelegate(this.cityBloc);

  @override
  List<Widget>? buildActions(BuildContext context) => null;

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const BackButtonIcon(),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => const SizedBox();

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return const SizedBox();

    cityBloc.add(GetCitiesByKeywordEvent(query));

    return BlocBuilder<GetCitiesByKeywordBloc, GetCitiesByKeywordState>(
      bloc: cityBloc,
      builder: (BuildContext context, GetCitiesByKeywordState state) {
        final filteredWords = state.cities.where(
          (city) => city.name.toLowerCase().contains(query.toLowerCase()),
        );

        return ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.location_city),
              title: Text(filteredWords.elementAt(index).name),
              subtitle: Text(filteredWords.elementAt(index).address),
              onTap: () => close(context, filteredWords.elementAt(index)),
            );
          },
          itemCount: filteredWords.length,
        );
      },
    );
  }
}
