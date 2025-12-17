import '../../domain/models/balldontlie_domain_models.dart';
import '../../domain/repositories/balldontlie_repository.dart';
import '../datasources/balldontlie_api.dart';
import '../models/balldontlie_mappers.dart';

import 'dart:convert';
import '../models/balldontlie_models.dart';

class BalldontlieRepositoryImpl implements BalldontlieRepository {
  final BalldontlieApi _api;

  BalldontlieRepositoryImpl(this._api);

  @override
  Future<List<NbaPlayer>> getPlayers(int page) async {
    final response = await _api.getPlayers(page: page);
    return response.data.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<NbaTeam>> getTeams() async {
    final response = await _api.getTeams();
    return response.data.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<List<NbaGame>> getGames(int page) async {
    final response = await _api.getGames(page: page);
    return response.data.map((dto) => dto.toDomain()).toList();
  }

  @override
  Future<NbaPlayer> getPlayerDetails(int id) async {
    final responseString = await _api.getPlayerDetails(id);
    final jsonMap = json.decode(responseString);
    final dto = BalldontliePlayerDto.fromJson(jsonMap['data']);
    return dto.toDomain();
  }
}
