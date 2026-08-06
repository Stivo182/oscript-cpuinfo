#Область ПрограммныйИнтерфейс

// Получает записи Win32_Processor через COM WMI.
//
// Возвращаемое значение:
//   Массив из Структура - записи Win32_Processor:
//     * Name - Строка - имя процессора;
//     * Architecture - Строка, Число - код архитектуры процессора;
//     * NumberOfCores - Строка, Число - количество физических ядер;
//     * NumberOfLogicalProcessors - Строка, Число - количество логических процессоров;
//     * MaxClockSpeed - Строка, Число - максимальная частота в мегагерцах, 0 если неизвестна.
Функция Получить() Экспорт

	ЛокаторWmi = Новый COMОбъект("WbemScripting.SWbemLocator");
	СлужбаWmi = ЛокаторWmi.ConnectServer(".", "root\cimv2");
	ЭкземплярыПроцессоров = СлужбаWmi.ExecQuery(
		"SELECT Architecture, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed FROM Win32_Processor"
	);

	ЗаписиПроцессоров = Новый Массив();
	Для Каждого ЭкземплярПроцессора Из ЭкземплярыПроцессоров Цикл
		ЗаписиПроцессоров.Добавить(Новый Структура(
			"Name, Architecture, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed",
			ЭкземплярПроцессора.Name,
			ЭкземплярПроцессора.Architecture,
			ЭкземплярПроцессора.NumberOfCores,
			ЭкземплярПроцессора.NumberOfLogicalProcessors,
			ЭкземплярПроцессора.MaxClockSpeed
		));
	КонецЦикла;

	Возврат ЗаписиПроцессоров;

КонецФункции

#КонецОбласти
