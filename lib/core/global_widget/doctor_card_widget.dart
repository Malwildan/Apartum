import 'package:apartum/core/theme/app_typography.dart';
import 'package:apartum/core/theme/app_static_color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DoctorCardWidget extends StatelessWidget {
  const DoctorCardWidget({
    super.key,
    required this.image,
    required this.doctorName,
    required this.specializationAndExperience,
    required this.priceText,
    this.buttonLabel = 'Booking',
    this.onBookingTap,
  });

  final ImageProvider image;
  final String doctorName;
  final String specializationAndExperience;
  final String priceText;
  final String buttonLabel;
  final VoidCallback? onBookingTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 144,
      constraints: const BoxConstraints(minHeight: 142),
      decoration: BoxDecoration(
        gradient: StaticColor.linearPink,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: SizedBox(
                width: 102,
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: StaticColor.background,
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.person,
                        color: StaticColor.textMuted,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      doctorName,
                      maxLines: 1,
                      minFontSize: 12,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.h3,
                    ),
                    const SizedBox(height: 3),
                    AutoSizeText(
                      specializationAndExperience,
                      maxLines: 1,
                      minFontSize: 10,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.b3Regular.copyWith(
                        color: StaticColor.iconMuted,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(priceText, style: AppTypography.h4),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        height: 25,
                        child: ElevatedButton(
                          onPressed: onBookingTap ?? () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: StaticColor.primaryPink,
                            foregroundColor: StaticColor.surface,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            textStyle: AppTypography.b3,
                          ),
                          child: Text(buttonLabel),
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
    );
  }
}
