enum PetType {
  none('none', 'Nenhum'),
  dog('dog', 'Cachorro'),
  cat('cat', 'Gato'),
  fish('fish', 'Peixe'),
  bird('bird', 'Passarinho'),
  rabbit('rabbit', 'Coelho'),
  hamster('hamster', 'Hamster'),
  turtle('turtle', 'Tartaruga'),
  guineaPig('guinea pig', 'Porquinho da Índia'),
  iguana('iguana', 'Iguana'),
  parakeet('parakeet', 'Periquito'),
  snake('snake', 'Cobra'),
  ferret('ferret', 'Furão'),
  chinchilla('chinchilla', 'Chinchila'),
  frog('frog', 'Sapo'),
  tarantula('tarantula', 'Tarântula'),
  hedgehog('hedgehog', 'Ouriço'),
  goat('goat', 'Cabra'),
  pig('pig', 'Porco'),
  duck('duck', 'Pato'),
  miniHorse('mini horse', 'Mini Cavalo');

  final String name;
  final String alias;

  const PetType(this.name, this.alias);
}
