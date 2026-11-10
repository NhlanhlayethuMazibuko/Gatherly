# Development setup

How to get Gatherly running on your machine.

## What you need

| Tool | Version | Used for |
| --- | --- | --- |
| [.NET SDK](https://dotnet.microsoft.com/download) | 10 | The API |
| [Flutter](https://docs.flutter.dev/get-started/install) | 3.41 (stable) | Mobile app and admin panel |
| [Android Studio](https://developer.android.com/studio) | Latest | Android emulator and SDK |
| [Node.js](https://nodejs.org) | LTS | Runs the Supabase CLI through `npx` |
| [VS Code](https://code.visualstudio.com) | Latest | Editor; install the recommended extensions when asked |

Optional: [Docker Desktop](https://www.docker.com/products/docker-desktop/), to run Supabase locally with `npx supabase start`. Without it, use a free hosted Supabase project.

Check that everything is installed:

```bash
dotnet --version
flutter doctor
node --version
```

## First-time setup

1. Copy `.env.example` to `.env` and fill in your Supabase and Google Maps values.
2. Restore the API packages:

   ```bash
   dotnet restore api/Gatherly.slnx
   ```

3. Get the Flutter packages for both apps:

   ```bash
   cd apps/mobile && flutter pub get
   cd ../admin && flutter pub get
   ```

## Running

In VS Code, open the **Run and Debug** panel and pick one:

- **API (ASP.NET Core):** runs on http://localhost:5023. Check http://localhost:5023/health.
- **Mobile app (Flutter):** start an Android emulator first.
- **Admin panel (Flutter web):** opens in Chrome.

Or from a terminal:

```bash
dotnet run --project api/src/Gatherly.Api
```

```bash
cd apps/mobile && flutter run
```

```bash
cd apps/admin && flutter run -d chrome
```

## Tests and checks

```bash
dotnet test api/Gatherly.slnx
```

```bash
cd apps/mobile && flutter analyze
```

GitHub Actions runs the same checks on every push and pull request (`.github/workflows/ci.yml`).

## Database

- Migrations go in `supabase/migrations`, one SQL file per change, created with `npx supabase migration new <name>`.
- Local test data goes in `supabase/seed.sql`.
- Never commit `.env` or any service-role key.

## Working on a feature

1. Create a branch: `git checkout -b feature/short-name`.
2. Commit small steps, mentioning requirement IDs where they apply (for example `GAT-5`).
3. Push and open a pull request; merge when CI passes.
