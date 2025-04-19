#Использовать "helpers"

&Тест
Процедура ПустойТест() Экспорт
	
	ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);

	ПроверяемоеЗначение = ПарсерИнформацииОПроцессореLinux.Распарсить("", "");

	ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение);

КонецПроцедуры

&Тест
Процедура НеверноеФорматирование() Экспорт
	
	ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);

	ПроверяемоеЗначение = ПарсерИнформацииОПроцессореLinux.Распарсить("malformedkey: malformedvalue\n\nmalformedkey2: malformedvalue2", "");

	ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение);

КонецПроцедуры

&Тест
Процедура ОдинПроцессорДваЯдра() Экспорт
	
	ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);
	ОжидаемоеЗначение.ИмяПроцессора = "Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz";
	ОжидаемоеЗначение.КоличествоПроцессоров = 1;
	ОжидаемоеЗначение.КоличествоЯдер = 2;
	ОжидаемоеЗначение.КоличествоЛогическихПроцессоров = 4;
	ОжидаемоеЗначение.НоминальнаяЧастота = 2300000000;
	ОжидаемоеЗначение.МаксимальнаяЧастота = 2300000000;

	CpuInfo = ТестированиеИнформацииОПроцессоре.ПрочитатьФайл("ProcCpuInfoRealOneProcessorTwoCores.txt");
	ПроверяемоеЗначение = ПарсерИнформацииОПроцессореLinux.Распарсить(CpuInfo, "");

	ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение);

КонецПроцедуры

&Тест
Процедура ОдинПроцессорЧетыреЯдра() Экспорт
	
	ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);
	ОжидаемоеЗначение.ИмяПроцессора = "Intel(R) Core(TM) i7-4710MQ CPU @ 2.50GHz";
	ОжидаемоеЗначение.КоличествоПроцессоров = 1;
	ОжидаемоеЗначение.КоличествоЯдер = 4;
	ОжидаемоеЗначение.КоличествоЛогическихПроцессоров = 8;
	ОжидаемоеЗначение.НоминальнаяЧастота = 2500000000;
	ОжидаемоеЗначение.МаксимальнаяЧастота = 2500000000;

	CpuInfo = ТестированиеИнформацииОПроцессоре.ПрочитатьФайл("ProcCpuInfoRealOneProcessorFourCores.txt");
	ПроверяемоеЗначение = ПарсерИнформацииОПроцессореLinux.Распарсить(CpuInfo, "");

	ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение);

КонецПроцедуры

&Тест
Процедура AmdRyzen9_7950X() Экспорт
	
	ОжидаемоеЗначение = Новый ИнформацияОПроцессоре(Ложь);
	ОжидаемоеЗначение.ИмяПроцессора = "AMD Ryzen 9 7950X 16-Core Processor";
	ОжидаемоеЗначение.КоличествоПроцессоров = 1;
	ОжидаемоеЗначение.КоличествоЯдер = 16;
	ОжидаемоеЗначение.КоличествоЛогическихПроцессоров = 32;
	ОжидаемоеЗначение.НоминальнаяЧастота = 5881000000;
	ОжидаемоеЗначение.МаксимальнаяЧастота = 5881000000;
	ОжидаемоеЗначение.Архитектура = АрхитектурыПроцессоров.X64;

	CpuInfo = ТестированиеИнформацииОПроцессоре.ПрочитатьФайл("ryzen9-cpuinfo.txt");
	Lscpu = 
	"
    |       Architecture:             x86_64
    |         CPU op-mode(s):         32-bit, 64-bit
    |         Address sizes:          48 bits physical, 48 bits virtual
    |         Byte Order:             Little Endian
    |       CPU(s):                   32
    |         On-line CPU(s) list:    0-31
    |       Vendor ID:                AuthenticAMD
    |         Model name:             AMD Ryzen 9 7950X 16-Core Processor
    |           CPU family:           25
    |           Model:                97
    |           Thread(s) per core:   2
    |           Core(s) per socket:   16
    |           Socket(s):            1
    |           Stepping:             2
    |           CPU(s) scaling MHz:   41%
    |           CPU max MHz:          5881.0000
    |           CPU min MHz:          400.0000
    |           BogoMIPS:             8983.23
    |           Flags:                fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good amd_lbr_v2 nopl nonstop_tsc cpuid extd_apicid aperfmperf rapl 
    |                                 pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb
    |                                  bpext perfctr_llc mwaitx cpb cat_l3 cdp_l3 hw_pstate ssbd mba perfmon_v2 ibrs ibpb stibp ibrs_enhanced vmmcall fsgsbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a avx512f avx512dq rdseed adx smap avx512ifma clflushopt clwb avx512
    |                                 cd sha_ni avx512bw avx512vl xsaveopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local user_shstk avx512_bf16 clzero irperf xsaveerptr rdpru wbnoinvd cppc arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean
    |                                  flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif x2avic v_spec_ctrl vnmi avx512vbmi umip pku ospke avx512_vbmi2 gfni vaes vpclmulqdq avx512_vnni avx512_bitalg avx512_vpopcntdq rdpid overflow_recov succo
    |                                 r smca fsrm flush_l1d
	|";

	ПроверяемоеЗначение = ПарсерИнформацииОПроцессореLinux.Распарсить(CpuInfo, Lscpu);

	ТестированиеИнформацииОПроцессоре.ПроверитьРавенство(ПроверяемоеЗначение, ОжидаемоеЗначение);

КонецПроцедуры

&Тест
Процедура ТестДолженИзвлечьНоминальнуюЧастоту() Экспорт
	
	ТестовыеСлучаи = Новый Соответствие();
	ТестовыеСлучаи.Вставить("model name: Intel(R) Core(TM) i7-4710MQ CPU @ 2.50GHz", 2.5);
	ТестовыеСлучаи.Вставить("model name: Intel(R) Core(TM) i5-6200U CPU @ 2.30GHz", 2.3);
	ТестовыеСлучаи.Вставить("model name: Intel(R) Core(TM) i5-2500 CPU @ 3.30GHz", 3.3);
	ТестовыеСлучаи.Вставить("model name: Unknown processor with 2 cores and hyper threading, Unknown processor with 4 cores", 0);
	ТестовыеСлучаи.Вставить("
	|model name: Intel(R) Core(TM) i5-2500 CPU @ 3.30GHz
	|max freq: 3500", 3.3);

	Для Каждого ТестовыйСлучай Из ТестовыеСлучаи Цикл

		ОжидаемаяЧастота = КонвертацияЗначенийCpuInfo.ГигагерцыВГерцы(ТестовыйСлучай.Значение);

		ИнформацияОПроцессоре = ПарсерИнформацииОПроцессореLinux.Распарсить(ТестовыйСлучай.Ключ, "");
		Ожидаем.Что(ИнформацияОПроцессоре.НоминальнаяЧастота, ТестовыйСлучай.Ключ).Равно(ОжидаемаяЧастота);

	КонецЦикла;

КонецПроцедуры