class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  # code actions here!
  get '/recipes/new' do
    Recipe.new(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    erb :new
  end

  get '/recipes' do
    @recipes = Recipe.all

    erb :index
  end


  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find_by(params[:id])

    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find_by(params[:id])

    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find_by(params[:id])

    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect "/recipes/#{@recipe.id}"

  end

  delete '/recipes/:id' do
    @recipe = Recipe.find_by(params[:id])
    @recipe.delete
    redirect '/recipes'
  end

end
