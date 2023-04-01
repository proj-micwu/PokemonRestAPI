require "test_helper"

class PokemonsControllerTest < ActionDispatch::IntegrationTest
    test "should get pokemons with default parameters which is first page of ten pokemons" do
        get "/api/pokemons"
        
        results = JSON.parse(@response.body)
        pokemons = results["data"]

        assert_equal 10, pokemons.size
        assert_equal 1, pokemons[0]["id"]
        assert_equal 10, pokemons[9]["id"]
    end

    test "should get the first page of pokemons" do
        get "/api/pokemons?page=1"

        results = JSON.parse(@response.body)
        pokemons = results["data"]

        assert_equal 10, pokemons.size
        assert_equal 1, pokemons[0]["id"]
        assert_equal 10, pokemons[9]["id"]
    end

    test "should get the second page of pokemons" do
        get "/api/pokemons?page=2"

        results = JSON.parse(@response.body)
        pokemons = results["data"]

        assert_equal 10, pokemons.size
        assert_equal 11, pokemons[0]["id"]
        assert_equal 20, pokemons[9]["id"]
    end

    test "should get the first page of 100 pokemons" do
        get "/api/pokemons?page=1&per_page=100"

        results = JSON.parse(@response.body)
        pokemons = results["data"]

        assert_equal 100, pokemons.size
        assert_equal 1, pokemons[0]["id"]
        assert_equal 100, pokemons[99]["id"]
    end

    test "should create a new pokemon" do
        post "/api/pokemons", params: {
            name: "Mario",
            type1: "normal",
            hp: 99,
            total: 199,
            attack: 20,
            defense: 20,
            spatk: 20,
            spdef: 20,
            speed: 20,
            generation: 1,
            legendary: false
        }

        results = JSON.parse(@response.body)

        assert_equal "SUCCESS", results["status"]
    end

    test "should create a new pokemon with no total parameter provided" do
        post "/api/pokemons", params: {
            name: "Mario",
            type1: "normal",
            hp: 99,
            attack: 20,
            defense: 20,
            spatk: 20,
            spdef: 20,
            speed: 20,
            generation: 1,
            legendary: false
        }

        results = JSON.parse(@response.body)
        pokemons = results["data"]

        assert_equal "SUCCESS", results["status"]
        assert_equal 199, pokemons["total"]
    end

    test "should not create a new pokemon because the provided total value is incorrect" do
        post "/api/pokemons", params: {
            name: "Mario",
            type1: "normal",
            hp: 99,
            total: 4000,
            attack: 20,
            defense: 20,
            spatk: 20,
            spdef: 20,
            speed: 20,
            generation: 1,
            legendary: false
        }

        results = JSON.parse(@response.body)

        assert_equal "ERROR", results["status"]
    end

    test "should update an existing pokemon's name" do
        put "/api/pokemons/1", params: {
            name: "Luigi"
        }

        results = JSON.parse(@response.body)
        pokemons = results["data"]

        assert_equal "SUCCESS", results["status"]
        assert_equal "Luigi", pokemons["name"]
    end

    test "should update an existing pokemon's attack and defense" do
        put "/api/pokemons/1", params: {
            attack: 50,
            defense: 50
        }

        results = JSON.parse(@response.body)
        pokemons = results["data"]

        assert_equal "SUCCESS", results["status"]
        assert_equal "Bulbasaur", pokemons["name"]
        assert_equal 50, pokemons["attack"]
        assert_equal 50, pokemons["defense"]
    end

    test "should not update an existing pokemon but instead return not found" do
        put "/api/pokemons/999", params: {
            attack: 50,
            defense: 50
        }

        results = JSON.parse(@response.body)

        assert_equal 404, @response.status
        assert_equal "ERROR", results["status"]
    end

    test "should delete an existing pokemon" do
        delete "/api/pokemons/1"

        results = JSON.parse(@response.body)
        pokemons = results["data"]

        assert_equal "SUCCESS", results["status"]
        assert_equal "Bulbasaur", pokemons["name"]
    end

    test "should not delete an existing pokemon but instead return not found" do
        delete "/api/pokemons/999"

        results = JSON.parse(@response.body)

        assert_equal 404, @response.status
        assert_equal "ERROR", results["status"]
    end
end