class Meeting < ActiveRecord::Base

  validates_presence_of  :num_days_forward_to_consider
  validates_presence_of  :title
  validates_presence_of  :num_days_before_scheduling
  validates_presence_of  :number_of_people_who_need_to_respond_before_suggesting_a_date

  has_many :participants

  def calc_tentative_days()
    arr = []
    b = num_days_forward_to_consider.to_i.times{|d| 
      t = Time.zone.now
      start_day = t + num_days_before_scheduling.to_i.days
      added_day = ( start_day + (d.day)); 
      not_added_day = added_day.to_date.strftime("%A").to_s; 
      arr.push added_day.to_date.strftime( "%m/%d" ) unless not_added_day == "Saturday" || not_added_day == "Sunday"
    }
    self.tentative_days =  arr.join(" ")
    arr
  end

  def calc_current_unavailable_days
    # self.participants.map(&:collection_of_unavailable_days).map(&:strip)
      self.participants.map(&:collection_of_unavailable_days).map(&:strip).join(' ').split
  end



end
