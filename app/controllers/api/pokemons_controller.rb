module Api
    class PokemonsController < ApplicationController
        def index
            page_number = params[:page].to_i
            per_page = params[:per_page].to_i

            if page_number == 0
                page_number = 1
            end

            if per_page == 0
                per_page = 10
            end

            offset = (page_number - 1) * per_page

            pokemons = Pokemon.limit(per_page).offset(offset)
            render json: {status: 'SUCCESS', data: pokemons}, status: :ok
        end

        def create
            pokemon = Pokemon.new(pokemon_params)

            if pokemon.save
                render json: {status: 'SUCCESS', data: pokemon}, status: :ok
            else
                render json: {status: 'ERROR', data: pokemon.errors}, status: :unprocessable_entity
            end
        end

        def update
            begin
                pokemon = Pokemon.find(params[:id]) 

                if pokemon.update(pokemon_params)
                    render json: {status: 'SUCCESS', data: pokemon}, status: :ok
                else
                    render json: {status: 'ERROR', data: pokemon.errors}, status: :unprocessable_entity
                end
            rescue ActiveRecord::RecordNotFound => e
                render json: {status: 'ERROR', data: e}, status: :not_found
            end
        end

        def destroy
            begin
                pokemon = Pokemon.find(params[:id])
                pokemon.destroy
                render json: {status: 'SUCCESS', data: pokemon}, status: :ok
            rescue ActiveRecord::RecordNotFound => e
                render json: {status: 'ERROR', data: e}, status: :not_found
            end
        end

        private
        def pokemon_params
            params.permit(:name, :type1, :type2, :total, :hp, :attack, :defense, :spatk, :spdef, :speed, :generation, :legendary)
        end
    end
end