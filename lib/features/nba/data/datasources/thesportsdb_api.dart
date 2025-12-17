import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/thesportsdb_models.dart';

part 'thesportsdb_api.g.dart';

@RestApi(baseUrl: 'https://www.thesportsdb.com/')
abstract class TheSportsDbApi {
  factory TheSportsDbApi(Dio dio, {String baseUrl}) = _TheSportsDbApi;

  @GET('api/v1/json/123/lookupleague.php')
  Future<Map<String, List<TheSportsDbLeagueDto>>> getLeagueDetails(@Query('id') String leagueId);

  @GET('api/v1/json/123/searchteams.php')
  Future<Map<String, List<TheSportsDbTeamDto>>> getTeamDetails(@Query('t') String teamName);

  @GET('api/v1/json/123/lookup_all_players.php')
  Future<Map<String, List<TheSportsDbPlayerDto>>> getTeamPlayers(@Query('id') String teamId);

  @GET('api/v1/json/123/eventslast.php')
  Future<Map<String, List<TheSportsDbEventDto>>> getLastEvents(@Query('id') String teamId);

  @GET('api/v1/json/123/eventsnext.php')
  Future<Map<String, List<TheSportsDbEventDto>>> getNextEvents(@Query('id') String teamId);
}
