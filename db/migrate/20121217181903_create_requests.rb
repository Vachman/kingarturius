class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :phone
      t.string :full_name
      t.string :email
      t.string :request_type
      t.text :information

      t.timestamps
    end
  end
end
