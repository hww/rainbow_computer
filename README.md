_Rainbow Computer_ _Reverse engineering and recreation retro computer Rainbow_

#  Компьютер "Радуга" 
_Востановление информации о ретро компьютере_ 

Компьютер "Радуга" был разработан в Омском Авиационном Техникуме (ОМАВИАТ) и запущен в производство весной-летом 1988 года, собирался студентами в радиомонтажных мастерских. Этот компьютер не является значимым с точки зрения распространённости и популярности. Но все же заслуживает внимания из-за особенностей архитектуры. Данная ветка создана для того чтобы ознакомить интересующихся с этими особенностями.

## Характеристики

Схема базируется на компьютере СПЕЦИАЛИСТ поэтому ниже приведена таблица различий. 

|                                  | СПЕЦИАЛИСТ                         | РАДУГА                           |
|---|---|---|
| **Процессор** | 580ИК80 | 580ИК80 |
| **Разрешение** | 384x256 | 384x256 |
| **Цветов** | 1 бит монохром | 16 цветов фона и 16 цветов изображения на каждые 8 пикселов | 
| **Бордюр** | нет | Один из 16 цветов | 
| **Палитра** | нет | **Ученический ПК:** 2 набора, 16 из 256 цветов (в 32x8 ПЗУ) |
|  | | **Домашний ПК** 16 из 256 цветов (в 16x8 ОЗУ) |
| **Графическая память** | 12КБ | 24КБ видимая область |
|  |  | 4КБ цветной шрифт и спрайты |
| **Дополнитьно**      |                            | Ускоритель копирования графики |
| **ОЗУ** | 48КБ | 64КБ |
|     |      | 48КБ Прямой доступ в память  |
|     |      | 16КБ (цвет) Косвенный доступ |
| **ПЗУ** | 2КБ | 6КБ (3x2КБ) |
| **Прерывания** | Нет | 50Hz |
| **Звук** | 1 битный, программируемый | 4 аппаратных канала |
|      |                           | 8 уровней громкости в канале |
|      |                           | 3 програмируемых таймера, 1 канал шума |
|      |                           | Доступен синтез звука изменением громкости |
| **Разьем расширения**      |  не специфицирован                          | 16 битный GPIO |
| **Количество микросхем** | 45 | 80 |

## Принципиальная Схема

Поэтапный процесс восстановления схемы описан [тут](storyboard/README.md)

Принципиальная схема в папке _sch_. 

**Версии:**

- Альфа версия схемы максимально соотвествует схеме оригинального компьютера. 
- Бета версия схемы может иметь незначительные изменения от оригинала.

## Карта памяти

| АДРЕСА | НАЗНАЧЕНИЕ |
|---|---|
| 0xF800 - 0xFFFF | Периферийные устройства |
| 0xD000 - 0xD7FF | ПЗУ 3 |
| 0xC800 - 0xCFFF | ПЗУ 2 |
| 0xC000 - 0xC7FF | ПЗУ 1 |
| 0x8800 - 0xBFFF | Графическая память |
| 0x8000 - 0x87FF | Цветной шрифт |
| 0x0000 - 0x7FFF | Оперативная память |

## Периферийные устройства

| АДРЕСА | НАЗНАЧЕНИЕ |
|---|---|
| 0xF800 - 0xF803 | Программируемый порт (PPI 1) |
| 0xF900 - 0xF903 | Программируемый порт (PPI 2) |
| 0xFA00 - 0xFA03 | Таймер (TIMER) |
| 0xFB00 - 0xFB00 | Регистр цвета (COPIER) |
| 0xFC00 - 0xFCFF / 0xFC00 - 0xFC0F | Расширение 1 / Палитра |
| 0xFD00 - 0xFDFF | Расширение 2 |
| 0xFE00 - 0xFEFF | Расширение 3 |
| 0xFF00 - 0xFFFF | Расширение 4 |

## Назначение параллельных портов

### PPI 1

