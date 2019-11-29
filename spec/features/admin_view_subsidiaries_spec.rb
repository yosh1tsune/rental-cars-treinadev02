require 'rails_helper'

feature 'Admin view subsidiaries' do
  scenario 'successfully' do
    Subsidiary.create(name: 'São Paulo', cnpj: '12.345.678/9999-00', address: 'Alameda Santos, 1293')

    visit root_path
    click_on 'Filiais'
    click_on 'São Paulo'

    expect(page).to have_content('São Paulo')
    expect(page).to have_content('12.345.678/9999-00')
    expect(page).to have_content('Alameda Santos, 1293')
    expect(page).to have_link('Voltar')
  end
end