require 'rails_helper'
RSpec.describe 'astronaut index page' do
  before :each do
    @astronaut1 = Astronaut.create!(name: 'Neil Armstrong', age: 37, job: 'Commander')
    @astronaut2 = Astronaut.create!(name: 'Sally Ride', age: 32, job: 'Deputy Commander')

  end

  it 'can list all astronauts and their attributes' do
    visit '/astronauts'

    expect(page).to have_content("All Astronauts")

    within "#astronaut-#{@astronaut1.id}" do
      expect(page).to have_content(@astronaut1.name)
      expect(page).to have_content(@astronaut1.age)
      expect(page).to have_content(@astronaut1.name)
    end

    within "#astronaut-#{@astronaut2.id}" do
      expect(page).to have_content(@astronaut2.name)
      expect(page).to have_content(@astronaut2.age)
      expect(page).to have_content(@astronaut2.name)
    end
    # (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander")
  end

  it 'can display the average age of all astronauts' do
    visit '/astronauts'

    expect(page).to have_content("Average Age: 34.5")
  # (e.g. "Average Age: 34")
  end
end
