class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.bigint :mobile_number
      t.string :address
      t.string :job_title

      t.timestamps
    end
  end
end
