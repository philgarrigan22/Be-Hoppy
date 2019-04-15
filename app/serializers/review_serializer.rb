class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :beer, :brewery, :rating, :location, :type, :flavor
end
