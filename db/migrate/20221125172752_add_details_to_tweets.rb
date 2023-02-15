class AddDetailsToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :name, :string
    add_column :tweets, :adress, :string
  end
end
