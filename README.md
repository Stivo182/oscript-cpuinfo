# cpuinfo

Информация о процессоре через OneScript

## Установка

``` bash
opm install cpuinfo
```

## Использование

``` bsl
#Использовать cpuinfo

ИнформацияОПроцессоре = Новый ИнформацияОПроцессоре();

// Получение краткого описания
Сообщить("Краткое описание:");
Сообщить(ИнформацияОПроцессоре.КраткоеОписание());

// Получение полного описания
Сообщить("Полное описание:");
Сообщить(ИнформацияОПроцессоре.ПолноеОписание());
```

Пример вывода:
```
Краткое описание:
Intel Core i7-8700 CPU 3.20GHz (Coffee Lake)

Полное описание:
Intel Core i7-8700 CPU 3.20GHz (Max: 3.19GHz) (Coffee Lake), 1 CPU, 12 logical and 6 physical cores
```

## Публичный интерфейс

### ИнформацияОПроцессоре

#### Поля:
* ИмяПроцессора
* КоличествоПроцессоров
* КоличествоЯдер
* КоличествоЛогическихПроцессоров
* НоминальнаяЧастота
* МаксимальнаяЧастота
* Архитектура - см. АрхитектурыПроцессоров

#### Методы:
* КраткоеОписание
* ПолноеОписание

### АрхитектурыПроцессоров

#### Значения:
* X86
* X64
* ARM
* ARM64

## Источники получения информации

1. /proc/cpuinfo (Linux)
2. wmic cpu get (Windows)
3. sysctl (MacOS)
4. lscpu (Unix/Linux)
