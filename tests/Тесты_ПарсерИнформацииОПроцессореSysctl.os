#Использовать "helpers"

&Тест
Процедура ПустойТест() Экспорт
	
	ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);

	ПроверяемоеЗначение = ПарсерИнформацииОПроцессореSysctl.Распарсить("");

	ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение);

КонецПроцедуры

&Тест
Процедура НеверноеФорматирование() Экспорт
	
	ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);

	Sysctl = "malformedkey: malformedvalue\n\nmalformedkey2: malformedvalue2";
	ПроверяемоеЗначение = ПарсерИнформацииОПроцессореSysctl.Распарсить(Sysctl);

	ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение);

КонецПроцедуры

&Тест
Процедура ОдинПроцессорЧетыреЯдра() Экспорт
	
	ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);
	ОжидаемоеЗначение.ИмяПроцессора = "Intel(R) Core(TM) i7-4770HQ CPU @ 2.20GHz";
	ОжидаемоеЗначение.КоличествоПроцессоров = 1;
	ОжидаемоеЗначение.КоличествоЯдер = 4;
	ОжидаемоеЗначение.КоличествоЛогическихПроцессоров = 8;
	ОжидаемоеЗначение.НоминальнаяЧастота = 2200000000;
	ОжидаемоеЗначение.МаксимальнаяЧастота = 2200000000;
	ОжидаемоеЗначение.Архитектура = АрхитектурыПроцессоров.X64;

	Sysctl = ТестированиеИнформацииОПроцессоре.ПрочитатьФайл("SysctlRealOneProcessorFourCores.txt");
	ПроверяемоеЗначение = ПарсерИнформацииОПроцессореSysctl.Распарсить(Sysctl);

	ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение);

КонецПроцедуры

&Тест
Процедура ТестАрхитектуры() Экспорт
	
	ТестовыеСлучаи = Новый Соответствие();
	ТестовыеСлучаи.Вставить(
		"hw.cputype: 16777223
		|hw.cpu64bit_capable: 1", АрхитектурыПроцессоров.X64);

	ТестовыеСлучаи.Вставить(
		"hw.cputype: 7
		|hw.cpu64bit_capable: 0", АрхитектурыПроцессоров.X86);	

	ТестовыеСлучаи.Вставить(
		"hw.cputype: 7
		|hw.cpu64bit_capable: 1", АрхитектурыПроцессоров.X64);

	ТестовыеСлучаи.Вставить(
		"hw.cputype: 16777228
		|hw.cpu64bit_capable: 1", АрхитектурыПроцессоров.ARM64);

	ТестовыеСлучаи.Вставить(
		"hw.cputype: 12
		|hw.cpu64bit_capable: 0", АрхитектурыПроцессоров.ARM);

	ТестовыеСлучаи.Вставить(
		"hw.cputype: 12
		|hw.cpu64bit_capable: 1", АрхитектурыПроцессоров.ARM64);	

	ТестовыеСлучаи.Вставить("", Неопределено);
				
	ПризнакиЭмуляцииX64 = Новый Массив();
	ПризнакиЭмуляцииX64.Добавить(Истина);
	ПризнакиЭмуляцииX64.Добавить(Ложь);

	Для Каждого ТестовыйСлучай Из ТестовыеСлучаи Цикл

		Sysctl = ТестовыйСлучай.Ключ;

		Для Каждого ЭмуляцияX64 Из ПризнакиЭмуляцииX64 Цикл

			Если ЭмуляцияX64 Тогда
				ОжидаемаяАрхитектура = АрхитектурыПроцессоров.ARM64;
			Иначе
				ОжидаемаяАрхитектура = ТестовыйСлучай.Значение;
			КонецЕсли;

			ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);
			ОжидаемоеЗначение.Архитектура = ОжидаемаяАрхитектура;
		
			ПроверяемоеЗначение = ПарсерИнформацииОПроцессореSysctl.Распарсить(Sysctl, ЭмуляцияX64);
			
			Описание = СтрШаблон("Sysctl: %1
			|Эмуляция X64: %2", Sysctl, ЭмуляцияX64);

			ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение, Описание);

		КонецЦикла;
	КонецЦикла;

КонецПроцедуры