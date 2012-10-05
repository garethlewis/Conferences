require 'rho/rhoapplication'

class AppApplication < Rho::RhoApplication
  def initialize
    # Tab items are loaded left->right, @tabs[0] is leftmost tab in the tab-bar
    # Super must be called *after* settings @tabs!
    @tabs = nil
    #To remove default toolbar uncomment next line:
    @@toolbar = nil
    super

    # Uncomment to set sync notification callback to /app/Settings/sync_notify.
    # SyncEngine::set_objectnotify_url("/app/Settings/sync_notify")
    SyncEngine.set_notification(-1, "/app/Settings/sync_notify", '')
    
    # Load up the EMEA database
    items = EMEA.find(:all)
    if items.empty?
      fileName = File.join(Rho::RhoApplication::get_base_app_path(), '/public/emea.txt')
      lines = File.read(fileName)
      jsonContent = Rho::JSON.parse(lines)
      jsonContent.each do
        |json|
        EMEA.create("name" => json['name'], "type" => json['type'])
      end
    else
      # We already have data.
    end
    
    eventSponsors = EventSponsors.find(:all)
    if eventSponsors.empty?
      fileName = File.join(Rho::RhoApplication::get_base_app_path(), '/public/eventsponsors.txt')
      lines = File.read(fileName)
      jsonContent = Rho::JSON.parse(lines)
      jsonContent.each {
        |json|
        EventSponsors.create("type" => json['type'], "name" => json['name'], "image" => json['image'], "text" => json['text'])
      }
    else
      # We already have data
    end
    
    # Load data for the agenda model
    agendas = Agendas.find(:all)
    if agendas.empty?
      # Load the data as the set is empty
      fileName = File.join(Rho::RhoApplication::get_base_app_path(), '/public/agenda.txt')
      lines = File.read(fileName)
      jsonContent = Rho::JSON.parse(lines)
      jsonContent.each {
        |json|
        Agendas.create("Date" => json['Date'], "Title" => json['Title'], "Text" => json['Text'], "Sessions" => json['Sessions'])
      }
    else
      # We already have data
    end
  end
end
