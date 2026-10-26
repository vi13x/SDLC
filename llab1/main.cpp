#include <windows.h>
#include <string>
#include <vector>
#include <functional>
#include <stdexcept>

class PulseModel {
private:
    int age = 0;
    int restingHr = 0;
    std::vector<std::function<void(int, int)>> observers;

public:
    void addObserver(std::function<void(int, int)> observer) {
        observers.push_back(observer);
    }

    void updateData(int newAge, int newRestingHr) {
        age = newAge;
        restingHr = newRestingHr;
        calculate();
    }

    int getAge() const { return age; }
    int getRestingHr() const { return restingHr; }

private:
    void calculate() {
        int maxHr = 220 - age;
        int hrr = maxHr - restingHr;

        int startPulse = static_cast<int>(hrr * 0.5) + restingHr;
        int targetPulse = static_cast<int>(hrr * 0.7) + restingHr;

        for (const auto& obs : observers) {
            obs(startPulse, targetPulse);
        }
    }
};

PulseModel g_Model;
HWND g_hMainWnd = NULL;
HWND g_hLabelStart = NULL;
HWND g_hLabelTarget = NULL;

class AppController {
public:
    static void OnDataSubmitted(HWND hDialog, const std::wstring& ageStr, const std::wstring& hrStr) {
        try {
            int age = std::stoi(ageStr);
            int hr = std::stoi(hrStr);

            if (age <= 0 || age > 120 || hr <= 30 || hr > 220) {
                throw std::invalid_argument("Invalid range");
            }

            g_Model.updateData(age, hr);

            EnableWindow(g_hMainWnd, TRUE);
            DestroyWindow(hDialog);
            SetForegroundWindow(g_hMainWnd);

        } catch (...) {
            MessageBoxW(hDialog, L"Пожалуйста, введите корректные целые числа (Возраст 1-120, Пульс 30-220).", L"Ошибка ввода", MB_ICONERROR | MB_OK);
        }
    }
};

LRESULT CALLBACK InputWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    static HWND hEditAge, hEditHr;

    switch (msg) {
        case WM_CREATE: {
            HFONT hFont = CreateFontW(-15, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
                                      DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                                      CLEARTYPE_QUALITY, VARIABLE_PITCH, L"Segoe UI");

            CreateWindowW(L"STATIC", L"Возраст:", WS_VISIBLE | WS_CHILD, 20, 20, 100, 25, hwnd, NULL, NULL, NULL);
            hEditAge = CreateWindowW(L"EDIT", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER, 130, 20, 100, 25, hwnd, NULL, NULL, NULL);

            CreateWindowW(L"STATIC", L"Пульс покоя:", WS_VISIBLE | WS_CHILD, 20, 60, 100, 25, hwnd, NULL, NULL, NULL);
            hEditHr = CreateWindowW(L"EDIT", L"", WS_VISIBLE | WS_CHILD | WS_BORDER | ES_NUMBER, 130, 60, 100, 25, hwnd, NULL, NULL, NULL);

            CreateWindowW(L"BUTTON", L"Сохранить", WS_VISIBLE | WS_CHILD | BS_DEFPUSHBUTTON, 70, 110, 100, 30, hwnd, (HMENU)1, NULL, NULL);

            EnumChildWindows(hwnd, [](HWND child, LPARAM font) -> BOOL {
                SendMessageW(child, WM_SETFONT, font, TRUE);
                return TRUE;
            }, (LPARAM)hFont);

            if (g_Model.getAge() > 0) {
                SetWindowTextW(hEditAge, std::to_wstring(g_Model.getAge()).c_str());
                SetWindowTextW(hEditHr, std::to_wstring(g_Model.getRestingHr()).c_str());
            }
            break;
        }
        case WM_COMMAND: {
            if (LOWORD(wParam) == 1) {
                wchar_t ageBuf[10], hrBuf[10];
                GetWindowTextW(hEditAge, ageBuf, 10);
                GetWindowTextW(hEditHr, hrBuf, 10);

                AppController::OnDataSubmitted(hwnd, ageBuf, hrBuf);
            }
            break;
        }
        case WM_CLOSE:
            EnableWindow(g_hMainWnd, TRUE);
            DestroyWindow(hwnd);
            break;
    }
    return DefWindowProcW(hwnd, msg, wParam, lParam);
}

