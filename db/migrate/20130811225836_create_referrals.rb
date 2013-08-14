class CreateReferrals < ActiveRecord::Migration
  def change
    create_table :referrals do |t|
      t.string :referral_description

      t.timestamps
    end
  end
end
