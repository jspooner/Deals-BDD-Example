class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.datetime :start_date
      t.datetime :end_date
      t.integer :quantity
      t.text :description

      t.timestamps
    end
  end
end
