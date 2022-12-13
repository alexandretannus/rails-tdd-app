require 'rails_helper'

RSpec.feature "Customers", type: :feature do
  scenario 'Verifica link cadastro de cliente' do
    visit(root_path)
    expect(page).to have_link('Cadastro de Clientes')
  end

  scenario 'Verifica link de novo cliente' do
    visit(root_path)
    click_on('Cadastro de Clientes')

    expect(page).to have_content('Lista de Clientes')
    expect(page).to have_link('Novo Cliente')
  end

  scenario 'Verifica formulário de novo cliente' do
    visit(customers_path)
    click_on('Novo Cliente')

    expect(page).to have_content('Novo Cliente')
  end
end
