# encoding: utf-8
namespace :evolver do

  desc "Execute any pending MongoDB data migrations on all sessions."
  task migrate: :environment do
    Evolver.migrate
  end

  namespace :migrate do
    desc "Dry run of any pending MongoDB data migrations on all sessions."
    task dry: :environment do
      Evolver.migrate(dry: true)
    end
  end

  desc "Revert the last run MongoDB data migration."
  task revert: :environment do
    Evolver.revert
  end

  desc "Get statistics on all pending and run MongoDB data migrations."
  task stats: :environment do
    Evolver.stats
  end
end
