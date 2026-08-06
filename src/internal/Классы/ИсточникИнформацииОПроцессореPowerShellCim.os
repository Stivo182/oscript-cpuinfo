#Использовать 1commands
#Использовать fs

#Область ПрограммныйИнтерфейс

// Получает записи Win32_Processor через PowerShell CIM.
//
// Возвращаемое значение:
//   Массив из Структура - записи Win32_Processor:
//     * Name - Строка - имя процессора;
//     * Architecture - Строка, Число - код архитектуры процессора;
//     * NumberOfCores - Строка, Число - количество физических ядер;
//     * NumberOfLogicalProcessors - Строка, Число - количество логических процессоров;
//     * MaxClockSpeed - Строка, Число - максимальная частота в мегагерцах, 0 если неизвестна.
Функция Получить() Экспорт

	Команда = КомандаPowerShellCim();
	Команда.Исполнить();

	Возврат ПарсерДанныхПроцессораCim.Распарсить(Команда.ПолучитьВывод());

КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция КомандаPowerShellCim()

	ПутьКPowerShell = ПолучитьПеременнуюСреды("SystemRoot")
		+ "\System32\WindowsPowerShell\v1.0\powershell.exe";

	Сценарий = "Get-CimInstance Win32_Processor"
		+ " -Property Architecture, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed"
		+ " -ErrorAction Stop"
		+ " | Select-Object Architecture, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed"
		+ " | ConvertTo-Json -Compress";

	Команда = Новый Команда;
	Команда.УстановитьИсполнениеЧерезКомандыСистемы(Ложь);
	Команда.УстановитьПравильныйКодВозврата(0);

	Если ФС.ФайлСуществует(ПутьКPowerShell) Тогда
		Команда.УстановитьКоманду(ПутьКPowerShell);
	Иначе
		Команда.УстановитьКоманду("powershell");
	КонецЕсли;

	Команда.ДобавитьПараметр("-NoProfile");
	Команда.ДобавитьПараметр("-NonInteractive");
	Команда.ДобавитьПараметр("-Command");
	Команда.ДобавитьПараметр("""" + Сценарий + """");

	Возврат Команда;

КонецФункции

#КонецОбласти
