abstract interface class EntityModelMapper<Entity, Model> {
  Entity toEntity(Model model);
  Model fromEntity(Entity model);
}

abstract interface class EntityMapper<Entity, Model> {
  Entity toEntity(Model map);
}

abstract interface class ModelMapper<Model, Entity> {
  Entity fromModel(Model model);
}
