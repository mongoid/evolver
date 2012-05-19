Evolver
=======

Database Schema Evolution for MongoDB

# Roadmap

- Generation of migrations in `db/evolutions` so as not to conflict with AR
  migrations.

- Rake task `db:evolve` that works in Rails, Sinatra, Padrino, or standalone.

- Rails generator `rails g evolution` or Rake generator
  `rake db:evolutions:generate`.

- Logging of evolutions that have already run in the particular environment,
  indicating they can be deleted.

- Multi-database and multi-session evolutions, with evolver keeping track of
  what data has been evolved and where. Evolver will store it's information
  in it's own `evolver` database, with an `evolutions` collection that records:
  `session_name`, `database_name`, `evolution_name`, and `evolution_time`.
