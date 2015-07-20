require 'rails_helper'

describe 'integration testing' do
  def link_test(target)
    click_link target
    expect(current_url).to eq send(:"#{target.downcase}_url")
  end

  describe "all home links" do
    before(:each) do
      visit root_path
    end

    let(:list) { ['About', 'Contact', 'Help', 'Home'] }

    it 'should exist' do
      list.each { |target| link_test(target)}
    end
  end

  it 'displays the Help page title' do
    visit help_path
    expect(page).to have_title 'Help'
  end

  it 'allows users signup' do
    visit signup_path
    expect(current_url).to eq(signup_url)
  end

  context 'user creation' do
    def fill_input(args)
      args.each do |key, val|
        fill_in key, with: val
      end
    end

    context 'given valid data' do
      it 'creates a new user' do
        visit signup_path
        args = {'Name' => 'Peppe',
                'Email' => 'marpione@gmail.com',
                'Password' => 'Peppe123!',
                'Password Confirmation' => 'Peppe123!'}
        fill_input(args)
        total_users = User.count
        click_on 'Create User'
        expect(User.count).to eq(total_users + 1)
      end
    end

    context 'given incomplete data' do
      it 'does not create a new user' do
        visit signup_path
        args = {'Name' => 'Peppe'}
        fill_input(args)
        total_users = User.count
        click_on 'Create User'
        expect(User.count).to eq(total_users)
      end
    end
  end
end