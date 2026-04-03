import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:apartum/core/global_widget/app_button.dart';
import 'package:flutter/material.dart';

class DailyCheckWidget extends StatelessWidget {
  const DailyCheckWidget({
    super.key,
    required this.isLogged,
    this.onTap,
  });

  final bool isLogged;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final String message;
    final String buttonLabel;

    if (isLogged) {
      message = 'Anda sudah mencatat kondisi hari ini';
      buttonLabel = 'Ubah Pencatatan Hari Ini';
    } else {
      message =
          'Yuk catat kondisi dan gejala yang dialami hari ini, pencatatan hanya membutuhkan waktu kurang dari 1 menit😊';
      buttonLabel = 'Catat Kondisi Hari Ini';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        gradient: StaticColor.linearPink,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: StaticColor.primaryPink, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            message,
            textAlign: TextAlign.center,
            maxLines: 2,
            minFontSize: 10,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.b3.copyWith(
              height: 1.25,
              color: StaticColor.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          AppButton(
            label: buttonLabel,
            onPressed: onTap ?? () {},
            height: 44,
            borderRadius: 24,
            backgroundColor: StaticColor.primaryPink,
            foregroundColor: StaticColor.surface,
            textStyle: AppTypography.button1.copyWith(
              color: StaticColor.surface,
            ),
          ),
        ],
      ),
    );
  }
}
