import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/balldontlie_models.dart';

part 'balldontlie_api.g.dart';

@RestApi(baseUrl: 'https://api.balldontlie.io/v1')
abstract class BalldontlieApi {
  factory BalldontlieApi(Dio dio, {String baseUrl}) = _BalldontlieApi;

  @GET('/players')
  Future<BalldontlieResponse<BalldontliePlayerDto>> getPlayers({
    @Query('page') int page = 1,
    @Query('per_page') int perPage = 25,
    @Query('search') String? search,
  });

  @GET('/teams')
  Future<BalldontlieResponse<BalldontlieTeamDto>> getTeams();

  @GET('/games')
  Future<BalldontlieResponse<BalldontlieGameDto>> getGames({
    @Query('page') int page = 1,
    @Query('per_page') int perPage = 25,
    @Query('team_ids[]') List<int>? teamIds,
    @Query('seasons[]') List<String>? seasons,
  });

  @GET('/players/{id}')
  Future<String> getPlayerDetails(@Path('id') int id);
}
