import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/thesportsdb_domain_models.dart';
import '../cubit/nba_cubit.dart';

class TeamDetailsScreen extends StatefulWidget {
  final String teamName;

  const TeamDetailsScreen({super.key, required this.teamName});

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NbaCubit>().fetchFullTeamData(widget.teamName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.teamName)),
      body: BlocBuilder<NbaCubit, NbaState>(
        builder: (context, state) {
          if (state is NbaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NbaError) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          } else if (state is NbaTeamDetailLoaded) {
            return _buildContent(state);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildContent(NbaTeamDetailLoaded state) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          _buildTeamHeader(state.team),
          const TabBar(
            tabs: [
              Tab(text: 'Info'),
              Tab(text: 'Roster'),
              Tab(text: 'Schedule'),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildInfoTab(state.team),
                _buildRosterTab(state.roster),
                _buildScheduleTab(state.lastEvents, state.nextEvents),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamHeader(SportsTeam team) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blueGrey.shade50,
      width: double.infinity,
      child: Column(
        children: [
          Text(team.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          if (team.stadium.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("🏟 ${team.stadium}", style: const TextStyle(fontSize: 16)),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoTab(SportsTeam team) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Text(
        team.description.isNotEmpty ? team.description : "No description available.",
        style: const TextStyle(fontSize: 16, height: 1.5),
      ),
    );
  }

  Widget _buildRosterTab(List<SportsPlayer> roster) {
    if (roster.isEmpty) return const Center(child: Text("No players found."));
    return ListView.separated(
      itemCount: roster.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final player = roster[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(player.name),
          subtitle: Text("${player.position} • ${player.height} • ${player.weight}"),
        );
      },
    );
  }

  Widget _buildScheduleTab(List<SportsEvent> last, List<SportsEvent> next) {
    return ListView(
      children: [
        if (next.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Upcoming Games", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...next.map((e) => ListTile(
            title: Text(e.eventName),
            subtitle: Text("${e.date} ${e.time}"),
            leading: const Icon(Icons.calendar_today),
          )),
        ],
        const Divider(thickness: 2),
        if (last.isNotEmpty) ...[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Recent Results", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...last.map((e) => ListTile(
            title: Text(e.eventName),
            subtitle: Text("${e.date}"),
            trailing: Text("${e.homeScore} - ${e.awayScore}", 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          )),
        ],
      ],
    );
  }
}

