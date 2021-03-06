class Meeting < ActiveRecord::Base

  validates_presence_of  :num_days_forward_to_consider
  validates_presence_of  :title
  validates_presence_of  :num_days_before_scheduling
  validates_presence_of  :number_of_people_who_need_to_respond_before_suggesting_a_date

  has_many :participants

  has_many :comments


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

  def calc_current_unavailable_days_sans(participant)
    (self.participants.reject{|p| p.id == participant.id}).map(&:collection_of_unavailable_days).map(&:strip).join(' ').split
  end

  def add_new_participant(participant)
    participant_unavailable_days = participant.collection_of_unavailable_days.split
    previous_tentative_days = self.tentative_days.split
    self.tentative_days = (previous_tentative_days - participant_unavailable_days).join(' ')
    self.participants << participant
  end

  def new_meeting_params_from(participant, params)
    @tentative_unavailable_days = self.calc_current_unavailable_days_sans(participant)
    @tentative_unavailable_days = @tentative_unavailable_days + params[:collection_of_unavailable_days].split
    @tentative_days = self.calc_tentative_days() - @tentative_unavailable_days
    self.attributes.merge({"tentative_days" => @tentative_days.join(' ')})
  end

end
