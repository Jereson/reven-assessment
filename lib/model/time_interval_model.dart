import 'package:raven_assessment/utilities/image_util.dart';

class TimeIntervalModel {
  final String item;
  final bool? isTime;
  final bool? isImage;

  TimeIntervalModel({required this.item, this.isTime, this.isImage});
}

List<TimeIntervalModel> timeIntervalData = [
  TimeIntervalModel(item: 'Time'),
  TimeIntervalModel(item: '1m', isTime: true),
  TimeIntervalModel(item: '1H', isTime: true),
  TimeIntervalModel(item: '2H', isTime: true),
  TimeIntervalModel(item: '4H', isTime: true),
  TimeIntervalModel(item: '1D', isTime: true),
  TimeIntervalModel(item: '1M', isTime: true),
  TimeIntervalModel(item: imgDropdown, isImage: true),
  TimeIntervalModel(item: imgCandleChart, isImage: true),
  TimeIntervalModel(item: 'Fx'),
];
