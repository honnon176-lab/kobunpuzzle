import 'package:flutter/material.dart';
import '../models/auxiliary_verb.dart';
import 'full_puzzle_screen.dart';

class ModeSelectionScreen extends StatelessWidget {
  final List<AuxiliaryVerb> verbs;
  const ModeSelectionScreen({super.key, required this.verbs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B2B2B),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('② モードを選択（${verbs.length}種）',
            style: const TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '何をパズルにしますか？',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2B2B2B)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildModeButton(
              context,
              title: '【 活用形 】パズル',
              subtitle: '未然・連用・終止…の活用表を並べ替えます',
              color: const Color(0xFFC84B31),
              mode: PuzzleMode.formsOnly,
            ),
            const SizedBox(height: 16),
            _buildModeButton(
              context,
              title: '【 意味（順不同） 】パズル',
              subtitle: '意味の単語を好きな順番で枠内に埋めていきます',
              color: const Color(0xFFD97724),
              mode: PuzzleMode.meaningOnly,
            ),
            const SizedBox(height: 16),
            _buildModeButton(
              context,
              title: '【 両方 】完全攻略パズル',
              subtitle: '活用形と意味の両方を全シャッフルして挑戦します',
              color: const Color(0xFF2B2B2B),
              mode: PuzzleMode.both,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required Color color,
    required PuzzleMode mode,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FullPuzzleScreen(verbs: verbs, mode: mode),
          ),
        );
      },
      child: Column(
        children: [
          Text(title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }
}