import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/balldontlie_domain_models.dart';
import '../cubit/nba_cubit.dart';
import '../../../../app_router.dart';

class NbaDashboardScreen extends StatefulWidget {
  const NbaDashboardScreen({super.key});

  @override
  State<NbaDashboardScreen> createState() => _NbaDashboardScreenState();
}

class _NbaDashboardScreenState extends State<NbaDashboardScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NbaCubit>().fetchTeams();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NBA Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () => _showLeagueInfo(context),
            )
          ],
          bottom: TabBar(
            onTap: (index) {
              final cubit = context.read<NbaCubit>();
              if (index == 0) cubit.fetchTeams();
              if (index == 1) cubit.fetchPlayers();
              if (index == 2) cubit.fetchGames();
            },
            tabs: const [
              Tab(text: 'Teams'),
              Tab(text: 'Players'),
              Tab(text: 'Games'),
            ],
          ),
        ),
        body: BlocBuilder<NbaCubit, NbaState>(
          builder: (context, state) {
            if (state is NbaLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NbaError) {
              return Center(child: Text(state.message));
            } else if (state is NbaTeamsLoaded) {
              return _buildTeamsList(state.teams);
            } else if (state is NbaPlayersLoaded) {
              return _buildPlayersList(state.players);
            } else if (state is NbaGamesLoaded) {
              return _buildGamesList(state.games);
            }
            return const Center(child: Text("Select a tab"));
          },
        ),
      ),
    );
  }

  Widget _buildTeamsList(List<NbaTeam> teams) {
    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        final team = teams[index];
        return ListTile(
          title: Text(team.fullName),
          subtitle: Text("${team.city} • ${team.conference}"),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            context.pushNamed(
              'team-details',
              pathParameters: {'name': team.fullName},
            );
          },
        );
      },
    );
  }

  Widget _buildPlayersList(List<NbaPlayer> players) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text("${player.firstName} ${player.lastName}"),
          subtitle: Text("${player.position} • ${player.teamName}"),
          onTap: () {
            context.pushNamed(
              'player-details',
              pathParameters: {'id': player.id.toString()},
              extra: "${player.firstName} ${player.lastName}",
            );
          },
        );
      },
    );
  }

  Widget _buildGamesList(List<NbaGame> games) {
    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            title: Text("${game.homeTeam} vs ${game.visitorTeam}"),
            subtitle: Text(game.date),
            trailing: Text(
              "${game.homeScore} - ${game.visitorScore}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  void _showLeagueInfo(BuildContext context) {
    final cubit = context.read<NbaCubit>();
    cubit.fetchLeagueDetails();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => BlocProvider.value(
        value: cubit,
        child: DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<NbaCubit, NbaState>(
                builder: (context, state) {
                  if (state is NbaLeagueLoaded) {
                    return ListView(
                      controller: scrollController,
                      children: [
                        Text(state.league.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(state.league.alternateName),
                        const SizedBox(height: 20),
                        Text("Sport: ${state.league.sport}"),
                        const Divider(),
                        const Text("Seasons", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        if (state.seasons.isNotEmpty)
                          Wrap(
                            spacing: 8.0,
                            children: state.seasons.map((s) => Chip(label: Text(s))).toList(),
                          )
                        else
                          const Text("No seasons data loaded."),
                      ],
                    );
                  }
                  if (state is NbaLoading) return const Center(child: CircularProgressIndicator());
                  return const SizedBox.shrink();
                },
              ),
            );
          }
        ),
      ),
    ).whenComplete(() => cubit.fetchTeams());
  }
}

