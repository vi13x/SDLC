package AutoDiaryUI {
    private import ScalarValues::*;

    part def Widget {
        attribute label : String;
        attribute content : String;
    }
    part def Screen {
        attribute title : String;
    }

    part def Dashboard :> Screen {
        attribute :>> title = "Обзор автомобиля";
        part vehicle : Widget {
            attribute :>> label = "Автомобиль";
            attribute :>> content = "Volkswagen Polo · 2018\nПробег: 86 500 км";
        }
        part service : Widget {
            attribute :>> label = "Ближайшее обслуживание";
            attribute :>> content = "Замена масла и фильтра\nДо 87 000 км или 20.11.2026\nОсталось: 500 км или 6 дней";
        }
        part insurance : Widget {
            attribute :>> label = "Страховка";
            attribute :>> content = "Полис действует до 30.11.2026\nОсталось 16 дней";
        }
        part actions : Widget {
            attribute :>> label = "Быстрые действия";
            attribute :>> content = "Обновить пробег\nДобавить ТО\nДобавить заправку";
        }
        part recent : Widget {
            attribute :>> label = "Последние записи";
            attribute :>> content = "12.11.2026 · Заправка · 40 л · 104,00 BYN\n01.10.2026 · Воздушный фильтр · 35,00 BYN";
        }
    }

    part def Maintenance :> Screen {
        attribute :>> title = "Техническое обслуживание";
        part history : Widget {
            attribute :>> label = "История обслуживания";
            attribute :>> content = "Дата              Пробег         Работа                         Стоимость\n01.10.2026     84 000 км     Воздушный фильтр      35,00 BYN\n20.05.2026     77 000 км     Масло и фильтр          210,00 BYN";
        }
        part form : Widget {
            attribute :>> label = "Новая запись";
            attribute :>> content = "Дата: 14.11.2026\nПробег: 86 500 км\nРабота: замена масла и масляного фильтра\nСтоимость: 220,00 BYN\nСледующее ТО: 96 500 км / 14.05.2027";
        }
        part buttons : Widget {
            attribute :>> label = "Действия";
            attribute :>> content = "Сохранить                 Отмена";
        }
    }

    part def Fuel :> Screen {
        attribute :>> title = "История заправок";
        part filters : Widget {
            attribute :>> label = "Период";
            attribute :>> content = "01.11.2026 — 30.11.2026";
        }
        part history : Widget {
            attribute :>> label = "Заправки";
            attribute :>> content = "Дата              Пробег         Топливо       Объём       Сумма\n12.11.2026     86 450 км     АИ-95          40,00 л      104,00 BYN\n05.11.2026     85 900 км     АИ-95          35,00 л        91,00 BYN";
        }
        part totals : Widget {
            attribute :>> label = "Итог за период";
            attribute :>> content = "Объём: 75,00 л\nРасходы: 195,00 BYN";
        }
        part buttons : Widget {
            attribute :>> label = "Действия";
            attribute :>> content = "Добавить заправку      Изменить      Удалить";
        }
    }

    part def Insurance :> Screen {
        attribute :>> title = "Страховка и напоминания";
        part policy : Widget {
            attribute :>> label = "Страховой полис";
            attribute :>> content = "Вид: ОСГО\nНомер: DEMO-001\nПериод: 01.12.2025 — 30.11.2026\nСтоимость: 90,00 BYN";
        }
        part reminder : Widget {
            attribute :>> label = "Настройки напоминания";
            attribute :>> content = "Предупредить за 30 дней\nДо окончания: 16 дней\nСтатус: скоро истекает";
        }
        part buttons : Widget {
            attribute :>> label = "Действия";
            attribute :>> content = "Добавить полис      Изменить      Удалить";
        }
        part notice : Widget {
            attribute :>> label = "Уведомления";
            attribute :>> content = "Напоминания отображаются при запуске\nи во время работы приложения";
        }
    }

    part def AutoDiaryApplication {
        part dashboard : Dashboard;
        part maintenance : Maintenance;
        part fuel : Fuel;
        part insurance : Insurance;
    }
    part application : AutoDiaryApplication;
}
