require 'rails_helper'

feature 'Admin view car categories' do
  scenario 'successfully' do
    CarCategory.create(name: 'Sedan', daily_rate: '150,90', car_insurance: '20,80', third_party_insurance: '50')

    visit root_path
    click_on 'Categorias de veículos'

    expect(page).to have_content('Sedan')
    expect(page).to have_link('Voltar')
  end
end