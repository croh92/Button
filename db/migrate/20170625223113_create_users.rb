class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.column :provider, :string
      t.column :uid, :integer
      t.column :token, :string
      t.column :secret, :string
      t.column :name, :string
    end
  end
end
