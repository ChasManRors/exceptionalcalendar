class CreateStuffs < ActiveRecord::Migration
  def self.up
    create_table :stuffs do |t|
      t.string :foo
      t.integer :bar
      t.text :baz

      t.timestamps
    end
  end

  def self.down
    drop_table :stuffs
  end
end
