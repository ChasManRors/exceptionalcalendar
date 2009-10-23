class Participant < ActiveRecord::Base

  belongs_to :meeting

  validates_presence_of :meeting_id
  
  validates_format_of :collection_of_unavailable_days, :with => /\s*([0-9]+[0-9]+\s*\/\s*[0-9]+[0-9]\s*)*/  #, :on => :create
  def collect_all_available_days
    
  end


end
