import 'package:flutter/material.dart';
import '../formats.dart';
import '../widgets/app_navigation.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.format});
  final DataFormat format;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(format.name)),
    body: SafeArea(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: ClipRRect(borderRadius: BorderRadius.circular(18),
                child: Image.asset('assets/images/${format.file}.png',
                  semanticLabel: 'Пример ${format.name}')))),
            const SizedBox(height: 28),
            Text(format.description, style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(formatDetails[format.file]!,
              style: const TextStyle(fontSize: 17, height: 1.5)),
          ],
        ),
      )),
    )),
    bottomNavigationBar: AppNavigation(index: 0,
      onSelect: (index) => Navigator.pop(context, index)),
  );
}

const formatDetails = {
  'json': 'JSON представляет данные в виде объектов и массивов. '
      'Ключи объектов записываются в двойных кавычках. '
      'Значениями могут быть строки, числа, логические значения, null, '
      'объекты и массивы. Формат удобен для обмена данными между приложениями. '
      'Стандартный JSON не допускает комментариев и запятых после последнего элемента.',
  'xml': 'XML описывает структуру документа с помощью тегов и атрибутов. '
      'Элементы могут быть вложенными; документ имеет один корневой элемент. '
      'Имена тегов чувствительны к регистру. XML используется в документах '
      'и обмене структурированными данными. Специальные символы в тексте '
      'при необходимости записываются через ссылки на сущности.',
  'csv': 'CSV представляет таблицу: строка соответствует записи, '
      'а поля разделяются разделителем. В распространённом варианте это запятая. '
      'Поле с разделителем или переводом строки заключается в двойные кавычки; '
      'кавычка внутри поля удваивается. При обмене CSV важно согласовать '
      'кодировку, разделитель и наличие строки заголовков.',
  'yaml': 'YAML используется для читаемого человеком представления данных, '
      'в том числе конфигурации. Он поддерживает отображения, последовательности '
      'и скалярные значения. Вложенность в блочном стиле задаётся отступами '
      'из пробелов. Символ # начинает комментарий вне кавычек. '
      'Для строк с неоднозначным значением полезно явно использовать кавычки.',
  'toml': 'TOML предназначен для конфигурационных файлов. '
      'Данные задаются парами ключ = значение, таблицы обозначаются '
      'заголовками в квадратных скобках. Поддерживаются строки, числа, '
      'логические значения, массивы и значения даты и времени. '
      'Комментарии начинаются с # вне строк. Структура разделов '
      'позволяет группировать настройки по назначению.',
};
