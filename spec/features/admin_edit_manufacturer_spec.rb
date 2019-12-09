require 'rails_helper'

feature 'Admin edits manufacturer' do
  scenario 'successfully' do
    admin = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
    Manufacturer.create(name: 'Fiat')

    login_as(admin)
    visit root_path
    click_on 'Fabricantes'
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Honda')
    expect(page).to have_content('Fabricante atualizado com sucesso!')
  end

  scenario 'and must fill in all fields' do
    admin = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
    Manufacturer.create(name: 'Fiat')

    login_as(admin)
    visit manufacturers_path
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    click_on 'Enviar'

    expect(page).to have_content('Você deve preencher todos os campos')
  end

  scenario 'and must be unique' do
    admin = User.create(email: 'bruno@email.com', password: '123456789', role: 1)
    Manufacturer.create(name: 'Fiat')
    Manufacturer.create(name: 'Honda')

    login_as(admin)
    visit manufacturers_path
    click_on 'Fiat'
    click_on 'Editar'
    fill_in 'Nome', with: 'Honda'
    click_on 'Enviar'

    expect(page).to have_content('Nome já está em uso')
  end
end