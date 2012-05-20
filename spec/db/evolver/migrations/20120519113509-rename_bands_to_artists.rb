class RenameBandsToArtists
  include Evolver::Migration

  sessions :default

  def execute
    session[:labels].find.update_all("$rename" => { "bands" => "artists" })
  end

  def revert
    session[:labels].find.update_all("$rename" => { "artists" => "bands" })
  end
end
