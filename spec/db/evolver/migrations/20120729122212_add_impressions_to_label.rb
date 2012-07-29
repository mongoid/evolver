class AddImpressionsToLabel
  include Evolver::Migration

  sessions :mongohq_repl

  def execute
    session[:labels].find.update_all("$set" => { "impressions" => 0 })
  end

  def revert
    session[:labels].find.update_all("$unset" => { "impressions" => true })
  end
end
