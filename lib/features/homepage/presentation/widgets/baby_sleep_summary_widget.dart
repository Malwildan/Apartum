import 'package:apartum/features/homepage/data/repositories/sleep_repository_impl.dart';
import 'package:apartum/features/homepage/domain/entities/day_sleep_entity.dart';
import 'package:apartum/features/homepage/domain/usecases/get_weekly_sleep_usecase.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'day_label_widget.dart';
import 'sleep_bar_widget.dart';

class BabySleepSummaryWidget extends StatelessWidget {
  BabySleepSummaryWidget({super.key});

  final GetWeeklySleep _getWeeklySleep = GetWeeklySleep(SleepRepositoryImpl());

  @override
  Widget build(BuildContext context) {
    final weekData = _getWeeklySleep();
    const chartHeight = 207.0;
    const plotHeight = chartHeight - 62.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF4F4F4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCFCFD2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 10),
          _buildStatusBanner(),
          const SizedBox(height: 12),
          _buildChart(
            weekData,
            chartHeight: chartHeight,
            plotHeight: plotHeight,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ringkasan',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF151515),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hari ini',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: Color(0xFF222222),
              ),
            ),
            const SizedBox(height: 3),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A78),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '12 Maret 2026',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: const Color(0xFFD7ECEC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF6EC6C7), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Color(0xFF21494A),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              'i',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Status Hari Ini: Aman',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2A3D3E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Tidak ada tanda bahaya dari catatan terakhir',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF2F3F40),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Row(
            children: [
              Text(
                'Lihat Detail',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2A4A4A),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF2A4A4A),
                ),
              ),
              const SizedBox(width: 3),
              const Icon(Icons.chevron_right, color: Color(0xFF2A4A4A), size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChart(
    List<DaySleepData> weekData, {
    required double chartHeight,
    required double plotHeight,
  }) {
    final timeLabels = [
      '08.00',
      '10.00',
      '12.00',
      '14.00',
      '16.00',
      '18.00',
      '20.00',
      '22.00',
      '00.00',
      '02.00',
      '04.00',
      '06.00',
    ];

    return SizedBox(
      height: chartHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            padding: const EdgeInsets.only(top: 2),
            child: SizedBox(
              height: plotHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: timeLabels
                    .map(
                      (label) => Text(
                        label,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF5F5F5F),
                          height: 1,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final chartWidth = constraints.maxWidth;
                final barWidth = chartWidth / weekData.length;
                const barWidthFactor = 0.70;

                return Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: plotHeight,
                      child: Row(
                        children: List.generate(weekData.length, (i) {
                          return SizedBox(
                            width: barWidth,
                            child: Center(
                              child: SleepBarWidget(
                                data: weekData[i],
                                plotHeight: plotHeight,
                                barWidth: barWidth * barWidthFactor,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: List.generate(weekData.length, (i) {
                          return SizedBox(
                            width: barWidth,
                            child: DayLabelWidget(data: weekData[i]),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
