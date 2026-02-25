# BrideSide — Web App

> Your bridal pocket bestie. Helping brides manage one or more weddings without losing your mind.

## Tech Stack
- **Frontend:** React + Vite + Tailwind CSS
- **Backend:** Node.js + Express
- **Database & Auth:** Supabase (PostgreSQL)
- **Hosting:** Vercel (client) + Railway (server)

---

## 🚀 Getting Started

### 1. Set up Supabase

1. Go to [supabase.com](https://supabase.com) and create a free account
2. Create a new project
3. Go to **SQL Editor** → **New Query**
4. Paste the contents of `supabase-schema.sql` and click **Run**
5. Go to **Project Settings → API** and copy your:
   - Project URL
   - `anon` public key
   - `service_role` secret key

### 2. Set up the Client

```bash
cd client
cp .env.example .env
# Fill in your VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY
npm install
npm run dev
```

### 3. Set up the Server

```bash
cd server
cp .env.example .env
# Fill in your SUPABASE_URL and SUPABASE_SERVICE_KEY
npm install
npm run dev
```

### 4. Open the app

Visit `http://localhost:5173` — sign up and you're in!

---

## 📁 Project Structure

```
brideside/
├── client/          # React frontend (Vite)
├── server/          # Node.js Express backend
├── supabase-schema.sql   # Run this in Supabase SQL editor
└── README.md
```

---

## 🔑 Required API Keys

| Service | Where to get | Used for |
|---|---|---|
| Supabase | supabase.com | Database + Auth |
| OpenAI | platform.openai.com | AI Moodboard Generator |
| Resend | resend.com | Invitation emails |

---

## 🗺️ Build Roadmap

### ✅ Phase 1 — Foundation (Done)
- Project scaffold (Vite + Tailwind + React Router)
- Supabase schema (all tables)
- Auth flow (signup, login, forgot password)
- Onboarding flow (4 steps)
- Dashboard shell + sidebar navigation

### 🔨 Phase 2 — MVP Features (Next)
- Guest list manager
- Invitation sender + RSVP flow
- AI Moodboard Generator
- Wedding Website Builder

### 🔮 Phase 3 — Growth Features
- Vendor Manager
- Budget Tracker
- Multi-wedding support for planners
- PWA (installable mobile app)
