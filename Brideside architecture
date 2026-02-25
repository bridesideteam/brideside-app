# BrideSide — Full App Architecture

## Overview
BrideSide is a full-stack web application for brides and wedding planners to manage one or more weddings. Built with React (frontend), Node.js/Express (backend), and Supabase (database + auth + storage).

---

## Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| Frontend | React + Vite | UI framework |
| Styling | Tailwind CSS | Utility-first styling |
| State | Zustand | Lightweight global state |
| Routing | React Router v6 | Client-side routing |
| Backend | Node.js + Express | REST API server |
| Database | Supabase (PostgreSQL) | Primary data store |
| Auth | Supabase Auth | User authentication |
| Storage | Supabase Storage | Images, files, moodboards |
| AI | OpenAI API | Moodboard generation |
| Email | Resend | Transactional emails |
| Frontend Host | Vercel | Free, CI/CD from GitHub |
| Backend Host | Railway | Node server hosting |

---

## Folder Structure

```
brideside/
├── client/                          # React frontend
│   ├── public/
│   ├── src/
│   │   ├── assets/                  # Fonts, images, icons
│   │   ├── components/              # Reusable UI components
│   │   │   ├── ui/                  # Base components (Button, Input, Card, Modal)
│   │   │   ├── layout/              # Sidebar, Navbar, PageWrapper
│   │   │   └── shared/              # WeddingSelector, CountdownTimer, etc.
│   │   ├── pages/                   # Route-level page components
│   │   │   ├── auth/
│   │   │   │   ├── Login.jsx
│   │   │   │   ├── Signup.jsx
│   │   │   │   └── ForgotPassword.jsx
│   │   │   ├── onboarding/
│   │   │   │   ├── Step1_Role.jsx
│   │   │   │   ├── Step2_WeddingDetails.jsx
│   │   │   │   ├── Step3_Preferences.jsx
│   │   │   │   └── Step4_Complete.jsx
│   │   │   ├── dashboard/
│   │   │   │   └── Dashboard.jsx
│   │   │   ├── moodboard/
│   │   │   │   ├── MoodboardList.jsx
│   │   │   │   └── MoodboardEditor.jsx
│   │   │   ├── website/
│   │   │   │   └── WebsiteBuilder.jsx
│   │   │   ├── rsvp/
│   │   │   │   ├── InvitationManager.jsx
│   │   │   │   └── RSVPTracker.jsx
│   │   │   ├── vendors/             # Coming next
│   │   │   ├── budget/              # Coming next
│   │   │   └── settings/
│   │   │       └── Settings.jsx
│   │   ├── hooks/                   # Custom React hooks
│   │   │   ├── useAuth.js
│   │   │   ├── useWedding.js
│   │   │   └── useSupabase.js
│   │   ├── store/                   # Zustand global state
│   │   │   ├── authStore.js
│   │   │   └── weddingStore.js
│   │   ├── lib/                     # Utilities & config
│   │   │   ├── supabase.js          # Supabase client init
│   │   │   └── api.js               # Axios instance → backend
│   │   ├── styles/
│   │   │   └── globals.css          # Tailwind + brand tokens
│   │   ├── App.jsx                  # Routes + layout
│   │   └── main.jsx                 # Entry point
│   ├── index.html
│   ├── vite.config.js
│   └── package.json
│
├── server/                          # Node.js + Express backend
│   ├── src/
│   │   ├── routes/                  # API route handlers
│   │   │   ├── auth.js              # /api/auth
│   │   │   ├── weddings.js          # /api/weddings
│   │   │   ├── moodboards.js        # /api/moodboards
│   │   │   ├── guests.js            # /api/guests
│   │   │   ├── rsvp.js              # /api/rsvp
│   │   │   ├── vendors.js           # /api/vendors
│   │   │   └── budget.js            # /api/budget
│   │   ├── middleware/
│   │   │   ├── auth.js              # JWT verification
│   │   │   └── errorHandler.js
│   │   ├── services/
│   │   │   ├── openai.js            # AI moodboard logic
│   │   │   ├── email.js             # Resend email service
│   │   │   └── supabase.js          # Supabase admin client
│   │   └── app.js                   # Express app setup
│   ├── server.js                    # Entry point
│   └── package.json
│
├── .env.example                     # All env vars documented
├── .gitignore
└── README.md
```

---

## Database Schema (Supabase / PostgreSQL)

### users
| Column | Type | Notes |
|---|---|---|
| id | uuid | Primary key (from Supabase Auth) |
| email | text | Unique |
| full_name | text | |
| role | enum | 'bride' or 'planner' |
| avatar_url | text | Supabase Storage URL |
| onboarding_complete | boolean | Default false |
| created_at | timestamp | |

### weddings
| Column | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| user_id | uuid | FK → users.id |
| couple_name | text | e.g. "Engels & Alex" |
| wedding_date | date | |
| venue | text | |
| estimated_guests | integer | |
| color_palette | jsonb | Array of hex codes |
| theme | text | |
| website_slug | text | Unique, for public site |
| created_at | timestamp | |

### moodboards
| Column | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| wedding_id | uuid | FK → weddings.id |
| title | text | |
| style_tags | text[] | e.g. ["romantic", "boho"] |
| images | jsonb | Array of image URLs + positions |
| ai_prompt | text | Original prompt used |
| created_at | timestamp | |

