import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ra7al/repositories/adhan_repository.dart';

class PrayerTimesList extends StatelessWidget {
  final AdhanModel timings;

  const PrayerTimesList({super.key, required this.timings});

  @override
  Widget build(BuildContext context) {
    final nextPrayer = getNextPrayer(timings);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      width: MediaQuery.of(context).size.width,

      child: Column(
        children: [
          Text(
            "السلام عليكم",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrayerTimeTile(
                title: 'Fajr',
                time: timings.fajr,
                isNext: nextPrayer == 'Fajr',
              ),
              PrayerTimeTile(
                title: 'Dhuhr',
                time: timings.dhuhr,
                isNext: nextPrayer == 'Dhuhr',
              ),
              PrayerTimeTile(
                title: 'Aser',
                time: timings.asr,
                isNext: nextPrayer == 'Aser',
              ),
              PrayerTimeTile(
                title: 'Maghrib',
                time: timings.maghrib,
                isNext: nextPrayer == 'Maghrib',
              ),
              PrayerTimeTile(
                title: 'Isha',
                time: timings.isha,
                isNext: nextPrayer == 'Isha',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PrayerTimeTile extends StatelessWidget {
  final String title;
  final String time;
  final bool isNext;
  const PrayerTimeTile({
    super.key,
    required this.title,
    required this.time,
    this.isNext = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(
            formatPrayerTime(time),
            style: TextStyle(
              color: isNext ? Colors.green : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              color: isNext ? Colors.green : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

String formatPrayerTime(String time) {
  final dateFormat = DateFormat('HH:mm');
  final parsedTime = DateFormat('HH:mm').parse(time);
  return dateFormat.format(parsedTime);
}

TimeOfDay parseTime(String time) {
  final parts = time.split(':');
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

bool isAfter(TimeOfDay a, TimeOfDay b) {
  return a.hour > b.hour || (a.hour == b.hour && a.minute > b.minute);
}

String getNextPrayer(AdhanModel timings) {
  final now = TimeOfDay.now();

  final times = {
    'Fajr': parseTime(timings.fajr),
    'Dhuhr': parseTime(timings.dhuhr),
    'Aser': parseTime(timings.asr),
    'Maghrib': parseTime(timings.maghrib),
    'Isha': parseTime(timings.isha),
  };

  for (var entry in times.entries) {
    if (isAfter(now, entry.value)) continue;
    return entry.key;
  }

  return 'Fajr';
}