LRESULT CALLBACK MainWndProc(HWND hwnd, UINT msg, WPARAM wParam, LPARAM lParam) {
    switch (msg) {
        case WM_CREATE: {
            HFONT hFont = CreateFontW(-15, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE,
                                      DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS,
                                      CLEARTYPE_QUALITY, VARIABLE_PITCH, L"Segoe UI");

            CreateWindowW(L"BUTTON", L"Ввод данных", WS_VISIBLE | WS_CHILD, 50, 30, 150, 35, hwnd, (HMENU)1, NULL, NULL);

            CreateWindowW(L"STATIC", L"Пульс для старта:", WS_VISIBLE | WS_CHILD, 50, 90, 150, 30, hwnd, NULL, NULL, NULL);
            g_hLabelStart = CreateWindowW(L"STATIC", L"-", WS_VISIBLE | WS_CHILD, 210, 90, 100, 30, hwnd, NULL, NULL, NULL);

            CreateWindowW(L"STATIC", L"Целевой пульс:", WS_VISIBLE | WS_CHILD, 50, 130, 150, 30, hwnd, NULL, NULL, NULL);
            g_hLabelTarget = CreateWindowW(L"STATIC", L"-", WS_VISIBLE | WS_CHILD, 210, 130, 100, 30, hwnd, NULL, NULL, NULL);

            EnumChildWindows(hwnd, [](HWND child, LPARAM font) -> BOOL {
                SendMessageW(child, WM_SETFONT, font, TRUE);
                return TRUE;
            }, (LPARAM)hFont);

            WNDCLASSW wc = {0};
            wc.lpfnWndProc = InputWndProc;
            wc.hInstance = GetModuleHandle(NULL);
            wc.lpszClassName = L"InputWindowClass";
            wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
            RegisterClassW(&wc);

            break;
        }
        case WM_COMMAND: {
            if (LOWORD(wParam) == 1) {
                EnableWindow(hwnd, FALSE);
                HWND hInput = CreateWindowW(L"InputWindowClass", L"Ввод данных",
                    WS_VISIBLE | WS_SYSMENU | WS_CAPTION,
                    CW_USEDEFAULT, CW_USEDEFAULT, 280, 200, hwnd, NULL, GetModuleHandle(NULL), NULL);
            }
            break;
        }
        case WM_DESTROY:
            PostQuitMessage(0);
            break;
    }
    return DefWindowProcW(hwnd, msg, wParam, lParam);
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
    g_Model.addObserver([](int startPulse, int targetPulse) {
        std::wstring startText = std::to_wstring(startPulse) + L" уд/мин";
        std::wstring targetText = std::to_wstring(targetPulse) + L" уд/мин";
        SetWindowTextW(g_hLabelStart, startText.c_str());
        SetWindowTextW(g_hLabelTarget, targetText.c_str());
    });

    WNDCLASSW wc = {0};
    wc.lpfnWndProc = MainWndProc;
    wc.hInstance = hInstance;
    wc.lpszClassName = L"MainWindowClass";
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);

    RegisterClassW(&wc);

    g_hMainWnd = CreateWindowW(L"MainWindowClass", L"Идеальное похудение (MVC)",
        WS_OVERLAPPEDWINDOW ^ WS_THICKFRAME ^ WS_MAXIMIZEBOX,
        CW_USEDEFAULT, CW_USEDEFAULT, 350, 250, NULL, NULL, hInstance, NULL);

    ShowWindow(g_hMainWnd, nCmdShow);

    MSG msg = {0};
    while (GetMessageW(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessageW(&msg);
    }
    return 0;
}