### guests
| Column | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| wedding_id | uuid | FK → weddings.id |
| name | text | |
| email | text | |
| phone | text | |
| group | text | e.g. "Bride's family" |
| invite_sent | boolean | |
| rsvp_status | enum | 'pending', 'attending', 'declined' |
| meal_preference | text | |
| plus_one | boolean | |
| notes | text | |

### invitations
| Column | Type | Notes |
|---|---|---|
| id | uuid | Primary key |
| wedding_id | uuid | FK → weddings.id |
| template_id | text | Selected design template |
| subject | text | Email subject line |
| message | text | Custom message body |
| sent_at | timestamp | |

### vendors (coming next)
| Column | Type | Notes |
|---|---|---|
| id | uuid | |
| wedding_id | uuid | FK → weddings.id |
| category | text | e.g. "Photographer" |
| name | text | |
| contact | text | |
| price | numeric | |
| status | enum | 'booked', 'contacted', 'considering' |
| notes | text | |

### budget_items (coming next)
| Column | Type | Notes |
|---|---|---|
| id | uuid | |
| wedding_id | uuid | FK → weddings.id |
| category | text | |
| description | text | |
| estimated | numeric | |
| actual | numeric | |
| paid | boolean | |

---

## API Routes

### Auth
| Method | Endpoint | Description |
|---|---|---|
| POST | /api/auth/signup | Register new user |
| POST | /api/auth/login | Login user |
| POST | /api/auth/logout | Logout |
| POST | /api/auth/reset-password | Send reset email |

### Weddings
| Method | Endpoint | Description |
|---|---|---|
| GET | /api/weddings | Get all weddings for user |
| POST | /api/weddings | Create new wedding |
| GET | /api/weddings/:id | Get single wedding |
| PUT | /api/weddings/:id | Update wedding |
| DELETE | /api/weddings/:id | Delete wedding |

### Moodboards
| Method | Endpoint | Description |
|---|---|---|
| GET | /api/moodboards/:weddingId | Get all moodboards |
| POST | /api/moodboards | Create moodboard |
| POST | /api/moodboards/generate | AI generation |
| PUT | /api/moodboards/:id | Update moodboard |
| DELETE | /api/moodboards/:id | Delete moodboard |

### Guests & RSVP
| Method | Endpoint | Description |
|---|---|---|
| GET | /api/guests/:weddingId | Get guest list |
| POST | /api/guests | Add guest |
| PUT | /api/guests/:id | Update guest |
| DELETE | /api/guests/:id | Remove guest |
| POST | /api/guests/import | Bulk CSV import |
| POST | /api/rsvp/send | Send invitations |
| GET | /api/rsvp/:token | Public RSVP page data |
| POST | /api/rsvp/:token | Submit RSVP response |

---

## User Flows

### New User Flow
```
Landing Page → Sign Up → Onboarding (4 steps) → Dashboard
```

### Onboarding Steps
```
Step 1: Are you a bride or a wedding planner?
Step 2: Wedding details (couple name, date, venue, guest count)
Step 3: Style preferences (color palette, theme/vibe)
Step 4: Welcome screen — "Your planning HQ is ready 🎉"
```

### Planner Multi-Wedding Flow
```
Login → Dashboard (Wedding Selector) → Pick/Create Wedding → Features
```

---

## Frontend Routes

```
/                        → Landing page (brideside.html)
/login                   → Login
/signup                  → Signup
/forgot-password         → Password reset
/onboarding              → Onboarding flow (4 steps)
/dashboard               → Main dashboard
/dashboard/moodboard     → Moodboard list
/dashboard/moodboard/:id → Moodboard editor
/dashboard/website       → Wedding website builder
/dashboard/guests        → Guest list manager
/dashboard/rsvp          → RSVP tracker
/dashboard/vendors       → Vendor manager (coming next)
/dashboard/budget        → Budget tracker (coming next)
/dashboard/settings      → Account settings
/w/:slug                 → Public wedding website (for guests)
/rsvp/:token             → Public RSVP form (for guests)
```

---

## Environment Variables

```bash
# client/.env
VITE_SUPABASE_URL=
VITE_SUPABASE_ANON_KEY=
VITE_API_URL=http://localhost:3001

# server/.env
SUPABASE_URL=
SUPABASE_SERVICE_KEY=
OPENAI_API_KEY=
RESEND_API_KEY=
JWT_SECRET=
PORT=3001
```

---

## Build Order (Recommended)

### Phase 1 — Foundation
1. Project setup (Vite + Tailwind + React Router)
2. Supabase project + database tables
3. Auth flow (signup, login, logout)
4. Onboarding flow
5. Dashboard shell + sidebar navigation

### Phase 2 — MVP Features
6. Guest list manager
7. Invitation sender + RSVP flow
8. AI Moodboard Generator
9. Wedding Website Builder

### Phase 3 — Growth Features
10. Vendor Manager
11. Budget Tracker
12. Planner multi-wedding support
13. Mobile PWA enhancements

---

*BrideSide Architecture v1.0 — Built with React, Node.js, Supabase*
