class Filter {
  int minPrice = 0;
  int maxPrice = 50000;
  int tag;
  int categoryId;
  bool featured;
  String search;
  String attribute;
  List<int> attributeTetms;

  Filter({this.minPrice, this.maxPrice});
}
