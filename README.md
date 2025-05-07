# README

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
