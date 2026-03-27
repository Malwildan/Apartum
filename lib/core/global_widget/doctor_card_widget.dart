import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      height: 140,
      constraints: const BoxConstraints(minHeight: 140),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color.fromARGB(255, 255, 211, 219), Color(0xFFFFFFFF)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              height: 142,
              child: Image(
                image: image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF3F4F6),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF9CA3AF),
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
                    maxLines: 2,
                    minFontSize: 16,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2A2A2A),
                    ),
                  ),
                  const SizedBox(height: 3),
                  AutoSizeText(
                    specializationAndExperience,
                    maxLines: 2,
                    minFontSize: 12,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    priceText,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2A2A2A),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      height: 25,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFFFF4D6D),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          textStyle: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
  }
}
