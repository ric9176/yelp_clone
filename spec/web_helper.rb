def sign_up
  click_link("Sign up")
  fill_in("Email", with: "test@test.com")
  fill_in("Password", with: "test1234")
  fill_in("Password confirmation", with: "test1234")
  click_button("Sign up")
end

def add_restaurant
  click_link("Add a restaurant")
  fill_in("Name", with: "classic dive")
  click_button("Create Restaurant")
end
