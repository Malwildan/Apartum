import 'dart:math';

import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AlertIssueData {
  const AlertIssueData({required this.disease, required this.symptoms});
  final String disease;
  final List<String> symptoms;
}

enum CardStatus { loading, success, error, whatsappBooking, safe, warning, danger }

class StatusCardWidget extends StatelessWidget {
  const StatusCardWidget({
    super.key,
    required this.status,
    this.onSuccess,
    this.onError,
    this.width = 342,
    this.successTitle,
    this.successSubtitle,
    this.successButtonLabel,
    this.errorTitle,
    this.errorSubtitle,
    this.errorButtonLabel,
    this.alertIssues,
  });

  final CardStatus status;
  final VoidCallback? onSuccess;
  final VoidCallback? onError;
  final double width;
  final String? successTitle;
  final String? successSubtitle;
  final String? successButtonLabel;
  final String? errorTitle;
  final String? errorSubtitle;
  final String? errorButtonLabel;
  final List<AlertIssueData>? alertIssues;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(scale: animation, child: child),
      ),
      child: _buildCard(status),
    );
  }

  Widget _buildCard(CardStatus s) {
    return SizedBox(
      key: ValueKey(s),
      width: width,
      child: Card(
        elevation: 8,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: StaticColor.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          child: switch (s) {
            CardStatus.loading => _LoadingContent(width: width),
            CardStatus.success => _ResultContent(
              iconWidget: const _CircleIcon(
                bgColor: Color(0xFF4CAF97),
                outerColor: Color(0xFFD6F0E8),
                icon: Icons.check_circle_rounded,
                iconColor: Colors.white,
              ),
              title: successTitle ?? 'Akun berhasil dibuat',
              subtitle: successSubtitle ?? 'Anda akan diarahkan menuju halaman Beranda',
              buttonLabel: successButtonLabel ?? 'Lanjutkan',
              buttonColor: StaticColor.primaryPink,
              onButton: onSuccess,
            ),
            CardStatus.error => _ResultContent(
              iconWidget: const _CircleIcon(
                bgColor: Color(0xFFE53935),
                outerColor: Color(0xFFFCE4EC),
                icon: Icons.person_remove_rounded,
                iconColor: Colors.white,
              ),
              title: errorTitle ?? 'Proses pembuatan\nakun gagal',
              subtitle: errorSubtitle ?? 'Silahkan untuk melakukan registrasi ulang.',
              buttonLabel: errorButtonLabel ?? 'Kembali',
              buttonColor: StaticColor.primaryPink,
              onButton: onError,
            ),
            CardStatus.whatsappBooking => _ResultContent(
              iconWidget: const _CircleIcon(
                bgColor: Color(0xFF3ECF8E),
                outerColor: Color(0xFFD6F0E8),
                icon: Icons.check_circle_outline_rounded,
                iconColor: Colors.white,
              ),
              title: 'Booking jadwal konsultasi\nmelalui admin WhatsApp?',
              subtitle:
                  'Anda akan diarahkan menuju kontak admin pada platform WhatsApp untuk melakukan janji temu lebih lanjut.',
              buttonLabel: 'Hubungi Admin WhatsApp',
              buttonColor: const Color(0xFF3ECF8E),
              buttonIcon: Icons.phone_in_talk_outlined,
              onButton: onSuccess,
            ),
            CardStatus.safe => _SafeResultContent(onButton: onSuccess),
            CardStatus.warning => _AlertResultContent(
              isDanger: false,
              issues: alertIssues ?? const [],
              onButton: onSuccess,
            ),
            CardStatus.danger => _AlertResultContent(
              isDanger: true,
              issues: alertIssues ?? const [],
              onButton: onSuccess,
            ),
          },
        ),
      ),
    );
  }
}

class _LoadingContent extends StatefulWidget {
  const _LoadingContent({required this.width});

  final double width;

  @override
  State<_LoadingContent> createState() => _LoadingContentState();
}

