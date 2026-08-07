import 'package:flutter/material.dart';
import '../models/auxiliary_verb.dart';
import 'mode_selection_screen.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({super.key});

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final Set<int> _selectedVerbIndices = {};

  @override
  Widget build(BuildContext context) {
    final connections = ['未然形', '連用形', '終止形', '体言/連体形', 'サ変未然/四段已然'];
    final types = ['四段型', '下二段型', 'ラ変型', '形容詞型', '形容動詞型', '特殊型'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2B2B2B),
        title: const Text('① 出題範囲を選択',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildSectionCard(
              title: '【 1. 助動詞ごと（個別指定） 】',
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('解きたい助動詞を選択してください',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            if (_selectedVerbIndices.length == allVerbs.length) {
                              _selectedVerbIndices.clear();
                            } else {
                              _selectedVerbIndices.addAll(
                                  List.generate(allVerbs.length, (i) => i));
                            }
                          });
                        },
                        child: Text(
                          _selectedVerbIndices.length == allVerbs.length
                              ? '全解除'
                              : '全選択',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: List.generate(allVerbs.length, (index) {
                      bool isSelected = _selectedVerbIndices.contains(index);
                      return FilterChip(
                        selected: isSelected,
                        label: Text(allVerbs[index].base),
                        selectedColor: const Color(0xFFC84B31),
                        checkmarkColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedVerbIndices.add(index);
                            } else {
                              _selectedVerbIndices.remove(index);
                            }
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2B2B2B),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    onPressed: _selectedVerbIndices.isEmpty
                        ? null
                        : () {
                            final selectedList = _selectedVerbIndices
                                .map((i) => allVerbs[i])
                                .toList();
                            _goToModeSelection(context, selectedList);
                          },
                    child: Text('選択した${_selectedVerbIndices.length}個で次へ'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: '【 2. 接続ごと 】',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: connections.map((conn) {
                  return ActionChip(
                    backgroundColor: const Color(0xFFE8E2D5),
                    label: Text(conn, style: const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      final filtered = allVerbs.where((v) => v.connection == conn).toList();
                      _goToModeSelection(context, filtered);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: '【 3. 活用の型ごと 】',
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: types.map((type) {
                  return ActionChip(
                    backgroundColor: const Color(0xFFF0CB85),
                    label: Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      final filtered = allVerbs.where((v) => v.type == type).toList();
                      _goToModeSelection(context, filtered);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            _buildSectionCard(
              title: '【 4. すべて 】',
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC84B31),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => _goToModeSelection(context, allVerbs),
                child: Text('全${allVerbs.length}種類の助動詞で次へ',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            // ★ 著作権表記フッター
            const SizedBox(height: 24),
            const Center(
              child: Text(
                '© 2026 scallop shell. All Rights Reserved.',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black45,
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black26),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(1, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF2B2B2B))),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  void _goToModeSelection(BuildContext context, List<AuxiliaryVerb> verbs) {
    if (verbs.isEmpty) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModeSelectionScreen(verbs: verbs),
      ),
    );
  }
}