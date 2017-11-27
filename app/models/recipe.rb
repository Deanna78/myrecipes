class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  belongs_to :chef
  validates :chef_id, presence: true
  validates_inclusion_of :group, :in => %w(  Aperitif , Mains , Dessert )

end
