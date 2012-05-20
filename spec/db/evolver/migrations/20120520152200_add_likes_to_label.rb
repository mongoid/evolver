class AddLikesToLabel
  include Evolver::Migration

  sessions :default

  def execute
    session[:labels].find.update_all("$set" => { "likes" => 0 })
  end

  def revert
    session[:labels].find.update_all("$unset" => { "likes" => true })
  end
end
