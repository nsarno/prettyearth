require 'json'

namespace :data do

  desc "Collect Earth View data from `https://www.gstatic.com/prettyearth/`"
  task collect: :environment do
    begin
      filename = 'public/prettyearth_ids.json'
      ids = JSON.parse(open(filename).read)
      ids.each do |id|
        EarthView.create_from_prettyearth id
      end
      EarthView.create_from_prettyearth ids[0]
    rescue SystemCallError, JSON::ParserError => e
      STDERR.puts "Error: #{e.message}"
    end
  end

end
