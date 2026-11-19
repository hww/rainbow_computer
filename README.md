# "Rainbow" ("Радуга") Computer
_Information recovery about a retro computer_

The "Rainbow" ("Радуга") computer was developed at the Omsk Aviation Technical School (OMAVIAT) and put into production in the spring–summer of 1988, assembled by students in radio-assembly workshops. While this computer is not significant in terms of prevalence or popularity, it nevertheless deserves attention due to its architectural features. This repository branch was created to introduce enthusiasts to these features.

## Specifications

The schematic is based on the "Specialist" (СПЕЦИАЛИСТ) computer, so the table of differences is provided below.

|                                  | SPECIALIST                         | RAINBOW (РАДУГА)                 |
|---|---|---|
| **CPU** | KR580VM80A (580ИК80 / i8080 clone) | KR580VM80A (580ИК80 / i8080 clone) |
| **Resolution** | 384x256 | 384x256 |
| **Colors** | 1-bit monochrome (*) | 16 background colors and 16 foreground colors per every 8 pixels |
| **Border** | None | One of 16 colors |
| **Palette** | None | **School PC:** 2 sets, 16 out of 256 colors (in 32x8 ROM) |
|  | | **Home PC:** 16 out of 256 colors (in 16x8 RAM) |
| **Video Memory** | 12 KB | 24 KB visible area |
|  |  | 4 KB color font and sprites |
| **Additional** | | Hardware graphics copy accelerator |
| **RAM** | 48 KB | 64 KB |
|     |      | 48 KB direct memory access |
|     |      | 16 KB (color) indirect access |
| **ROM** | 2 KB | 6 KB (3x2 KB) |
| **Interrupts** | None | 50 Hz |
| **Sound** | 1-bit, programmable | 4 hardware channels |
|      |                           | 8 volume levels per channel |
|      |                           | 3 programmable timers, 1 noise channel |
|      |                           | Sound synthesis via volume modulation |
| **Expansion Port** | Unspecified | 16-bit GPIO |
| **IC Count** | 45 | 80 |

(*) With modification, one of 8 colors or black per every 8 pixels.

## Schematic Diagram

The step-by-step schematic recovery process is described [here](storyboard/README.md).

The schematic diagram is located in the _sch_ folder.

**Versions:**

- The Alpha version of the schematic matches the original computer's schematic as closely as possible.
- The Beta version of the schematic may have minor modifications compared to the original.

## Memory Map

| ADDRESSES | PURPOSE |
|---|---|
| 0xF800 - 0xFFFF | Peripheral devices |
| 0xD000 - 0xD7FF | ROM 3 |
| 0xC800 - 0xCFFF | ROM 2 |
| 0xC000 - 0xC7FF | ROM 1 |
| 0x8800 - 0xBFFF | Video memory |
| 0x8000 - 0x87FF | Color font |
| 0x0000 - 0x7FFF | RAM |

## Peripheral Devices

| ADDRESSES | PURPOSE |
|---|---|
| 0xF800 - 0xF803 | Programmable Peripheral Interface (PPI 1) |
| 0xF900 - 0xF903 | Programmable Peripheral Interface (PPI 2) |
| 0xFA00 - 0xFA03 | Timer (TIMER) |
| 0xFB00 - 0xFB00 | Color register (COPIER) |
| 0xFC00 - 0xFCFF / 0xFC00 - 0xFC0F | Expansion 1 / Palette |
| 0xFD00 - 0xFDFF | Expansion 2 |
| 0xFE00 - 0xFEFF | Expansion 3 |
| 0xFF00 - 0xFFFF | Expansion 4 |

## Parallel Port Assignments

### PPI 1

| PORT | BITS | AFTER RESET | PURPOSE |
|---|---|---|---|
| PPI1 | A0-A3 | X | Keyboard row selection |
| PPI1 | A4 | X | Volume VOLB2 (Timer B) |
| PPI1 | A5-A7 | X | Volume VOLA0-VOLA2 (Timer A) |
| PPI1 | B0-B5 | X | Keyboard column read |
| PPI1 | B6 | X | Vertical blanking pulse read (0 - visible area, 1 - blanking) |
| PPI1 | B7 | X | Tape recorder read |
| PPI1 | C0-C3 | X | Border color |
| PPI1 | C4 | 1 | 1 - black screen |
| PPI1 | C5 | 0 | 0 - pastel, 1 - saturated (or GPO) |
| PPI1 | C6 | 0 | 1 - tape recorder motor on |
| PPI1 | C7 | 0 | Tape recorder output (inverted) |

### PPI 2

| PORT | BITS | AFTER RESET | PURPOSE |
|---|---|---|---|
| PPI2 | A0-A7 | X | GPIO expansion |
| PPI2 | B0-B2 | X | Volume VOLD0-VOLD2 (Noise) |
| PPI2 | B4-B5 | X | Volume VOLC0-VOLC2 (Timer C) |
| PPI2 | B6-B7 | X | Volume VOLB0-VOLB2 (Timer B) |
| PPI2 | C0-C7 | X | GPIO expansion |

### Keyboard

The keyboard layout is similar to MSX (KUVT).

Используйте код с осторожностью.
┌─────┬─────┬─────┬─────┬─────┐                            ┌─────┬───────────┐
│ F1  │ F2  │ F3  │ F4  │ F5  │                            │ CLR │   STOP    │
│  F6 │  F7 │  F8 │  F9 │ F10 │                            │     │           │
├───┬─┴─┬───┼───┬─┴─┬───┼───┬─┴─┬───┬───┬───┬───┬───┬───┐  ├─────┼─────┬─────┤
│ ; │ 1 │ 2 │ 3 │ 4 │ 5 │ 6 │ 7 │ 8 │ 9 │ 0 │ _ │BS │TAB│  │ HOME│ INS │ DEL │
│ + │ ! │ " │ # │ ¤ │ % │ & │ ` │ ( │ ) │ $ │ = │   │   │  │     │     │     │
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
│ SHIFT │CA │GRAPH│           SPACE         │R/L│ SHIFT │  │     │     │     │
│       │ PS│     │                         │   │       │  │     │  ↓  │     │
└───────┴───┴─────┴─────────────────────────┴───┴───────┘  └─────┴─────┴─────┘

