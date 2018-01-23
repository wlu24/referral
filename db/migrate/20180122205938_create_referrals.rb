class CreateReferrals < ActiveRecord::Migration[5.1]
  def change
    create_table :referrals do |t|
      t.integer :from_user_id
      t.integer :to_user_id
      t.string :referral_token
      t.boolean :visited, default: false
      t.boolean :successful, default: false

      t.timestamps
    end

    add_index :referrals, :referral_token, unique: true

    # https://stackoverflow.com/questions/34424154/rails-validate-uniqueness-of-two-columns-together
    # ### adding the uniqueness constraint on (from_user_id, to_user_id) pair
    #
    # this still allows the case where from_user_id == to_user_id
    #
    # but doesn't allow creating new (from_user_id, to_user_id) pairs
    # if the exact same pair already existed in the database
    #
    # add_index :referrals, [:from_user_id, :to_user_id], unique: true

  end
end
