import 'package:flutter/material.dart';

class DataFormat {
  const DataFormat(
    this.name, this.file, this.description, this.icon,
  );

  final String name;
  final String file;
  final String description;
  final IconData icon;
}

const formats = [
  DataFormat('JSON', 'json',
      'Объекты и массивы для обмена данными.', Icons.data_object),
  DataFormat('XML', 'xml',
      'Структурированные документы с тегами.', Icons.code),
  DataFormat('CSV', 'csv',
      'Табличные данные с разделителями.', Icons.table_chart),
  DataFormat('YAML', 'yaml',
      'Настройки с вложенностью на основе отступов.',
      Icons.settings),
  DataFormat('TOML', 'toml',
      'Файлы конфигурации с ключами и секциями.',
      Icons.description),
];

