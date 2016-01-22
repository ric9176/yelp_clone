require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'Mcdonalds'}


  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    sign_up
    click_link'Review Mcdonalds'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    visit '/restaurants'
    sign_up
    leave_review('So so', '3')
    click_link 'Sign out'
    second_sign_up
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end

  def leave_review(thoughts, rating)
    visit '/restaurants'
    click_link 'Review Mcdonalds'
    fill_in 'Thoughts', with: thoughts
    select rating, from: 'Rating'
    click_button 'Leave Review'
  end
end
