Evolver [![Build Status](https://secure.travis-ci.org/mongoid/evolver.png?branch=master&.png)](http://travis-ci.org/mongoid/evolver)
========

Database Schema Evolution for MongoDB

# Roadmap

- Generation of migrations in `db/evolver/migrations` so as not to conflict
  with AR migrations.

- Rake task `evolver:migrate` that works in Rails, Sinatra, Padrino,
  or standalone.

- Rake task `evolver:revert` that works in Rails, Sinatra, Padrino,
  or standalone.

- Rails generator `rails g evolver:migration` or Rake generator
  `rake evolver:generate`.

- Logging of evolutions that have already run in the particular environment,
  indicating they can be deleted.

- Multi-database and multi-session evolutions, with evolver keeping track of
  what data has been evolved and where.

- Ensuring all migrations always run in safe mode.

- Rake task `evolver:stats` that gives information on run and pending
  migrations on each session.

Compatibility
-------------

Evolver is tested against MRI 1.9.2, 1.9.3, 2.0.0, and JRuby (1.9).

License
-------

Copyright (c) 2012 Durran Jordan

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Credits
-------

Durran Jordan: durran at gmail dot com
