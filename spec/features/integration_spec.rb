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

  it 'for Help page title' do
    visit help_path
    expect(page).to have_title 'Help'
  end

  it 'allows users signup' do
    visit signup_path
    expect(current_url).to eq(signup_url)
  end
end