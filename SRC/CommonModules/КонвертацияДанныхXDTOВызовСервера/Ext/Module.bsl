
&ИзменениеИКонтроль("ЗаполнитьСписокОбъектовКонфигурации")
Процедура PEN007_ЗаполнитьСписокОбъектовКонфигурации(ПолучательОбъектовКонфигурации, ДанныеФильтра, ОбластьПрименения)
	ПолучательОбъектовКонфигурации.Очистить();
	Если НЕ ЗначениеЗаполнено(ДанныеФильтра) Тогда
		Возврат;
	КонецЕсли;
	Запрос = Новый Запрос;

	Если ОбластьПрименения.ДляПРО Тогда
		Запрос.УстановитьПараметр("ПланОбмена",ДанныеФильтра.ПланОбмена);
		Запрос.УстановитьПараметр("Владелец",ДанныеФильтра.Конфигурация);

		ТекстЗапроса = "ВЫБРАТЬ
		|	СвойстваТипы.Тип                    КАК Объект,
		|	СвойстваТипы.Ссылка.Авторегистрация КАК Авторегистрация
		|ПОМЕСТИТЬ СоставПланаОбмена
		|ИЗ
		|	Справочник.Свойства.Типы КАК СвойстваТипы
		|ГДЕ
		|	  СвойстваТипы.Ссылка.Владелец.Наименование = &ПланОбмена
		|	И СвойстваТипы.Ссылка.Владелец.Владелец = &Владелец
		|	И СвойстваТипы.Ссылка.Вид      = ЗНАЧЕНИЕ(Перечисление.ВидыСвойств.ЭлементСоставаПланаОбмена)
		|;
		|
		|ВЫБРАТЬ
		|	СправочникОбъекты.Наименование КАК Наименование,
		|	СправочникОбъекты.Ссылка КАК Ссылка
		|ИЗ
		|	Справочник.Объекты КАК СправочникОбъекты
		|
		|ЛЕВОЕ СОЕДИНЕНИЕ
		|	СоставПланаОбмена КАК СоставПланаОбмена
		|ПО
		|	СправочникОбъекты.Ссылка = СоставПланаОбмена.Объект
		|
		|ГДЕ
		|	НЕ СправочникОбъекты.ПометкаУдаления
		|	И СправочникОбъекты.ЭтоГруппа = ЛОЖЬ
		|	И СправочникОбъекты.Владелец = &Владелец
		|	И СправочникОбъекты.Наименование <> ""РегистрСведенийЗапись.СоответствиеОбъектовИнформационныхБаз""
		|	И НЕ СоставПланаОбмена.Объект ЕСТЬ NULL
		|
		|УПОРЯДОЧИТЬ ПО
		|	СправочникОбъекты.ЭтоГруппа ИЕРАРХИЯ,
		|	СправочникОбъекты.Наименование
		|";
	Иначе
		Если ТипЗнч(ДанныеФильтра) = Тип("СправочникСсылка.Релизы") Тогда
			Запрос.УстановитьПараметр("Конфигурация",ДанныеФильтра);
		ИначеЕсли ТипЗнч(ДанныеФильтра) = Тип("СписокЗначений") Тогда
			Запрос.УстановитьПараметр("Конфигурация",ДанныеФильтра[0].Значение);
		Иначе
			Запрос.УстановитьПараметр("Конфигурация",ДанныеФильтра[0]);
		КонецЕсли;
		ТекстЗапроса = "ВЫБРАТЬ РАЗЛИЧНЫЕ
		|	Объекты.Наименование КАК Наименование,
		|	Объекты.Ссылка,
		|	Объекты.Тип КАК Тип
		|ПОМЕСТИТЬ ТаблицаОбъектов
		|ИЗ Справочник.Объекты КАК Объекты
		|ГДЕ Объекты.ПометкаУдаления = ЛОЖЬ И Объекты.ЭтоГруппа = ЛОЖЬ 
		|	И Объекты.Владелец = &Конфигурация
		|#УСЛОВИЕ_ПК#
		|;
		|ВЫБРАТЬ
		|	Наименование,
		|	Ссылка
		|ИЗ ТаблицаОбъектов
		|УПОРЯДОЧИТЬ ПО Наименование";

		Если ОбластьПрименения.ДляПКПД Тогда
			ТекстУсловиеПК = "
			|	И (Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.Справочник) 
			|		ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.Перечисление)
			|		ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.ПланВидовХарактеристик))";
		Иначе	
			#Удаление
			ТекстУсловиеПК = "И (Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.Справочник) 
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.Документ)
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.РегистрСведений)
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.НаборКонстант)
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.ПланВидовХарактеристик))";
			#КонецУдаления
			#Вставка
			ТекстУсловиеПК = "И (Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.Справочник) 
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.Документ)
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.РегистрСведений)
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.НаборКонстант)
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.ПланВидовХарактеристик)
			|	ИЛИ Объекты.Тип = ЗНАЧЕНИЕ(Перечисление.ТипыОбъектов.ПланСчетов)
			|)";
			#КонецВставки
		КонецЕсли;
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса,"#УСЛОВИЕ_ПК#", ТекстУсловиеПК);
	КонецЕсли;
	Запрос.Текст = ТекстЗапроса;
	Выборка = Запрос.Выполнить().Выбрать();
	ДобавлятьВТаблицу = Истина;
	Если ТипЗнч(ПолучательОбъектовКонфигурации) = Тип("СписокЗначений") Тогда
		ДобавлятьВТаблицу = Ложь;
	КонецЕсли;

	Пока Выборка.Следующий() Цикл
		Если ДобавлятьВТаблицу Тогда
			СтрокаОбъект = ПолучательОбъектовКонфигурации.Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаОбъект, Выборка);
			СтрокаОбъект.Наименование = СокрЛП(СтрокаОбъект.Наименование);
		Иначе
			ПолучательОбъектовКонфигурации.Добавить(Выборка.Ссылка);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры
