class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :location

      t.timestamps
    end
  end
end
