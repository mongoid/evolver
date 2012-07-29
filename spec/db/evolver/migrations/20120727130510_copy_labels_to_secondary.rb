class CopyLabelsToSecondary
  include Evolver::Migration

  sessions :default

  def execute
    session.use(:evolver_secondary)
    session[:labels].insert({ bands: [ "Tool" ]})
  end

  def revert
    session.use(:evolver_secondary)
    session[:labels].find.remove_all
  end
end
