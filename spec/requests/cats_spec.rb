require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it 'gets a list of cats' do
      Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Long walks on the beach at sunset',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

       get '/cats'
       cat = JSON.parse(response.body)

      #checking we have successful request /status 200
       expect(response).to have_http_status(200)
       # making sure we are returning accurate amount of data
       expect(cat.length).to eq 1

    end
  end

  describe "POST /create" do
    it "creates a cat" do
      #define the params going to send with request
      cat_params = {
        cat: {
          name: 'Felix',
          age: 4,
          enjoys: 'Meow Mix and breakdancing',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
      # Send request to the server and pass params needed for create
      post '/cats', params: cat_params

      # check for successful response
      expect(response).to have_http_status(200)

      cat = Cat.first
      # Assure created cat has correct attributes
      expect(cat.name).to eq 'Felix'
      expect(cat.age).to eq 4
      expect(cat.enjoys).to eq 'Meow Mix and breakdancing'
      expect(cat.image).to eq 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
    end
  end 

  describe "PATCH /update" do
    it "updates a cat" do

      # create a cat
      cat_params = {
        cat: {
          name: 'Felix',
          age: 4,
          enjoys: 'Meow Mix and breakdancing',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }
      post '/cats', params: cat_params
      cat = Cat.first
      p cat

      # update the cat
      updated_params = {
        cat: {
          name: 'Buster',
          age: 4,
          enjoys:'Meow Mix and breakdancing',
          image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
        }
      }

      patch "/cats/#{cat.id}", params: updated_params

      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status 200
      expect(updated_cat.name).to eq "Buster"
    end
  end

  describe "cannot create a cat witout valid attributes" do
    it " can't create cat without a name" do 
      cat_params = {
        cat: {
          age: 2,
          enjoys: 'Barbeque',
          image: 'bbqandcat.jpg'
        }
      }
      post '/cats', params: cat_params

      cat = JSON.parse(response.body)
      expect(response).to have_http_status(422)
      expect(cat['name']).to include "can't be blank"
    end
  end

end
