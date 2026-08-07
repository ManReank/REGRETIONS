# REGRETION - Psychological Horror 2.5D Game

> **REGRETION** adalah game *psychological horror / narrative adventure* 2.5D pixel art untuk platform Android. Menceritakan seorang wanita bernama Eira yang terisolasi di dalam *white room* dan harus menghadapi fragmen ingatan masa lalunya selama 7 hari melalui interpretasi objek.

## 🛠️ Spesiﬁkasi Teknis

* **Engine:** Godot Engine 4.x (Mobile Renderer)
* **Bahasa Pemrograman:** GDScript
* **Target Platform:** Android (API Level 24+)
* **Orientasi Layar:** Landscape
* **Version Control:** Git + Git LFS


## 📁 Struktur Proyek

REGRETIONS/
├── .godot/                         # File internal Godot; WAJIB di-ignore Git
├── .github/
│   └── workflows/                  # CI/CD GitHub Actions
│
├── assets/                         # Seluruh asset yang dibaca/digunakan game
│   ├── audio/
│   │   ├── bgm/                    # Ambient/music per hari
│   │   └── sfx/                    # Langkah, jeruji, impact, interaction, dll.
│   ├── env/                        # Tileset, wall, floor, bed, washbasin, mirror, bars
│   ├── items/                      # Baju bayi, pisau, dan item interaktif
│   ├── characters/                 # Eira + Past Self + Child + Husband
│   ├── ui/                         # Dialogue box, prompt, font, pause UI
│   └── endings/                    # Artwork/lukisan ending
│
├── src/                            # Scene dan seluruh logic game
│   ├── autoload/                   # Service global yang hidup sepanjang game
│   │   ├── game_manager.gd         # Day/Game State
│   │   ├── interpretation_manager.gd # Denial/Blame/Acceptance
│   │   ├── save_manager.gd         # Save/Load
│   │   └── sound_manager.gd        # BGM/SFX controller
│   │
│   ├── core/                      # Sistem reusable inti
│   │   ├── interaction/            # Sistem objek/NPC yang dapat diinteraksi
│   │   │   ├── interactable.gd
│   │   │   └── interaction_manager.gd
│   │   └── dialogue/               # Sistem teks/dialogue
│   │       ├── dialogue_manager.gd
│   │       └── dialogue_data/      # Data dialog/branching
│   │
│   ├── events/                    # Sequence kejadian berbasis hari
│   │   ├── day_01.gd
│   │   ├── day_02.gd
│   │   ├── day_03.gd
│   │   ├── day_04.gd
│   │   ├── day_05.gd
│   │   ├── day_06.gd               # Konfrontasi tiga manifestasi
│   │   └── day_07.gd               # Resolusi/ending evaluation
│   │
│   ├── characters/                # Scene dan script karakter
│   │   ├── eira/
│   │   ├── past_self/
│   │   ├── child/
│   │   └── husband/
│   │
│   ├── scenes/                    # Scene utama Godot
│   │   ├── main_menu/
│   │   ├── white_room/
│   │   └── endings/
│   │
│   └── ui/                        # Komponen UI yang digunakan scene
│       ├── dialogue/
│       ├── interaction/
│       └── pause/
│
├── .gitignore                     # Aturan file yang tidak di-track Git
├── export_presets.cfg             # Konfigurasi export Android Godot
├── project.godot                  # Konfigurasi utama Godot
└── README.md                      # Dokumentasi proyek dan credits

