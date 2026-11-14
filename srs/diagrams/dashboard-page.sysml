package AutoDiary_Dashboard {
    part def DashboardPage {
        attribute title = "АвтоДневник - Мой автомобиль";
        
        part header : Header;
        part vehicleProfile : VehicleProfile;
        part createBtn : CreateButton;
        part recordLists : RecordLists;
        part footer : Footer;
    }

    part def Header {
        attribute logo = "АвтоДневник";
    }

    part def VehicleProfile {
        attribute model = "Volkswagen Polo";
        attribute mileage = "86 500 км";
    }

    part def CreateButton {
        attribute label = "Добавить запись";
    }

    part def RecordLists {
        part upcomingService : UpcomingService;
        part fuelHistory : FuelHistory;
    }

    part def UpcomingService {
        attribute items = "Предстоящие работы ТО";
    }

    part def FuelHistory {
        attribute items = "История заправок";
    }

    part def Footer {
        attribute info = "О приложении, Контакты";
    }
}