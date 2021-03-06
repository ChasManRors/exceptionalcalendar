class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name
      t.string :collection_of_unavailable_days 
      t.references :meeting 
      t.timestamps
    end
  end

  def self.down
    drop_table :participants
  end
end