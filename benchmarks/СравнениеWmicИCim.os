&Бенчмарк
&Эталон
Процедура Wmic() Экспорт
	
	Команда = Новый Команда();
	Команда.УстановитьКоманду("C:\Windows\System32\wbem\WMIC.exe");
	Команда.ДобавитьПараметр("cpu get Architecture, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed /Format:List");
	КодВозврата = Команда.Исполнить();

	Если Не КодВозврата = 0 Тогда
		ВызватьИсключение Команда.ПолучитьВывод();
	КонецЕсли;

КонецПроцедуры

&Бенчмарк
Процедура Cim() Экспорт
	
	Команда = Новый Команда();
	Команда.УстановитьКоманду("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe");
	Команда.ДобавитьПараметр("""Get-CimInstance Win32_Processor | Format-List Architecture, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed""");
	КодВозврата = Команда.Исполнить();

	Если Не КодВозврата = 0 Тогда
		ВызватьИсключение Команда.ПолучитьВывод();
	КонецЕсли;

КонецПроцедуры