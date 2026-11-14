package AutoDiary_Vehicle {
    part def VehiclePage {
        attribute title = "Volkswagen Polo";
        attribute mileage = "86 500 км";
        attribute description = "ТО, заправки, страховка";
       
        part header : Header;
        part serviceInfo : ServiceInfo;
        part oilAndFilters : OilAndFilters;
        part insuranceInfo : InsuranceInfo;
        part refuelHistory : RefuelHistory;
        part reminderList : ReminderList;
        part footer : Footer;
    }

    part def ServiceInfo {
        attribute date = "20.05.2026";
        attribute mileage = "77 000 км";
    }

    part def OilAndFilters {
        attribute items = "Замены масла и фильтров";
    }

    part def InsuranceInfo {
        attribute expiry = "30.11.2026";
        attribute policy = "ОСГО";
    }

    part def RefuelHistory {
        attribute records = "История заправок";
    }


    part def ReminderList {
        attribute items = "Напоминания о ТО";
    }


    part def Header {
        attribute logo = "АвтоДневник";
    }

    part def Footer {
        attribute info = "О приложении, Контакты";
    }
}