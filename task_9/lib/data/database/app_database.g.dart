// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FormatsTable extends Formats with TableInfo<$FormatsTable, FormatRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FormatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileMeta = const VerificationMeta('file');
  @override
  late final GeneratedColumn<String> file = GeneratedColumn<String>(
    'file',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullDescriptionMeta = const VerificationMeta(
    'fullDescription',
  );
  @override
  late final GeneratedColumn<String> fullDescription = GeneratedColumn<String>(
    'full_description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    file,
    description,
    fullDescription,
    imagePath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'formats';
  @override
  VerificationContext validateIntegrity(
    Insertable<FormatRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('file')) {
      context.handle(
        _fileMeta,
        file.isAcceptableOrUnknown(data['file']!, _fileMeta),
      );
    } else if (isInserting) {
      context.missing(_fileMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('full_description')) {
      context.handle(
        _fullDescriptionMeta,
        fullDescription.isAcceptableOrUnknown(
          data['full_description']!,
          _fullDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fullDescriptionMeta);
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    } else if (isInserting) {
      context.missing(_imagePathMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FormatRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FormatRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      file: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      fullDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_description'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      )!,
    );
  }

  @override
  $FormatsTable createAlias(String alias) {
    return $FormatsTable(attachedDatabase, alias);
  }
}

class FormatRow extends DataClass implements Insertable<FormatRow> {
  final int id;
  final String name;
  final String file;
  final String description;
  final String fullDescription;
  final String imagePath;
  const FormatRow({
    required this.id,
    required this.name,
    required this.file,
    required this.description,
    required this.fullDescription,
    required this.imagePath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['file'] = Variable<String>(file);
    map['description'] = Variable<String>(description);
    map['full_description'] = Variable<String>(fullDescription);
    map['image_path'] = Variable<String>(imagePath);
    return map;
  }

  FormatsCompanion toCompanion(bool nullToAbsent) {
    return FormatsCompanion(
      id: Value(id),
      name: Value(name),
      file: Value(file),
      description: Value(description),
      fullDescription: Value(fullDescription),
      imagePath: Value(imagePath),
    );
  }

  factory FormatRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FormatRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      file: serializer.fromJson<String>(json['file']),
      description: serializer.fromJson<String>(json['description']),
      fullDescription: serializer.fromJson<String>(json['fullDescription']),
      imagePath: serializer.fromJson<String>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'file': serializer.toJson<String>(file),
      'description': serializer.toJson<String>(description),
      'fullDescription': serializer.toJson<String>(fullDescription),
      'imagePath': serializer.toJson<String>(imagePath),
    };
  }

  FormatRow copyWith({
    int? id,
    String? name,
    String? file,
    String? description,
    String? fullDescription,
    String? imagePath,
  }) => FormatRow(
    id: id ?? this.id,
    name: name ?? this.name,
    file: file ?? this.file,
    description: description ?? this.description,
    fullDescription: fullDescription ?? this.fullDescription,
    imagePath: imagePath ?? this.imagePath,
  );
  FormatRow copyWithCompanion(FormatsCompanion data) {
    return FormatRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      file: data.file.present ? data.file.value : this.file,
      description: data.description.present
          ? data.description.value
          : this.description,
      fullDescription: data.fullDescription.present
          ? data.fullDescription.value
          : this.fullDescription,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FormatRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('file: $file, ')
          ..write('description: $description, ')
          ..write('fullDescription: $fullDescription, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, file, description, fullDescription, imagePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FormatRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.file == this.file &&
          other.description == this.description &&
          other.fullDescription == this.fullDescription &&
          other.imagePath == this.imagePath);
}

class FormatsCompanion extends UpdateCompanion<FormatRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> file;
  final Value<String> description;
  final Value<String> fullDescription;
  final Value<String> imagePath;
  const FormatsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.file = const Value.absent(),
    this.description = const Value.absent(),
    this.fullDescription = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  FormatsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String file,
    required String description,
    required String fullDescription,
    required String imagePath,
  }) : name = Value(name),
       file = Value(file),
       description = Value(description),
       fullDescription = Value(fullDescription),
       imagePath = Value(imagePath);
  static Insertable<FormatRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? file,
    Expression<String>? description,
    Expression<String>? fullDescription,
    Expression<String>? imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (file != null) 'file': file,
      if (description != null) 'description': description,
      if (fullDescription != null) 'full_description': fullDescription,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  FormatsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? file,
    Value<String>? description,
    Value<String>? fullDescription,
    Value<String>? imagePath,
  }) {
    return FormatsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      file: file ?? this.file,
      description: description ?? this.description,
      fullDescription: fullDescription ?? this.fullDescription,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (file.present) {
      map['file'] = Variable<String>(file.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (fullDescription.present) {
      map['full_description'] = Variable<String>(fullDescription.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FormatsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('file: $file, ')
          ..write('description: $description, ')
          ..write('fullDescription: $fullDescription, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FormatsTable formats = $FormatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [formats];
}

typedef $$FormatsTableCreateCompanionBuilder = FormatsCompanion Function({
  Value<int> id,
  required String name,
  required String file,
  required String description,
  required String fullDescription,
  required String imagePath,
});
typedef $$FormatsTableUpdateCompanionBuilder = FormatsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> file,
  Value<String> description,
  Value<String> fullDescription,
  Value<String> imagePath,
});

class $$FormatsTableFilterComposer
    extends Composer<_$AppDatabase, $FormatsTable> {
  $$FormatsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get file => $composableBuilder(
    column: $table.file,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullDescription => $composableBuilder(
    column: $table.fullDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FormatsTableOrderingComposer
    extends Composer<_$AppDatabase, $FormatsTable> {
  $$FormatsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get file => $composableBuilder(
    column: $table.file,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullDescription => $composableBuilder(
    column: $table.fullDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FormatsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FormatsTable> {
  $$FormatsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get file =>
      $composableBuilder(column: $table.file, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullDescription => $composableBuilder(
    column: $table.fullDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);
}

class $$FormatsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FormatsTable,
          FormatRow,
          $$FormatsTableFilterComposer,
          $$FormatsTableOrderingComposer,
          $$FormatsTableAnnotationComposer,
          $$FormatsTableCreateCompanionBuilder,
          $$FormatsTableUpdateCompanionBuilder,
          (FormatRow, BaseReferences<_$AppDatabase, $FormatsTable, FormatRow>),
          FormatRow,
          PrefetchHooks Function()
        > {
  $$FormatsTableTableManager(_$AppDatabase db, $FormatsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FormatsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FormatsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FormatsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> file = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> fullDescription = const Value.absent(),
                Value<String> imagePath = const Value.absent(),
              }) => FormatsCompanion(
                id: id,
                name: name,
                file: file,
                description: description,
                fullDescription: fullDescription,
                imagePath: imagePath,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String file,
                required String description,
                required String fullDescription,
                required String imagePath,
              }) => FormatsCompanion.insert(
                id: id,
                name: name,
                file: file,
                description: description,
                fullDescription: fullDescription,
                imagePath: imagePath,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FormatsTable, FormatRow>(table),
                  BaseReferences<_$AppDatabase, $FormatsTable, FormatRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FormatsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FormatsTable,
      FormatRow,
      $$FormatsTableFilterComposer,
      $$FormatsTableOrderingComposer,
      $$FormatsTableAnnotationComposer,
      $$FormatsTableCreateCompanionBuilder,
      $$FormatsTableUpdateCompanionBuilder,
      (FormatRow, BaseReferences<_$AppDatabase, $FormatsTable, FormatRow>),
      FormatRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FormatsTableTableManager get formats =>
      $$FormatsTableTableManager(_db, _db.formats);
}
