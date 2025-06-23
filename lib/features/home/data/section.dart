class Section {
  final int id;
  final String title;
  bool isExpanded;
  bool isHovered;

  Section(
    this.id,
    this.title,
    this.isExpanded,
    this.isHovered,
  );

  @override
  bool operator ==(Object other) => other is Section && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
