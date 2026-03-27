import 'dart:math';

import 'package:flutter/material.dart';

enum CardStatus { loading, success, error }



class StatusCardWidget extends StatelessWidget {
	const StatusCardWidget({
		super.key,
		required this.status,
		this.onSuccess,
		this.onError,
		this.width = 300,
	});

	final CardStatus status;
	final VoidCallback? onSuccess;
	final VoidCallback? onError;
	final double width;

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
				color: Colors.white,
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
							title: 'Akun berhasil dibuat',
							subtitle: 'Anda akan diarahkan menuju halaman Beranda',
							buttonLabel: 'Lanjutkan',
							buttonColor: const Color(0xFFFF4D6D),
							onButton: onSuccess,
						),
						CardStatus.error => _ResultContent(
							iconWidget: const _CircleIcon(
								bgColor: Color(0xFFE53935),
								outerColor: Color(0xFFFCE4EC),
								icon: Icons.person_remove_rounded,
								iconColor: Colors.white,
							),
							title: 'Proses pembuatan\nakun gagal',
							subtitle: 'Silahkan untuk melakukan registrasi ulang.',
							buttonLabel: 'Kembali',
							buttonColor: const Color(0xFFFF4D6D),
							onButton: onError,
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
							final int frame = (_ctrl.value * _frameCount).floor() % _frameCount;
							final double sweepFraction = (frame + 1) / _frameCount;
							final double rotationAngle = _ctrl.value * 2 * pi;

							return CustomPaint(
								painter: _RingPainter(
									progress: sweepFraction,
									rotation: rotationAngle,
									trackColor: const Color(0xFFE0E0E0),
									progressColor: const Color(0xFFFF4D6D),
									strokeWidth: ringSize * 0.13,
								),
							);
						},
					),
				),
				const SizedBox(height: 28),
				const Text(
					'Sedang menyimpan...',
					style: TextStyle(
						fontSize: 18,
						fontWeight: FontWeight.w700,
						color: Color(0xFF1A1A2E),
					),
				),
				const SizedBox(height: 8),
				const Text(
					'Mohon untuk tidak menutup aplikasi\natau keluar dari halaman ini',
					textAlign: TextAlign.center,
					style: TextStyle(
						fontSize: 13,
						color: Color(0xFF9E9E9E),
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
		this.onButton,
	});

	final Widget iconWidget;
	final String title;
	final String subtitle;
	final String buttonLabel;
	final Color buttonColor;
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
					style: const TextStyle(
						fontSize: 18,
						fontWeight: FontWeight.w700,
						color: Color(0xFF1A1A2E),
						height: 1.4,
					),
				),
				const SizedBox(height: 8),
				Text(
					subtitle,
					textAlign: TextAlign.center,
					style: const TextStyle(
						fontSize: 13,
						color: Color(0xFF9E9E9E),
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
							foregroundColor: Colors.white,
							elevation: 0,
							shape: RoundedRectangleBorder(
								borderRadius: BorderRadius.circular(30),
							),
						),
						child: Text(
							buttonLabel,
							style: const TextStyle(
								fontSize: 15,
								fontWeight: FontWeight.w700,
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
			decoration: BoxDecoration(
				color: outerColor,
				shape: BoxShape.circle,
			),
			alignment: Alignment.center,
			child: Container(
				width: 76,
				height: 76,
				decoration: BoxDecoration(
					color: bgColor,
					shape: BoxShape.circle,
				),
				alignment: Alignment.center,
				child: Icon(icon, color: iconColor, size: 36),
			),
		);
	}
}