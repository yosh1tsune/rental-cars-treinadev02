require 'rails_helper'

feature 'Admin edits clientd' do
  scenario 'successfully' do
    Client.create(name: 'Bruno Silva', cpf: '111.222.333-44', email: 'bruno@email.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Bruno Silva'
    click_on 'Editar'
    fill_in 'Nome', with: 'Bruno Reis'
    fill_in 'CPF', with: '111.222.333-44'
    fill_in 'Email', with: 'bruno@email.com'
    click_on 'Enviar'

    expect(page).to have_content('Bruno Reis')
    expect(page).to have_content('111.222.333-44')
    expect(page).to have_content('bruno@email.com')
    expect(page).to have_content('Cliente atualizado com sucesso!')
  end

  scenario 'and must fill in all fields' do
    Client.create(name: 'Bruno Silva', cpf: '111.222.333-44', email: 'bruno@email.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Bruno Silva'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'CPF', with: '111.222.333-44'
    fill_in 'Email', with: 'bruno@email.com'
    click_on 'Enviar'

    expect(page).to have_content('Você deve preencher todos os campos')
  end

  scenario 'and must be unique' do
    Client.create(name: 'Bruno Silva', cpf: '111.222.333-44', email: 'bruno@email.com')
    Client.create(name: 'Bruno Reis', cpf: '555.666.777-88', email: 'bruno2@email.com')

    visit root_path
    click_on 'Clientes'
    click_on 'Bruno Reis'
    click_on 'Editar'
    fill_in 'Nome', with: 'Bruno Reis'
    fill_in 'CPF', with: '111.222.333-44'
    fill_in 'Email', with: 'bruno@email.com'
    click_on 'Enviar'

    expect(page).to have_content('CPF já cadastrado')
  end
end