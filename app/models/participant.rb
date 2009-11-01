class Participant < ActiveRecord::Base

  belongs_to :meeting

  validates_presence_of :meeting_id
  
  validates_format_of :collection_of_unavailable_days, :with => /\s*([0-9]+[0-9]+\s*\/\s*[0-9]+[0-9]\s*)*/  #, :on => :create

  # def collect_all_available_days
  # end

  def available_days
    unavailable = []
    unavailable = collection_of_unavailable_days.split unless collection_of_unavailable_days.blank?
    (self.meeting.calc_tentative_days -  unavailable).join(' ')
  end
  
  def available_days=(days)
    self.collection_of_unavailable_days =  (self.meeting.calc_tentative_days - days.split).join(' ') unless days.blank?
  end

end
