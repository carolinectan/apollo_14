require 'rails_helper'
RSpec.describe 'astronaut index page' do
  before :each do
    @astronaut1 = Astronaut.create!(name: 'Neil Armstrong', age: 37, job: 'Commander')
    @astronaut2 = Astronaut.create!(name: 'Sally Ride', age: 32, job: 'Deputy Commander')

    @mission1 = Mission.create!(title: 'Moon', time_in_space: 150)
    @mission2 = Mission.create!(title: 'Mars', time_in_space: 365)

    @astronaut_mission1 = AstronautMission.create!(astronaut: @astronaut1, mission: @mission1)
    @astronaut_mission2 = AstronautMission.create!(astronaut: @astronaut2, mission: @mission1)
    @astronaut_mission3 = AstronautMission.create!(astronaut: @astronaut1, mission: @mission2)
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
  end

  it 'can list the space missions in alphabetical order for each astronaut' do
    visit '/astronauts'

    within "#astronaut-#{@astronaut1.id}" do
      expect(page).to have_content(@mission1.title)
      expect(page).to have_content(@mission2.title)
    end

    within "#astronaut-#{@astronaut2.id}" do
      expect(page).to have_content(@mission1.title)
      expect(page).to_not have_content(@mission2.title)
    end
    # (e.g "Apollo 13"
    #      "Capricorn 4"
    #      "Gemini 7")
  end
end
