import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/balldontlie_domain_models.dart';
import '../cubit/nba_cubit.dart';

class PlayerDetailsScreen extends StatefulWidget {
  final int playerId;
  final String playerName;

  const PlayerDetailsScreen({super.key, required this.playerId, required this.playerName});

  @override
  State<PlayerDetailsScreen> createState() => _PlayerDetailsScreenState();
}

class _PlayerDetailsScreenState extends State<PlayerDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NbaCubit>().fetchPlayerDetails(widget.playerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.playerName)),
      body: BlocBuilder<NbaCubit, NbaState>(
        builder: (context, state) {
          if (state is NbaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NbaError) {
            return Center(child: Text(state.message));
          } else if (state is NbaPlayerDetailLoaded) {
            final p = state.player;
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildProfileCard(p),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProfileCard(NbaPlayer p) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              "${p.firstName} ${p.lastName}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Divider(),
            _infoRow("Position", p.position),
            _infoRow("Team", p.teamName),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
