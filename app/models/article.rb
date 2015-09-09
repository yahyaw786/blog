class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }
  searchable do
    text :title, :text
    integer :user_id

  end 
end