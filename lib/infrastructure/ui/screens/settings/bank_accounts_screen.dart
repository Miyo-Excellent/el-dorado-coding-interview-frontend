import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/data/cubits/bank_account/bank_account_cubit.dart';
import 'package:el_dorado_coding_interview_frontend/domain/di/injection_container.dart';
import 'package:el_dorado_coding_interview_frontend/domain/models/bank_account_model.dart';
import 'package:el_dorado_coding_interview_frontend/infrastructure/ui/theme/tokens.dart';

// =============================================================================
// CARD COLOR PALETTE — 8 premium gradients, persisted via colorIndex in Hive
// =============================================================================

const List<List<Color>> kCardGradients = [
  // 0 — El Dorado Gold (brand primary)
  [Color(0xFFEFFF00), Color(0xFFFFB400)],
  // 1 — Midnight Noir
  [Color(0xFF2A2A2A), Color(0xFF0E0E0E)],
  // 2 — Arctic Blue
  [Color(0xFF00C6FF), Color(0xFF0072FF)],
  // 3 — Cosmic Purple
  [Color(0xFFDA22FF), Color(0xFF9733EE)],
  // 4 — Emerald Forest
  [Color(0xFF11998E), Color(0xFF38EF7D)],
  // 5 — Sunset Coral
  [Color(0xFFFF6B6B), Color(0xFFFFE66D)],
  // 6 — Rose Gold
  [Color(0xFFEECDA3), Color(0xFFD4A56A)],
  // 7 — Ocean Deep
  [Color(0xFF1A1A2E), Color(0xFF16213E)],
];

/// Returns contrasting text/icon color for a given gradient
Color _cardForeground(int colorIndex) {
  // Dark gradients → white text; light gradients → dark text
  const darkIndices = {1, 7};
  const midIndices = {2, 3, 4};
  if (darkIndices.contains(colorIndex)) return Colors.white;
  if (midIndices.contains(colorIndex)) return Colors.white;
  return const Color(0xFF131313);
}

// =============================================================================
// SCREEN ENTRY POINT
// =============================================================================

class BankAccountsScreen extends StatelessWidget {
  const BankAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BankAccountCubit>()..fetchAccounts(),
      child: const _BankAccountsView(),
    );
  }
}

// =============================================================================
// MAIN VIEW
// =============================================================================

class _BankAccountsView extends StatelessWidget {
  const _BankAccountsView();

  void _showAddAccountSheet(BuildContext context) {
    // Capture the cubit BEFORE pushing the sheet (different BuildContext inside)
    final cubit = context.read<BankAccountCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddAccountSheet(cubit: cubit),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Cuentas Bancarias',
          style: TextStyle(
            fontFamily: AppFonts.spaceGrotesk,
            fontWeight: FontWeight.w800,
            color: colorScheme.primary,
          ),
        ),
        backgroundColor: colorScheme.surface,
        elevation: 0,
      ),
      body: BlocBuilder<BankAccountCubit, BankAccountState>(
        builder: (context, state) {
          if (state is BankAccountLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is BankAccountLoaded) {
            if (state.accounts.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.credit_card_off_outlined,
                        size: 64,
                        color: colorScheme.onSurface.withValues(alpha: 0.2)),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Sin cuentas aún.\nToca + para agregar una.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorScheme.onSurface.withValues(alpha: 0.4),
                        fontFamily: AppFonts.inter,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, 100,
              ),
              itemCount: state.accounts.length,
              itemBuilder: (context, index) {
                return _BankCard3D(account: state.accounts[index]);
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAccountSheet(context),
        backgroundColor: colorScheme.primary,
        child: Icon(Icons.add, color: colorScheme.onPrimary),
      ),
    );
  }
}

// =============================================================================
// ADD ACCOUNT BOTTOM SHEET — with live 3D card preview + color picker
// =============================================================================

class _AddAccountSheet extends StatefulWidget {
  final BankAccountCubit cubit;
  const _AddAccountSheet({required this.cubit});

  @override
  State<_AddAccountSheet> createState() => _AddAccountSheetState();
}

class _AddAccountSheetState extends State<_AddAccountSheet> {
  final _nameCtrl = TextEditingController();
  final _aliasCtrl = TextEditingController();
  final _numberCtrl = TextEditingController();
  final _typeCtrl = TextEditingController();

