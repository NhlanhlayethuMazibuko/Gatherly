# Gatherly

**Where communities come alive.**

Gatherly is an 18+ app that helps students and young adults find things to do near them, and people to do them with. It brings events, user-hosted gatherings and local discovery together in one place.

> **Status: planning and design.** I'm currently designing the app in Figma and defining the requirements. Code starts once the core screens and design system are done.

---

## The problem

When you move to a new town for university or work, it's hard to know what's happening, where people go, or how to meet people with the same interests. Events are scattered across Instagram, WhatsApp groups and posters, and there's no easy way to start something yourself, like a braai, a hiking group or a gaming night, and invite people beyond your existing friends.

## The solution

One app that answers three questions:

1. **What's happening around me?** Events near you, filtered by date, price, category and *vibe* (Party, Chill, Social, Romantic, Creative, Active, Foodie).
2. **Where can I go and what can I do?** A map of events and gatherings nearby.
3. **Who can I experience it with?** Gatherings hosted by other users, which you can join, request to join or be invited to.

---

## Features

### First release (MVP)

- **Discover:** a feed of events and gatherings in your city, with search, filters and a map
- **Event details:** date, venue, price, age limit, vibes, organiser, directions and ticket links
- **Gatherings:** anyone 18+ can host a gathering, with three access types:
  - **Public:** anyone can join until it's full
  - **Request to join:** the host approves each person
  - **Invite only:** hidden from search and shared by private link
- **Hosting tools:** attendee limit, approve or remove attendees, announcements, edit or cancel
- **Saved and My plans:** bookmarked events, and gatherings you've joined or requested
- **Event submission:** anyone can submit an event; it goes live only after moderation
- **Safety:** 18+ sign-up, report and block, approximate location until approved, and an admin moderation panel

---

## Planned tech stack

| Layer | Technology |
| --- | --- |
| Mobile app and admin panel | Flutter and Dart |
| API | ASP.NET Core Web API (C#) |
| Database | PostgreSQL on Supabase, with row-level security |
| Sign-in | Supabase Auth (email and Google) |
| File storage | Supabase Storage |
| Maps | Google Maps Platform |
| Push notifications | Firebase Cloud Messaging (Version 1) |
| Design | Figma |


## Project structure

```
Gatherly/
  apps/
    mobile/        Flutter app for Android and iOS
    admin/         Flutter web admin panel for moderators
  api/
    src/           ASP.NET Core Web API
    tests/         xUnit tests
  supabase/        database config, migrations and seed data
  docs/            development setup and project docs
  .github/         CI: API tests and Flutter checks on every push
```


## About

Designed and built by **Nhlanhla Mazibuko**, IT student at the Central University of Technology.

[GitHub](https://github.com/NhlanhlayethuMazibuko) · [LinkedIn](https://www.linkedin.com/in/nhlanhlayethu-mazibuko-a5469a242)
