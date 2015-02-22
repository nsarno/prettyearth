require 'open-uri'

class EarthView < ActiveRecord::Base
  belongs_to :country

  PRETTYEARTH_URL = 'https://www.gstatic.com/prettyearth/'

  def self.create_from_prettyearth prettyearth_id
    unless EarthView.exists? prettyearth_id: prettyearth_id
      params = params_from_prettyearth prettyearth_id
      create(params)
    end
  end

  def self.params_from_prettyearth prettyearth_id
    params = {}
    params[:prettyearth_id] = prettyearth_id
    json = json_from_prettyearth prettyearth_id
    unless json.nil?
      params[:lat] = json['lat']
      params[:lng] = json['lng']
      params[:zoom] = json['zoom']
      geocode = json['geocode']
      if geocode.present? && geocode['country'].present?
        params[:country_id] = Country.find_or_create_by(name: geocode['country']).id
      end
    end
    params
  end

  def self.json_from_prettyearth prettyearth_id
    begin
      json = JSON.parse(open("#{PRETTYEARTH_URL}/#{prettyearth_id}.json").read)
    rescue SystemCallError, JSON::ParserError => e
      STDERR.puts e.message
      nil
    end
  end

  def image
    image = nil
    json = EarthView.json_from_prettyearth self.prettyearth_id
    image = json['dataUri'] unless json.nil?
    image
  end

  def gmap_url
    "https://www.google.com/maps/@#{self.lat.to_f},#{self.lng.to_f},#{self.zoom}z/data=!3m1!1e3"
  end
end
