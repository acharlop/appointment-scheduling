class CreateAppts < ActiveRecord::Migration
  def change
    create_table :appts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :first_name
      t.string :last_name
      t.text :comments

      t.timestamps null: false
    end
  end
end
