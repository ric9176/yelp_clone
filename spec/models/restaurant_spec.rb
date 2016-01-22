require 'rails_helper'



describe Restaurant, type: :model do
  it { is_expected.to have_many :reviews}
end

describe Restaurant, :type => :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end
end

describe '#average_rating' do
  context 'no reviews' do
    it 'returns "N/A" when there are no reviews' do
      restaurant = Restaurant.create(name: 'The Ivy')
      expect(restaurant.average_rating).to eq 'N/A'
    end
  end

  context '1 review' do
    it 'returns that rating' do
      restaurant = Restaurant.create(name: 'The Ivy')
      restaurant.reviews.create(rating: 4)
      expect(restaurant.average_rating).to eq 4
    end
  end



  context 'multiple reviews' do
    it 'returns the average' do
      user1 = User.create(email: "test@tits.com", password: 12345678, password_confirmation: 12345678)
      user2 = User.create(email: "test@test.com", password: 12345678, password_confirmation: 12345678)
      restaurant = Restaurant.create(name: 'The Ivy')
      restaurant.reviews.create(rating: 1, user_id: user1.id)
      restaurant.reviews.create(rating: 5, user_id: user2.id)
      expect(restaurant.average_rating).to eq 3
    end
  end

end
