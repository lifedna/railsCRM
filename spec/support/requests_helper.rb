  def create_user_and_login
    @company = Fabricate(:organisation)
    @user = Fabricate(:user, :organisation => @company)
    @user.confirm!
    visit "/"
    save_and_open_page
    click_link 'Sign in'
    fill_in("Email", :with => @user.email)
    fill_in("Password", :with => @user.password)
    click_button 'Sign in'
    @user
  end