| ПРОТ | БИТЫ | ПОСЛЕ СБРОСА | НАЗНАЧЕНИЕ |
|---|---|---|---|
| PPI1 | A0-A3 | X | Выбор строки клавиатуры |
| PPI1 | A4 | X | Громкость VOLB2 (Таймер B) |
| PPI1 | A5-A7 | X | Громкость VOLA0-VOLA2 (Таймер A) |
| PPI1 | B0-B5 | X | Чтение столбца клавиатуры |
| PPI1 | B6 | X | Чтение закадрового импульса (0 - видимая область, 1 - за кадром) |
| PPI1 | B7 | X | Чтение с магнитафона |
| PPI1 | С0-С3 | X | Цвет бордюра |
| PPI1 | С4 | 1 | 1 - черный экран |
| PPI1 | С5 | 0 | 0 - пастель, 1 - насыщеные (или GPO) |
| PPI1 | С6 | 0 | 1  включение мотора магнитафона |
| PPI1 | С7 | 0 | Вывод на магнитафон (инверсный) |

### PPI 2

| ПРОТ | БИТЫ | ПОСЛЕ СБРОСА | НАЗНАЧЕНИЕ |
|---|---|---|---|
| PPI2 | A0-A7 | X | Расширение GPIO |
| PPI2 | B0-B2 | X | Громкость VOLD0-VOLD2 (Шум) |
| PPI2 | B4-B5 | X | Громкость VOLC0-VOLC2 (Таймер C) |
| PPI2 | B6-B7 | X | Громкость VOLB0-VOLB2 (Таймер B) |
| PPI2 | С0-С7 | X | Расширение GPIO |

### Клавиатура

Раскладка клавиатуры подобна с MSX (КУВТ).

```
    ┌─────┬─────┬─────┬─────┬─────┐                            ┌─────┬───────────┐
    │ F1  │ F2  │ F3  │ F4  │ F5  │                            │ CLR │   STOP    │
    │  F6 │  F7 │  F8 │  F9 │ F10 │                            │     │           │
    ├───┬─┴─┬───┼───┬─┴─┬───┼───┬─┴─┬───┬───┬───┬───┬───┬───┐  ├─────┼─────┬─────┤
    │ ; │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │ _ │BS │TAB│  │ HOME│ INS │ DEL │
    │ + │ ! │ " │ # │ ¤ │ % │ & │ ` │ ( │ ) │ $ │ = │ ─ │   │  │     │     │     │
    └─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴───┤  └─────┴─────┴─────┘
      │ Й │ Ц │ У │ К │ Е │ Н │ Г │ Ш │ Щ │ З │ Х │ : │     │
      │ J │ C │ U │ K │ E │ N │ G │ [ │ ] │ Z │ H │ * │ENTER│
    ┌─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┐   │
    │ESC│ Ф │ Ы │ В │ А │ П │ Р │ О │ Л │ Д │ Ж │ Э │ . │   │
    │   │ F │ Y │ W │ A │ P │ R │ O │ L │ D │ V │ \ │ > │   │
    ├───┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┴─┬─┘  ┌─────┬─────┬─────┐
    │CTRL │ Я │ Ч │ С │ М │ И │ Т │ Ь │ Б │ Ю │ , │ / │ ─ │    │     │  ↑  │     │
    │     │ Q │ ^ │ S │ M │ I │ T │ X │ B │ @ │ < │ ? │ Δ │    │     │     │     │
    ├─────┴─┬─┴─┬─┴───┼───┴───┴───┴───┴───┴───┴─┬─┴─┬─┴───┴─┐  │  ←  ├─────┤  →  │
    │SHIFT  │CA │GRAPH│           SPACE         │R/L│SHIFT  │  │     │     │     │
    │       │ PS│     │                         │   │       │  │     │  ↓  │     │
    └───────┴───┴─────┴─────────────────────────┴───┴───────┘  └─────┴─────┴─────┘
```


