require 'rails_helper'

feature 'Admin edits car categories' do
  scenario 'successfully' do
    CarCategory.create(name: 'SUV', daily_rate: '120', car_insurance: '60', third_party_insurance: '50')

    visit root_path
    click_on 'Categorias de veículos'
    click_on 'SUV'
    click_on 'Editar'
    fill_in 'Nome', with: 'Sedan'
    fill_in 'Diária', with: '120.99'
    fill_in 'Seguro', with: '40'
    fill_in 'Seguro contra terceiros', with: '50'
    click_on 'Enviar'

    expect(page).to have_content('Sedan')
    expect(page).to have_content('120.99')
    expect(page).to have_content('40')
    expect(page).to have_content('50')
    expect(page).to have_content('Categoria atualizada com sucesso!')
  end

  scenario 'and must fill in all fields' do
    CarCategory.create(name: 'SUV', daily_rate: '120', car_insurance: '60', third_party_insurance: '50')

    visit car_categories_path
    click_on 'SUV'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Diária', with: '120.99'
    fill_in 'Seguro', with: '40'
    fill_in 'Seguro contra terceiros', with: '50'
    click_on 'Enviar'

    expect(page).to have_content('Você deve preencher todos os campos')
  end

  scenario 'and must be unique' do
    CarCategory.create(name: 'SUV', daily_rate: '120', car_insurance: '60', third_party_insurance: '50')
    CarCategory.create(name: 'Sedan', daily_rate: '120', car_insurance: '60', third_party_insurance: '50')

    visit car_categories_path
    click_on 'Sedan'
    click_on 'Editar'
    fill_in 'Nome', with: 'SUV'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
end