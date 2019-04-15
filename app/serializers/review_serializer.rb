class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :beer, :brewery, :rating, :location, :beer_type, :flavor, :user_id
end
