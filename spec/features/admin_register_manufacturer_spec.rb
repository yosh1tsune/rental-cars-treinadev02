require 'rails_helper'

feature 'Admin register manufacturer' do
  scenario 'successfully' do
    user = User.create(email: 'bruno@email.com', password: '123456789', role: 1)

    login_as(user)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Registrar novo fabricante'

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Fiat')
  end

  scenario 'and must fill in all fields' do
    user = User.create(email: 'bruno@email.com', password: '123456789', role: 1)

    login_as(user)
    visit new_manufacturer_path

    # fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve preencher todos os campos')
  end

  scenario 'and must be unique' do
    user = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
    Manufacturer.create(name: 'Fiat')


    login_as(user)
    visit new_manufacturer_path

    fill_in 'Nome', with: 'Fiat'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end

  scenario 'and must be logged in' do
    visit root_path
    click_on 'Fabricantes'

    expect(page).not_to have_link('Registrar novo fabricante')
  end

  scenario 'and redirect to login page if not' do
    visit new_manufacturer_path

    expect(current_path).to eq new_user_session_path
  end
end