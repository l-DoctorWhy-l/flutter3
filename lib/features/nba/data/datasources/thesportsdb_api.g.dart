// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thesportsdb_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _TheSportsDbApi implements TheSportsDbApi {
  _TheSportsDbApi(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://www.thesportsdb.com/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<Map<String, List<TheSportsDbLeagueDto>>> getLeagueDetails(
      String leagueId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': leagueId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, List<TheSportsDbLeagueDto>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/v1/json/123/lookupleague.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!.map((k, dynamic v) => MapEntry(
        k,
        (v as List)
            .map(
                (i) => TheSportsDbLeagueDto.fromJson(i as Map<String, dynamic>))
            .toList()));
    return value;
  }

  @override
  Future<Map<String, List<TheSportsDbTeamDto>>> getTeamDetails(
      String teamName) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r't': teamName};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, List<TheSportsDbTeamDto>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/v1/json/123/searchteams.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!.map((k, dynamic v) => MapEntry(
        k,
        (v as List)
            .map((i) => TheSportsDbTeamDto.fromJson(i as Map<String, dynamic>))
            .toList()));
    return value;
  }

  @override
  Future<Map<String, List<TheSportsDbPlayerDto>>> getTeamPlayers(
      String teamId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': teamId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, List<TheSportsDbPlayerDto>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/v1/json/123/lookup_all_players.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!.map((k, dynamic v) => MapEntry(
        k,
        (v as List)
            .map(
                (i) => TheSportsDbPlayerDto.fromJson(i as Map<String, dynamic>))
            .toList()));
    return value;
  }

  @override
  Future<Map<String, List<TheSportsDbEventDto>>> getLastEvents(
      String teamId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': teamId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, List<TheSportsDbEventDto>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/v1/json/123/eventslast.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!.map((k, dynamic v) => MapEntry(
        k,
        (v as List)
            .map((i) => TheSportsDbEventDto.fromJson(i as Map<String, dynamic>))
            .toList()));
    return value;
  }

  @override
  Future<Map<String, List<TheSportsDbEventDto>>> getNextEvents(
      String teamId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': teamId};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<Map<String, List<TheSportsDbEventDto>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              'api/v1/json/123/eventsnext.php',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    var value = _result.data!.map((k, dynamic v) => MapEntry(
        k,
        (v as List)
            .map((i) => TheSportsDbEventDto.fromJson(i as Map<String, dynamic>))
            .toList()));
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
