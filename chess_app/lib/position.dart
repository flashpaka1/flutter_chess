class Position {
  int row;
  int col;

  Position(this.row, this.col);

  @override
  bool operator ==(Object other) {
    if (other is Position) {
      return row == other.row && col == other.col;
    }
    return false;
  }

  @override
  int get hashCode => '$row|$col'.hashCode;
}
