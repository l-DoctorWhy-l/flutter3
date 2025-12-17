import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/nba_cubit.dart';

class NbaScreen extends StatelessWidget {
  const NbaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NBA API Test'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Balldontlie API'),
              Tab(text: 'TheSportsDB API'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildBalldontlieTab(context),
            _buildTheSportsDbTab(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBalldontlieTab(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _ApiButton(
                label: 'Players',
                onPressed: () => context.read<NbaCubit>().fetchPlayers(),
              ),
              _ApiButton(
                label: 'Teams',
                onPressed: () => context.read<NbaCubit>().fetchTeams(),
              ),
              _ApiButton(
                label: 'Games',
                onPressed: () => context.read<NbaCubit>().fetchGames(),
              ),
              _ApiButton(
                label: 'Player (237)',
                onPressed: () => context.read<NbaCubit>().fetchPlayerDetails(),
              ),
               _ApiButton(
                label: 'Season Avg',
                onPressed: () => context.read<NbaCubit>().fetchSeasonAverages(),
              ),
            ],
          ),
        ),
        Expanded(child: _ResultDisplay()),
      ],
    );
  }

  Widget _buildTheSportsDbTab(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              _ApiButton(
                label: 'League',
                onPressed: () => context.read<NbaCubit>().fetchLeagueDetails(),
              ),
              _ApiButton(
                label: 'Team (GSW)',
                onPressed: () => context.read<NbaCubit>().fetchTeamDetails(),
              ),
              _ApiButton(
                label: 'Players',
                onPressed: () => context.read<NbaCubit>().fetchTeamPlayers(),
              ),
              _ApiButton(
                label: 'Last Games',
                onPressed: () => context.read<NbaCubit>().fetchLastEvents(),
              ),
              _ApiButton(
                label: 'Next Games',
                onPressed: () => context.read<NbaCubit>().fetchNextEvents(),
              ),
            ],
          ),
        ),
        Expanded(child: _ResultDisplay()),
      ],
    );
  }
}

class _ApiButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ApiButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

class _ResultDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: BlocBuilder<NbaCubit, NbaState>(
        builder: (context, state) {
          if (state is NbaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NbaError) {
            return Center(
                child: Text('Error: ${state.message}',
                    style: const TextStyle(color: Colors.red)));
          } else if (state is NbaDataLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(state.data),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Select an API request to see results'));
        },
      ),
    );
  }
}

