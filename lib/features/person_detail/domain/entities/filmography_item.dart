class FilmographyItem {
  final int id;
  final String title;
  final String character;
  final int? year;
  final String mediaType; // 'movie' or 'tv'
  final String? posterPath;

  FilmographyItem({
    required this.id,
    required this.title,
    required this.character,
    this.year,
    required this.mediaType,
    this.posterPath,
  });
}
