class Participant < ActiveRecord::Base

  belongs_to :meeting

  validates_presence_of :meeting_id
  
  def collect_all_available_days
    
  end


end
