﻿
&НаКлиенте
Процедура PEN007_ОбъектКонфигурацииАвтоПодборПосле(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	ПараметрыПолученияДанных.Отбор.Вставить("Владелец", ЭтотОбъект.СписокКонфигураций[0].Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура PEN007_ОбъектКонфигурацииОкончаниеВводаТекстаПосле(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	ПараметрыПолученияДанных.Отбор.Вставить("Владелец", ЭтотОбъект.СписокКонфигураций[0].Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура PEN007_ОбъектКонфигурацииКорреспондентАвтоПодборПосле(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, Ожидание, СтандартнаяОбработка)
	
	ПараметрыПолученияДанных.Отбор.Вставить("Владелец", ЭтотОбъект.СписокКонфигурацийКорреспондент[0].Значение);
	
КонецПроцедуры

&НаКлиенте
Процедура PEN007_ОбъектКонфигурацииКорреспондентОкончаниеВводаТекстаПосле(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	
	ПараметрыПолученияДанных.Отбор.Вставить("Владелец", ЭтотОбъект.СписокКонфигурацийКорреспондент[0].Значение);
	
КонецПроцедуры
