&МониторингПамяти
&КоличествоИтераций(5)
&КоличествоПрогревочныхИтераций(0)
&КоличествоВызововЗаИтерацию(1)
&КолонкаМакс
Процедура ПриСозданииОбъекта()
КонецПроцедуры

&Бенчмарк(Наименование = "COM WMI")
&Эталон
Процедура ComWmi() Экспорт

	ЛокаторWmi = Новый COMОбъект("WbemScripting.SWbemLocator");
	СлужбаWmi = ЛокаторWmi.ConnectServer(".", "root\cimv2");
	Процессоры = СлужбаWmi.ExecQuery(
		"SELECT Architecture, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed FROM Win32_Processor");

	Для Каждого Процессор Из Процессоры Цикл
		Архитектура = Процессор.Architecture;
		Имя = Процессор.Name;
		КоличествоЯдер = Процессор.NumberOfCores;
		КоличествоЛогическихПроцессоров = Процессор.NumberOfLogicalProcessors;
		МаксимальнаяЧастота = Процессор.MaxClockSpeed;
	КонецЦикла;

КонецПроцедуры

&Бенчмарк(Наименование = "WMIC")
Процедура Wmic() Экспорт
	
	Команда = Новый Команда();
	Команда.УстановитьКоманду("C:\Windows\System32\wbem\WMIC.exe");
	Команда.ДобавитьПараметр("cpu get Architecture, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed /Format:List");
	КодВозврата = Команда.Исполнить();

	Если Не КодВозврата = 0 Тогда
		ВызватьИсключение Команда.ПолучитьВывод();
	КонецЕсли;

КонецПроцедуры

&Бенчмарк(Наименование = "PowerShell CIM")
Процедура Cim() Экспорт
	
	Команда = Новый Команда();
	Команда.УстановитьКоманду("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe");
	Команда.ДобавитьПараметр("""Get-CimInstance Win32_Processor | Format-List Architecture, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed""");
	КодВозврата = Команда.Исполнить();

	Если Не КодВозврата = 0 Тогда
		ВызватьИсключение Команда.ПолучитьВывод();
	КонецЕсли;

КонецПроцедуры