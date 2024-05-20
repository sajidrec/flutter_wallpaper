class Urls {
  static const String _baseUrl = "https://api.pexels.com/v1";

  static String getSearchUrl({
    required String searchKeyword,
    required int pageNumber,
  }) {
    return "$_baseUrl/search/?query=$searchKeyword&page=$pageNumber";
  }

  static String getRandomImageListUrl({
    required int pageNumber,
  }) {
    return "$_baseUrl/curated?page=$pageNumber";
  }
}
