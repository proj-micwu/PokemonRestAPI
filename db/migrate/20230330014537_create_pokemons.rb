class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :type1
      t.string :type2
      t.integer :total
      t.integer :hp, default: 0
      t.integer :attack, default: 0
      t.integer :defense, default: 0
      t.integer :spatk, default: 0
      t.integer :spdef, default: 0
      t.integer :speed, default: 0
      t.integer :generation
      t.boolean :legendary

      t.timestamps
    end
  end
end
