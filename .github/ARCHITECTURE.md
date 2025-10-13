# Appetize Deployment Workflow Architecture

## 🔄 Workflow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                     TRIGGER EVENT                                │
│  (Push to main/master/automation, PR, or Manual trigger)        │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    SETUP ENVIRONMENT                             │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Checkout     │  │ Setup Java   │  │ Setup Flutter │         │
│  │ Repository   │→ │ JDK 17       │→ │ SDK          │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    RESTORE CACHES                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Flutter SDK  │  │ Pub Cache    │  │ Gradle Cache │         │
│  │ Cache        │  │              │  │              │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  Cache Hit?  YES → Fast Build (3-5 min)                        │
│              NO  → Full Build (10-15 min)                       │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    BUILD PROCESS                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ flutter pub  │→ │ flutter      │→ │ flutter build│         │
│  │ get          │  │ analyze      │  │ apk --release│         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    POST-BUILD ACTIONS                            │
│  ┌──────────────┐  ┌──────────────┐                            │
│  │ Rename APK   │→ │ Upload as    │                            │
│  │ with Version │  │ Artifact     │                            │
│  └──────────────┘  └──────────────┘                            │
│                                                                  │
│  APK Name: covid19_tracker-v{VERSION}-{BUILD_NUMBER}.apk       │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                APPETIZE DEPLOYMENT LOGIC                         │
│                                                                  │
│  Check: Does APPETIZE_PUBLIC_KEY exist?                         │
│                                                                  │
│  ┌───────────────────────┐    ┌──────────────────────┐         │
│  │ NO (First Time)       │    │ YES (Update)         │         │
│  │                       │    │                      │         │
│  │ ┌─────────────────┐   │    │ ┌────────────────┐  │         │
│  │ │ POST /v1/apps   │   │    │ │ POST           │  │         │
│  │ │ (New Upload)    │   │    │ │ /v1/apps/{key} │  │         │
│  │ └────────┬────────┘   │    │ └────────┬───────┘  │         │
│  │          │            │    │          │          │         │
│  │          ▼            │    │          ▼          │         │
│  │ ┌─────────────────┐   │    │ ┌────────────────┐  │         │
│  │ │ Get Public Key  │   │    │ │ Update Existing│  │         │
│  │ │ Display Warning │   │    │ │ App            │  │         │
│  │ └─────────────────┘   │    │ └────────────────┘  │         │
│  └───────────────────────┘    └──────────────────────┘         │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                    GENERATE OUTPUTS                              │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │ Workflow     │  │ PR Comment   │  │ Deployment   │         │
│  │ Summary      │  │ (if PR)      │  │ Info         │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                  │
│  Contains:                                                       │
│  • Build information                                            │
│  • Public key                                                   │
│  • App URL for testing                                          │
│  • Setup instructions (if first time)                           │
└─────────────────────────────────────────────────────────────────┘
```

## 📦 Caching Strategy

```
┌──────────────────────────────────────────────────────────────┐
│                      CACHE LAYERS                             │
└──────────────────────────────────────────────────────────────┘

Layer 1: Flutter SDK Cache
├── Location: ${{ runner.tool_cache }}/flutter
├── Key: flutter-:os:-:channel:-:version:-:arch:-:hash:
├── Size: ~800 MB
└── Saves: 2-3 minutes per build

Layer 2: Pub Dependencies Cache  
├── Location: ~/.pub-cache, .dart_tool
├── Key: ${{ runner.os }}-pub-${{ hashFiles('**/pubspec.lock') }}
├── Size: ~100-500 MB
└── Saves: 1-2 minutes per build

Layer 3: Gradle Dependencies Cache
├── Location: ~/.gradle/caches, ~/.gradle/wrapper
├── Key: ${{ runner.os }}-gradle-${{ hashFiles('**/*.gradle*') }}
├── Size: ~500 MB - 1 GB
└── Saves: 3-5 minutes per build

Layer 4: Java Distribution Cache
├── Location: Managed by setup-java action
├── Key: Auto-managed
├── Size: ~200 MB
└── Saves: 30-60 seconds per build

