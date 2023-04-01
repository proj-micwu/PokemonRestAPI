# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'pokemon.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')

csv.each do |row|
    pokemon = Pokemon.where(name: row['Name']).first_or_initialize
    pokemon.type1 = row['Type 1']
    pokemon.type2 = row['Type 2']
    pokemon.total = row['Total']
    pokemon.hp = row['HP']
    pokemon.attack = row['Attack']
    pokemon.defense = row['Defense']
    pokemon.spatk = row['Sp. Atk']
    pokemon.spdef = row['Sp. Def']
    pokemon.speed = row['Speed']
    pokemon.generation = row['Generation']
    pokemon.legendary = row['Legendary']
    pokemon.save
end