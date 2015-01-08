class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :campaign_source
      t.string :promo_code
      t.string :remote_ip

      t.timestamps
    end
  end
end
