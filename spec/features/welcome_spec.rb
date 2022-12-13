require 'rails_helper'

RSpec.feature "Welcomes", type: :feature do
  
  scenario 'Mostra a mensagem de boas vindas' do
    visit('/')

    expect(page).to have_content('Bem Vindo')
  end
  
end
