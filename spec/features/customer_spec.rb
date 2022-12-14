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


  scenario 'Mostra um cliente ' do
    customer = create(:customer)

    visit(customer_path(customer.id))

    expect(page).to have_content(customer.name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end


  scenario 'Testando index' do
    customer1 = create(:customer)

    customer2 = create(:customer)

    visit(customers_path)

    expect(page).to have_content(customer1.name).and have_content(customer2.name)

  end

  scenario 'Mostra um cliente ' do
    customer = create(:customer)

    new_name = Faker::Name.name

    visit(edit_customer_path(customer.id))

    fill_in('customer_name', with: new_name)

    click_on('Atualizar Cliente')
    expect(page).to have_content('Cliente atualizado com sucesso')

    expect(page).to have_content(new_name)
    expect(page).to have_content(customer.email)
    expect(page).to have_content(customer.phone)
  end

  scenario 'Clica no link mostrar' do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr/td[3]/a").click
    

    expect(page).to have_content("Informação do Cliente")

  end

  scenario 'Clica no link editar' do
    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr/td[4]/a").click
    

    expect(page).to have_content("Edição do Cliente")

  end

  scenario 'Clica no link excluir', js:true do

    customer = create(:customer)

    visit(customers_path)
    find(:xpath, "/html/body/table/tbody/tr/td[5]/a").click
    2.second
    page.driver.browser.switch_to.alert.accept
    

    expect(page).to have_content("Cliente excluido com sucesso")

  end

end