Total Time Saved: 7-11 minutes on subsequent builds!
```

## 🔐 Secret Management

```
┌──────────────────────────────────────────────────────────────┐
│                    GITHUB SECRETS                             │
└──────────────────────────────────────────────────────────────┘

Required Secrets:
┌─────────────────────────┐
│ APPETIZE_API_TOKEN      │  ← Required before first run
│                         │    (Get from Appetize.io)
└─────────────────────────┘

Optional (After First Deployment):
┌─────────────────────────┐
│ APPETIZE_PUBLIC_KEY     │  ← Add after first successful run
│                         │    (Provided in workflow output)
└─────────────────────────┘

Secret Usage Flow:
1. Workflow reads APPETIZE_API_TOKEN for authentication
2. Checks if APPETIZE_PUBLIC_KEY exists
   ├── NO  → Creates new app, returns public key
   └── YES → Updates existing app using public key
```

## 🎯 Decision Tree

```
                    Start Workflow
                         │
                         ▼
         ┌───────────────────────────┐
         │ Is APPETIZE_PUBLIC_KEY    │
         │ defined in secrets?       │
         └──────────┬────────────────┘
                    │
          ┌─────────┴─────────┐
          │                   │
         NO                  YES
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ NEW UPLOAD │      │   UPDATE   │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ POST       │      │ POST       │
   │ /v1/apps   │      │ /v1/apps/  │
   │            │      │ {key}      │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ Receive    │      │ Keep same  │
   │ new public │      │ public key │
   │ key        │      │            │
   └──────┬─────┘      └─────┬──────┘
          │                   │
          ▼                   ▼
   ┌────────────┐      ┌────────────┐
   │ Show       │      │ Confirm    │
   │ warning to │      │ successful │
   │ save key   │      │ update     │
   └────────────┘      └────────────┘
```

## 📊 Build Timeline Comparison

```
First Build (No Cache):
┌────────────────────────────────────────────────────────────┐
│ Checkout           ████ 30s                                │
│ Setup Java         ██████████ 60s                          │
│ Setup Flutter      ████████████████████ 120s               │
│ Pub Get            ████████████ 80s                        │
│ Gradle Build       ████████████████████████████ 180s       │
│ Flutter Build      ████████████████████████████████ 200s   │
│ Appetize Upload    ████████ 45s                            │
└────────────────────────────────────────────────────────────┘
Total: ~12 minutes

Subsequent Build (With Cache):
┌────────────────────────────────────────────────────────────┐
│ Checkout           ████ 30s                                │
│ Setup Java         ██ 15s (cached)                         │
│ Setup Flutter      ████ 25s (cached)                       │
│ Pub Get            ██ 15s (cached)                         │
│ Gradle Build       ████████ 45s (cached)                   │
│ Flutter Build      ████████████████ 90s                    │
│ Appetize Upload    ████████ 45s                            │
└────────────────────────────────────────────────────────────┘
Total: ~4 minutes

⚡ Speed Improvement: 3x faster!
```

## 🔄 Continuous Deployment Flow

```
Developer                GitHub Actions              Appetize.io
    │                          │                         │
    │  Push Code              │                         │
    ├────────────────────────►│                         │
    │                          │                         │
    │                          │  Build APK             │
    │                          ├──────────┐             │
    │                          │          │             │
    │                          │◄─────────┘             │
    │                          │                         │
    │                          │  Upload/Update APK     │
    │                          ├────────────────────────►│
    │                          │                         │
    │                          │  Return Public Key +   │
    │                          │  App URL               │
    │                          │◄────────────────────────┤
    │                          │                         │
    │  Workflow Complete      │                         │
    │  (Summary + Artifact)   │                         │
    │◄────────────────────────┤                         │
    │                          │                         │
    │                                                    │
    │  Test App in Browser                              │
    ├───────────────────────────────────────────────────►│
    │                                                    │
```

---

**Architecture Version:** 1.0.0  
**Last Updated:** October 2025
