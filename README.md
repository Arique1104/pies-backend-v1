# The PIES Checkin App

The PIES Checkin App is a wellness and leadership tool designed to help individuals reflect on their Physical, Intellectual, Emotional, and Spiritual wellbeing. Through structured prompts and curated tips, it supports user-led growth, builds healthy habits, and fosters deeper personal awareness across life domains.

Inspired by leading NLP-powered platforms like Noom and evidence-based behavior tools rooted in DBT (Dialectical Behavior Therapy), the PIES Checkin App aims to connect personal insight to meaningful public action. With a focus on leadership development, the app is designed to guide users toward discovering — and contributing to — their political home.

Grounded in the belief that the personal is political, this application helps users grow from inward reflection to outward leadership. With its integrated event management system, organizations can now engage more deeply with their communities by reflecting on the lived experiences and wellness patterns of their base.

At Political Healers, a political home is both a place of rest and a place of action — a space where people feel validated and invested in, while also being invited into shared responsibility and strategic negotiation. The PIES Checkin App is built to help cultivate those spaces — inside ourselves and with one another.  Now more than ever we need a space to practice telling our stories and changing the narrative.

## README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## Database Map
- Table: Description
- users: Main user accounts
- memberships: Connect users ↔ organizations, with roles (member, leader, manager)
- organizations: Collaborative groups, org-scoped features tied here
- events: Org-hosted activities users can reflect on
- pies_entries: User-submitted well-being check-ins
- reflection_tips: Suggested prompts/tips based on PIES entries
- tip_ratings: Tracks helpfulness of reflection tips
- favorite_tips: Tracks tips a user has marked as favorites
- event_hosts: Connects memberships to the events they host
- dismissed_keywords: Ignored/refined NLP keywords per category
- unmatched_keywords: New/unclassified keywords surfaced from user text

keyword dashboard on fronted will:
- review unmatched_keywords and transform them into reflection tips
