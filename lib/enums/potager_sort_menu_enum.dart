enum SelectedButton {
  tous,
  legumes,
  graines,
  fruits,
}

extension SelectedButtonExtension on SelectedButton {
  static const names = {
    SelectedButton.tous: 'TOUS',
    SelectedButton.legumes: 'LEGUMES',
    SelectedButton.graines: 'GRAINES',
    SelectedButton.fruits: 'FRUITS'
  };

  String get name => names[this];
}
