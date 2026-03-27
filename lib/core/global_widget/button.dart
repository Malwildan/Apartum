import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
	const AppButton({
		super.key,
		required this.label,
		this.onPressed,
		this.backgroundColor = const Color(0xFFFF3B7A),
		this.foregroundColor = Colors.white,
		this.borderRadius = 999,
		this.leading,
		this.trailing,
		this.textStyle,
		this.height = 48,
		this.width = double.infinity,
		this.padding = const EdgeInsets.symmetric(horizontal: 20),
		this.isLoading = false,
	});

	final String label;
	final VoidCallback? onPressed;
	final Color backgroundColor;
	final Color foregroundColor;
	final double borderRadius;
	final Widget? leading;
	final Widget? trailing;
	final TextStyle? textStyle;
	final double height;
	final double width;
	final EdgeInsetsGeometry padding;
	final bool isLoading;

	@override
	Widget build(BuildContext context) {
		final bool isEnabled = onPressed != null && !isLoading;

		return SizedBox(
			height: height,
			width: width,
			child: ElevatedButton(
				onPressed: isEnabled ? onPressed : null,
				style: ElevatedButton.styleFrom(
					backgroundColor: backgroundColor,
					foregroundColor: foregroundColor,
					elevation: 0,
					padding: padding,
					shape: RoundedRectangleBorder(
						borderRadius: BorderRadius.circular(borderRadius),
					),
				),
				child: isLoading
						? SizedBox(
								width: 20,
								height: 20,
								child: CircularProgressIndicator(
									strokeWidth: 2,
									valueColor: AlwaysStoppedAnimation<Color>(foregroundColor),
								),
							)
						: Row(
								mainAxisAlignment: MainAxisAlignment.center,
								mainAxisSize: MainAxisSize.max,
								children: [
									if (leading != null) ...[
										leading!,
										const SizedBox(width: 8),
									],
									Text(
										label,
										style: textStyle ??
												Theme.of(context).textTheme.labelLarge?.copyWith(
															color: foregroundColor,
															fontWeight: FontWeight.w600,
                              fontSize: 16,
														),
									),
									if (trailing != null) ...[
										const SizedBox(width: 8),
										trailing!,
									],
								],
							),
			),
		);
	}
}
