class AddUserIdInArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :user_id, :integer
  end
end
