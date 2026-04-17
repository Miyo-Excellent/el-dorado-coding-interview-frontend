import 'package:flutter/material.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/widgets/atoms/keypad_button.dart';


class NumericKeypad extends StatelessWidget {
  final ValueChanged<String> onKeyPress;
  final VoidCallback onDelete;
  final VoidCallback onDone;

  const NumericKeypad({
    super.key,
    required this.onKeyPress,
    required this.onDelete,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48), // Balance for centering
              Text(
                'Ingresar Monto',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_down, color: colorScheme.primary),
                onPressed: onDone,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildRow(['1', '2', '3'], context),
          const SizedBox(height: 8),
          _buildRow(['4', '5', '6'], context),
          const SizedBox(height: 8),
          _buildRow(['7', '8', '9'], context),
          const SizedBox(height: 8),
          _buildRow(['.', '0', 'del'], context),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> keys, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: keys.map((key) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: KeypadButton(
              text: key,
              onTap: () {
                if (key == 'del') {
                  onDelete();
                } else if (key == 'done') {
                  onDone();
                } else {
                  onKeyPress(key);
                }
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
