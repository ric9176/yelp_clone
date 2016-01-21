require 'rails_helper'


feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to ad a new restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Hawksmoor')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Hawksmoor')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Hawksmoor'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Hawksmoor'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        visit '/restaurants'
        sign_up
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: 'KFC'}

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      sign_up
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do


    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      sign_up
      add_restaurant
      click_link 'Delete classic dive'
      expect(page).not_to have_content 'classic dive'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

  context 'deleting restaurants a user has not created' do
    before {Restaurant.create name: 'KFC'}

    scenario 'a user cannot delete a restaurant they did not create' do
      visit '/restaurants'
      sign_up
      add_restaurant
      click_link 'Delete KFC'
      expect(page).to have_content 'KFC'
    end
  end

end
