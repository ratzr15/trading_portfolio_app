abstract class PortfolioInstrumentsDataSource {
  Future<Map<String, dynamic>> call({
    required String userIdentifier,
  });
}
