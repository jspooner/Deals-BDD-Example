class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.integer :quantity, :default => 0
      t.integer :number_sold, :default => 0

      t.timestamps
    end
  end
end