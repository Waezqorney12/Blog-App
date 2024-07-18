class UserEntities {
  final String id;
  final String email;
  final String name;
  UserEntities({
    required this.id,
    required this.email,
    required this.name,
  });

/* #In case forgot why i put my entities on core
  Core cannot depending on other layer, 
  so it can be used by other layer but other layer can depend on core
*/
}
