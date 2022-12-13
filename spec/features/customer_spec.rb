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

  scenario 'Cadastra cliente com sucesso' do
    visit(new_customer_path)

    customer_name = Faker::Name.name
    
    fill_in('customer_name', with: customer_name)
    fill_in('customer_email', with: Faker::Internet.email)
    fill_in('customer_phone', with: Faker::PhoneNumber.phone_number)
    attach_file('customer_avatar', "#{Rails.root}/spec/fixtures/avatar.png")
    choose(option: ['S', 'N'].sample)

    click_on('Criar Cliente')

    expect(page).to have_content('Cliente cadastrado com sucesso')
    expect(Customer.last.name).to eq(customer_name)
  end

  scenario 'Falha de cadastro ' do
    visit(new_customer_path)

    click_on('Criar Cliente')

    expect(page).to have_content('não pode ficar em branco')
  end
end