  // Pick a random starting color so each new card feels fresh
  late int _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = Random().nextInt(kCardGradients.length);
    // Update preview as user types
    _nameCtrl.addListener(() => setState(() {}));
    _numberCtrl.addListener(() => setState(() {}));
    _typeCtrl.addListener(() => setState(() {}));
    _aliasCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _aliasCtrl.dispose();
    _numberCtrl.dispose();
    _typeCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (_nameCtrl.text.trim().isEmpty || _numberCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Banco y número son obligatorios')),
      );
      return;
    }
    widget.cubit.addAccount(
      BankAccountModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        bankName: _nameCtrl.text.trim(),
        alias: _aliasCtrl.text.trim(),
        accountNumber: _numberCtrl.text.trim(),
        type: _typeCtrl.text.trim().isEmpty ? 'Ah.' : _typeCtrl.text.trim(),
        colorIndex: _selectedColor,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    // Build a preview model from live text fields
    final preview = BankAccountModel(
      id: 'preview',
      bankName: _nameCtrl.text.isEmpty ? 'Mi Banco' : _nameCtrl.text,
      alias: _aliasCtrl.text,
      accountNumber:
          _numberCtrl.text.isEmpty ? '0000000000000000' : _numberCtrl.text,
      type: _typeCtrl.text.isEmpty ? 'Ah.' : _typeCtrl.text,
      colorIndex: _selectedColor,
    );

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Handle bar ─────────────────────────────────────────────
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              Text(
                'Nueva Cuenta',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontFamily: AppFonts.spaceGrotesk,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Live 3D card preview ────────────────────────────────────
              _BankCard3D(account: preview, isPreview: true),

              const SizedBox(height: AppSpacing.lg),

              // ── Color palette ───────────────────────────────────────────
              Text(
                'COLOR DE TARJETA',
                style: TextStyle(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontFamily: AppFonts.inter,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: kCardGradients.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (context, i) {
                    final selected = i == _selectedColor;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedColor = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: kCardGradients[i],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                          border: selected
                              ? Border.all(
                                  color: colorScheme.primary, width: 3)
                              : Border.all(
                                  color: Colors.transparent, width: 3),
                          boxShadow: selected
                              ? [
                                  BoxShadow(
                                    color: kCardGradients[i]
                                        .last
                                        .withValues(alpha: 0.5),
                                    blurRadius: 10,
                                  )
                                ]
                              : [],
                        ),
                        child: selected
                            ? Icon(Icons.check,
                                color: _cardForeground(i), size: 18)
                            : null,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Form fields ─────────────────────────────────────────────
              _Field(
                controller: _nameCtrl,
                label: 'Nombre del Banco',
                icon: Icons.account_balance_outlined,
              ),
              const SizedBox(height: AppSpacing.md),
              _Field(
                controller: _aliasCtrl,
                label: 'Alias (Opcional)',
                icon: Icons.label_outline,
              ),
              const SizedBox(height: AppSpacing.md),
              _Field(
                controller: _numberCtrl,
                label: 'Número de Cuenta',
                icon: Icons.pin_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: AppSpacing.md),
              _Field(
                controller: _typeCtrl,
                label: 'Tipo (Ah. / Cte.)',
                icon: Icons.category_outlined,
              ),

              const SizedBox(height: AppSpacing.xl),

              // ── Save CTA ────────────────────────────────────────────────
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: const Color(0xFF131313),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.xl),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Guardar Cuenta',
                    style: TextStyle(
                      fontFamily: AppFonts.spaceGrotesk,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// REUSABLE STYLED INPUT FIELD
// =============================================================================

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;

  const _Field({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: TextStyle(
        color: colorScheme.onSurface,
        fontFamily: AppFonts.inter,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.4),
          fontFamily: AppFonts.inter,
          fontSize: 14,
        ),
        prefixIcon: Icon(icon,
            color: colorScheme.onSurface.withValues(alpha: 0.3), size: 20),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
    );
  }
}

// =============================================================================
// 3D INTERACTIVE BANK CARD
// =============================================================================

class _BankCard3D extends StatefulWidget {
  final BankAccountModel account;
  final bool isPreview;

  const _BankCard3D({required this.account, this.isPreview = false});

  @override
  State<_BankCard3D> createState() => _BankCard3DState();
}

class _BankCard3DState extends State<_BankCard3D>
    with SingleTickerProviderStateMixin {
  double _tiltX = 0.0;
  double _tiltY = 0.0;
  double _startTiltX = 0.0;
  double _startTiltY = 0.0;

  bool _isMasked = true;

  // isDefault is driven by the persisted model — NOT local state
  bool get _isDefault => widget.account.isDefault;

  late final AnimationController _springController;
  late final CurvedAnimation _springCurve;

  static const double _maxTilt = 0.15; // ~8.6 degrees
  static const double _perspective = 0.002;

  @override
  void initState() {
    super.initState();
    _springController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addListener(_onSpringTick);
    _springCurve = CurvedAnimation(
      parent: _springController,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _springController.dispose();
    super.dispose();
  }

  void _onSpringTick() {
    final t = _springCurve.value;
    setState(() {
      _tiltX = _startTiltX * (1 - t);
      _tiltY = _startTiltY * (1 - t);
    });
  }

  void _onPanUpdate(DragUpdateDetails d) {
    if (_springController.isAnimating) _springController.stop();
    setState(() {
      _tiltX = (_tiltX + d.delta.dy * -0.004).clamp(-_maxTilt, _maxTilt);
      _tiltY = (_tiltY + d.delta.dx * 0.004).clamp(-_maxTilt, _maxTilt);
    });
  }

  void _onPanEnd(DragEndDetails details) {
    _startTiltX = _tiltX;
    _startTiltY = _tiltY;
    _springController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final acct = widget.account;
    final gradient = kCardGradients[acct.colorIndex.clamp(0, kCardGradients.length - 1)];
    final fg = _cardForeground(acct.colorIndex);

    final String displayed = _isMasked
        ? (acct.accountNumber.length > 4
            ? '**** **** ${acct.accountNumber.substring(acct.accountNumber.length - 4)}'
            : acct.accountNumber)
        : acct.accountNumber;

    final sheenX = 0.5 + (_tiltY / _maxTilt) * 0.5;
    final sheenY = 0.5 + (_tiltX / _maxTilt) * 0.5;

    final shadowDx = -_tiltY * 80;
    final shadowDy = -_tiltX * 80 + 12;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: GestureDetector(
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, _perspective)
            ..rotateX(_tiltX)
            ..rotateY(_tiltY),
          alignment: FractionalOffset.center,
          child: Container(
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              boxShadow: [
                BoxShadow(
                  color: gradient.last.withValues(alpha: 0.35),
                  blurRadius: 24,
                  offset: Offset(
                    shadowDx.clamp(-20, 20),
                    shadowDy.clamp(0, 24),
                  ),
                ),
                if (_isDefault)
                  BoxShadow(
                    color: gradient.first.withValues(alpha: 0.5),
                    blurRadius: 50,
                    spreadRadius: 4,
                  ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.xl),
              child: Stack(
                children: [
                  // ── BASE GRADIENT ────────────────────────────────────
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: _isDefault
                            ? Border.all(color: Colors.white, width: 2.5)
                            : null,
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                      ),
                    ),
                  ),

                  // ── DECORATIVE ELEMENTS ──────────────────────────────
                  Positioned(
                    right: -30,
                    top: -30,
                    child: Icon(Icons.all_inclusive_rounded,
                        size: 160,
                        color: fg.withValues(alpha: 0.06)),
                  ),
                  Positioned(
                    left: -15,
                    bottom: -15,
                    child: Icon(Icons.nfc,
                        size: 80, color: fg.withValues(alpha: 0.05)),
                  ),

                  // ── LIGHT SHEEN ──────────────────────────────────────
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppRadius.xl),
                        gradient: RadialGradient(
                          center: Alignment(
                            (sheenX * 2 - 1).clamp(-1.0, 1.0),
                            (sheenY * 2 - 1).clamp(-1.0, 1.0),
                          ),
                          radius: 0.8,
                          colors: [
                            Colors.white.withValues(alpha: 0.30),
                            Colors.white.withValues(alpha: 0.0),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // ── CONTENT ──────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppSpacing.xl, AppSpacing.lg, AppSpacing.lg, AppSpacing.lg,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                acct.bankName.toUpperCase(),
                                style: TextStyle(
                                  color: fg,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: AppFonts.spaceGrotesk,
                                  letterSpacing: 1.5,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (_isDefault)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: fg.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'DEFAULT',
                                  style: TextStyle(
                                    color: fg,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                              )
                            else
                              Icon(Icons.contactless, color: fg, size: 22),
                          ],
                        ),

                        const Spacer(),

                        // Account number + reveal
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                displayed,
                                style: TextStyle(
                                  color: fg,
                                  fontSize: 20,
                                  fontFamily: AppFonts.spaceGrotesk,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: _isMasked ? 4 : 1.5,
                                ),
                              ),
                            ),
                            if (!widget.isPreview)
                              _MiniAction(
                                icon: _isMasked
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                onTap: () =>
                                    setState(() => _isMasked = !_isMasked),
                                fg: fg,
                              ),
                          ],
                        ),

                        const SizedBox(height: AppSpacing.md),

                        // Footer
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: fg.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                acct.type.toUpperCase(),
                                style: TextStyle(
                                  color: fg,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: AppFonts.inter,
                                  fontSize: 11,
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (!widget.isPreview) ...[
                              if (!_isDefault)
                                _MiniAction(
                                  icon: Icons.star_outline_rounded,
                                  onTap: () => context
                                      .read<BankAccountCubit>()
                                      .setDefault(acct.id),
                                  tooltip: 'Hacer principal',
                                  fg: fg,
                                ),
                              _MiniAction(
                                icon: Icons.swap_horiz_rounded,
                                onTap: () =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Reemplazar próximamente'),
                                  ),
                                ),
                                tooltip: 'Reemplazar',
                                fg: fg,
                              ),
                              _MiniAction(
                                icon: Icons.delete_outline_rounded,
                                onTap: () => context
                                    .read<BankAccountCubit>()
                                    .deleteAccount(acct.id),
                                tooltip: 'Eliminar',
                                fg: fg,
                                isDestructive: true,
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// MINI ACTION BUTTON
// =============================================================================

class _MiniAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String? tooltip;
  final bool isDestructive;
  final Color fg;

  const _MiniAction({
    required this.icon,
    required this.onTap,
    required this.fg,
    this.tooltip,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? const Color(0xFFB71C1C) : fg;

    return Tooltip(
      message: tooltip ?? '',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.full),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Icon(icon, color: color, size: 20),
          ),
        ),
      ),
    );
  }
}
