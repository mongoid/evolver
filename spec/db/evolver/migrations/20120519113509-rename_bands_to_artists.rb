class RenameBandsToArtists
  include Evolver::Migration

  sessions :default

  def execute
    session[:objects].find.update_all("$rename" => { "bands" => "artists" })
  end

  def revert
    session[:objects].find.update_all("$rename" => { "artists" => "bands" })
  end
end
