import 'package:shoppinglist/data/usecases/web_crawler_price_analysis.dart';
import 'package:shoppinglist/domain/usecases/price_analysis_usecase.dart';
import 'package:shoppinglist/main/factories/http/http.dart';

PriceAnalysisUsecase makeWebCrawlerPriceAnalysis() {
  return WebCrawlerPriceAnalysis(makeHttpAdapter());
}
