class Event < ActiveRecord::Base

  belongs_to :project

  FORMAT_STRING = "%Y-%m-%e %H:%M"

  def self.format_string
    FORMAT_STRING
  end

  def self.format_time time
    time.strftime(FORMAT_STRING)
  end

  def self.datetime_from_string str
    Time.strptime(str, FORMAT_STRING)
  end

  def formatted_time
    self.event_time = Time.now if self.event_time.nil?
    # self.format_time self.event_time
    self.event_time.strftime(FORMAT_STRING)
  end

  def formatted_time= str
    self.event_time = Time.strptime(str, FORMAT_STRING)
  end


end
