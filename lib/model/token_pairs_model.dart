import 'package:raven_assessment/utilities/image_util.dart';

class TokenPairsModel {
  final String pairs;
  final List<String> image;

  TokenPairsModel({required this.pairs, required this.image});
}

List<TokenPairsModel> tokenPairsData = [
  TokenPairsModel(pairs: 'BTC/USDT', image: [imgBtc, imgUsdt]),
  TokenPairsModel(pairs: 'BNB/USDT', image: [imgBnb, imgUsdt]),
  TokenPairsModel(pairs: 'ETH/USDT', image: [imgEth, imgUsdt]),
];
