enum TandaBahayaSection { hariIni, kemarin, lalu }

DateTime parseTandaBahayaDate(String dateStr) {
  final parts = dateStr.split('-');
  return DateTime(
    int.parse(parts[0]),
    int.parse(parts[1]),
    int.parse(parts[2]),
  );
}

String formatTandaBahayaDate(String dateStr) {
  final dt = parseTandaBahayaDate(dateStr);
  const days = ['Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'];
  const months = [
    '',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month]} ${dt.year}';
}

TandaBahayaSection getTandaBahayaSection(String dateStr) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final dt = parseTandaBahayaDate(dateStr);
  final date = DateTime(dt.year, dt.month, dt.day);
  final diff = today.difference(date).inDays;
  if (diff == 0) return TandaBahayaSection.hariIni;
  if (diff == 1) return TandaBahayaSection.kemarin;
  return TandaBahayaSection.lalu;
}

String getTandaBahayaSectionLabel(TandaBahayaSection section) {
  switch (section) {
    case TandaBahayaSection.hariIni:
      return 'Hari Ini';
    case TandaBahayaSection.kemarin:
      return 'Kemarin';
    case TandaBahayaSection.lalu:
      return 'Beberapa waktu lalu';
  }
}
