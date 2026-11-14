package AutoDiaryUI {
    private import ScalarValues::*;
    part def Widget { attribute label : String; attribute content : String; }
    part def Screen { attribute title : String; }
    part def Dashboard :> Screen {
        attribute :>> title = "Обзор автомобиля";
        part vehicle : Widget {
            attribute :>> label = "Автомобиль";
            attribute :>> content = "Марка и модель; текущий пробег";
        }
        part service : Widget {
            attribute :>> label = "Ближайшее обслуживание";
            attribute :>> content = "Работа; пробег до ТО; статус";
        }
        part insurance : Widget {
            attribute :>> label = "Страховка";
            attribute :>> content = "Полис; статус";
        }
        part actions : Widget {
            attribute :>> label = "Быстрые действия";
            attribute :>> content = "Обновить пробег; добавить ТО; добавить заправку";
        }
        part recent : Widget {
            attribute :>> label = "Последние записи";
            attribute :>> content = "Вид записи; описание; пробег; сумма";
        }
    }
    part def Maintenance :> Screen {
        attribute :>> title = "Техническое обслуживание";
        part history : Widget {
            attribute :>> label = "История обслуживания";
            attribute :>> content = "Пробег; вид работ; стоимость";
        }
        part form : Widget {
            attribute :>> label = "Новая запись";
            attribute :>> content = "Пробег; стоимость; работы; следующее ТО; примечание";
        }
        part actions : Widget {
            attribute :>> label = "Действия";
            attribute :>> content = "Сохранить; отмена";
        }
    }
    part def Fuel :> Screen {
        attribute :>> title = "История заправок";
        part filter : Widget {
            attribute :>> label = "Фильтр";
            attribute :>> content = "Выбрать период";
        }
        part history : Widget {
            attribute :>> label = "Заправки";
            attribute :>> content = "Пробег; топливо; объём; сумма";
        }
        part totals : Widget {
            attribute :>> label = "Итог за период";
            attribute :>> content = "Общий объём; расходы";
        }
        part actions : Widget {
            attribute :>> label = "Действия";
            attribute :>> content = "Добавить заправку; изменить; удалить";
        }
    }
    part def Insurance :> Screen {
        attribute :>> title = "Страховка и напоминания";
        part policy : Widget {
            attribute :>> label = "Страховой полис";
            attribute :>> content = "Вид полиса; номер; страховщик; стоимость; статус";
        }
        part reminder : Widget {
            attribute :>> label = "Настройки напоминания";
            attribute :>> content = "Предупреждать за; показывать при запуске";
        }
        part actions : Widget {
            attribute :>> label = "Действия";
            attribute :>> content = "Добавить полис; изменить; удалить";
        }
        part notice : Widget {
            attribute :>> label = "Уведомления";
            attribute :>> content = "Список напоминаний";
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
