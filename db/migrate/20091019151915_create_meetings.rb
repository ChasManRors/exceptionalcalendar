class CreateMeetings < ActiveRecord::Migration
  def self.up
    create_table :meetings do |t|
      t.integer :num_days_forward_to_consider
      t.string :title
      t.integer :num_days_before_scheduling
      t.integer :number_of_people_who_need_to_respond_before_suggesting_a_date
      t.string :tentative_days 
 
      t.timestamps
    end
  end

  def self.down
    drop_table :meetings
  end
end