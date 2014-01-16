class CreateOmniReferences < ActiveRecord::Migration
  def change
    create_table :omni_references do |t|
      t.integer :user_id,  null: false
      t.integer :provider, null: false, limit: 3
      t.string  :uuid,     null: false
      t.string  :account,  null: false
      t.string  :email
      t.timestamps
    end
    add_index :omni_references, [:provider, :uuid], unique: true
  end
end
