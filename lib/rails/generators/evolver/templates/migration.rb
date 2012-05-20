class <%= migration_class_name %>
  include Evolver::Migration
  sessions :default

  def execute
    # Insert your code to migrate the database forward here.
  end

  def revert
    # Insert your code to revert the migration here.
  end
end