class _LoadingContentState extends State<_LoadingContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  static const int _frameCount = 12;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double ringSize = widget.width * 0.50;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: ringSize,
          height: ringSize,
          child: AnimatedBuilder(
            animation: _ctrl,
            builder: (_, __) {
              final int frame =
                  (_ctrl.value * _frameCount).floor() % _frameCount;
              final double sweepFraction = (frame + 1) / _frameCount;
              final double rotationAngle = _ctrl.value * 2 * pi;

              return CustomPaint(
                painter: _RingPainter(
                  progress: sweepFraction,
                  rotation: rotationAngle,
                  trackColor: StaticColor.disabled,
                  progressColor: StaticColor.primaryPink,
                  strokeWidth: ringSize * 0.13,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Sedang menyimpan...',
          style: AppTypography.h2.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Mohon untuk tidak menutup aplikasi\natau keluar dari halaman ini',
          textAlign: TextAlign.center,
          style: AppTypography.b3Regular.copyWith(
            color: StaticColor.textMuted,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.progress,
    required this.rotation,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  final double progress;
  final double rotation;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = (size.width - strokeWidth) / 2;
    final Rect rect = Rect.fromCircle(center: center, radius: radius);

    final Paint trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final Paint progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    canvas.drawArc(
      rect,
      rotation - pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) {
    return old.progress != progress || old.rotation != rotation;
  }
}

class _ResultContent extends StatelessWidget {
  const _ResultContent({
    required this.iconWidget,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.buttonColor,
    this.buttonIcon,
    this.onButton,
  });

  final Widget iconWidget;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final Color buttonColor;
  final IconData? buttonIcon;
  final VoidCallback? onButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        iconWidget,
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.h2.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTypography.b3Regular.copyWith(
            color: StaticColor.textMuted,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onButton,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: StaticColor.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: buttonIcon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(buttonIcon, color: StaticColor.surface, size: 22),
                      const SizedBox(width: 8),
                      AutoSizeText(
                        minFontSize: 8,
                        buttonLabel,
                        style: AppTypography.button1.copyWith(
                          fontWeight: FontWeight.w700,
                          color: StaticColor.surface,
                        ),
                      ),
                    ],
                  )
                : AutoSizeText(
                    minFontSize: 8,
                    buttonLabel,
                    style: AppTypography.button1.copyWith(
                      fontWeight: FontWeight.w700,
                      color: StaticColor.surface,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({
    required this.bgColor,
    required this.outerColor,
    required this.icon,
    required this.iconColor,
  });

  final Color bgColor;
  final Color outerColor;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(color: outerColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Container(
        width: 76,
        height: 76,
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Icon(icon, color: iconColor, size: 36),
      ),
    );
  }
}

class _SafeResultContent extends StatelessWidget {
  const _SafeResultContent({this.onButton});
  final VoidCallback? onButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _CircleIcon(
          bgColor: Color(0xFF3ECF8E),
          outerColor: Color(0xFFD6F0E8),
          icon: Icons.check_circle_rounded,
          iconColor: Colors.white,
        ),
        const SizedBox(height: 24),
        Text(
          'Aman',
          textAlign: TextAlign.center,
          style: AppTypography.h2.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Tidak ada gejala yang mengindikasikan kondisi yang serius.',
          textAlign: TextAlign.center,
          style: AppTypography.b3Regular.copyWith(
            color: StaticColor.textMuted,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onButton,
            style: ElevatedButton.styleFrom(
              backgroundColor: StaticColor.primaryPink,
              foregroundColor: StaticColor.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Kembali ke halaman Riwayat',
              style: AppTypography.button1.copyWith(
                fontWeight: FontWeight.w700,
                color: StaticColor.surface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AlertResultContent extends StatelessWidget {
  const _AlertResultContent({
    required this.isDanger,
    required this.issues,
    this.onButton,
  });

  final bool isDanger;
  final List<AlertIssueData> issues;
  final VoidCallback? onButton;

  @override
  Widget build(BuildContext context) {
    final iconBgColor =
        isDanger ? const Color(0xFFEF4444) : const Color(0xFFF59E0B);
    final iconOuterColor =
        isDanger ? const Color(0xFFFEE2E2) : const Color(0xFFFEF3C7);
    final title = isDanger
        ? 'Kondisi yang perlu perhatian segera'
        : 'Beberapa gejala perlu dipantau';
    final subtitle = isDanger
        ? 'Beberapa gejala yang dicatat dapat menjadi tanda kondisi serius.'
        : 'Ibu disarankan untuk berkonsultasi dengan tenaga medis jika gejala terus berlanjut.';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _CircleIcon(
          bgColor: iconBgColor,
          outerColor: iconOuterColor,
          icon: Icons.warning_rounded,
          iconColor: Colors.white,
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTypography.h2.copyWith(
            fontWeight: FontWeight.w700,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppTypography.b3Regular.copyWith(
            color: StaticColor.textMuted,
            height: 1.5,
          ),
        ),
        if (isDanger) ...[
          const SizedBox(height: 12),
          Text(
            'Kami memahami kondisi ini bisa membuat Ibu khawatir. Langkah terbaik adalah segera berkonsultasi.',
            textAlign: TextAlign.center,
            style: AppTypography.b3Regular.copyWith(
              color: StaticColor.textMuted,
              height: 1.5,
            ),
          ),
        ],
        if (issues.isNotEmpty) ...[
          const SizedBox(height: 20),
          ...issues.map(
            (issue) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: _IssueExpansionCard(issue: issue),
            ),
          ),
        ],
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onButton,
            style: ElevatedButton.styleFrom(
              backgroundColor: StaticColor.primaryPink,
              foregroundColor: StaticColor.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Kembali ke halaman Riwayat',
              style: AppTypography.button1.copyWith(
                fontWeight: FontWeight.w700,
                color: StaticColor.surface,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _IssueExpansionCard extends StatefulWidget {
  const _IssueExpansionCard({required this.issue});
  final AlertIssueData issue;

  @override
  State<_IssueExpansionCard> createState() => _IssueExpansionCardState();
}

class _IssueExpansionCardState extends State<_IssueExpansionCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.issue.disease,
                      style: AppTypography.b3Regular.copyWith(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  Icon(
                    _expanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 20,
                    color: const Color(0xFF6B7280),
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gejala yang memicu peringatan:',
                    style: AppTypography.b3Regular.copyWith(
                      color: const Color(0xFF4B5563),
                    ),
                  ),
                  const SizedBox(height: 6),
                  ...widget.issue.symptoms.map(
                    (symptom) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '• ',
                            style: TextStyle(color: Color(0xFF4B5563)),
                          ),
                          Expanded(
                            child: Text(
                              symptom,
                              style: AppTypography.b3Regular.copyWith(
                                color: const Color(0xFF4B5563),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
