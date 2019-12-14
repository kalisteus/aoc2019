INPUT_PATH = File.expand_path('./input/day14.txt', __dir__)



def get_ingredients_list(formulas, quantities, number, product)
  ingredients_hash = Hash.new
  leftover_hash = Hash.new

  ingredients = formulas[product]
  quantity = quantities[product].to_f
  multiplier = (number.to_f/quantity).ceil
  leftover = multiplier * quantity.to_i - number.to_i
  "We have #{leftover} amount left over"

  ingredients.each do |ingredient|
    split_ingredient = ingredient.split(' ')

    if ingredients_hash[split_ingredient[1]].nil? then
      ingredients_hash[split_ingredient[1]] = multiplier * split_ingredient[0].to_i
    else
      ingredients_hash[split_ingredient[1]] += multiplier * split_ingredient[0].to_i
    end
  end

  leftover_hash[product] = leftover if leftover > 0

  return [ingredients_hash, leftover_hash]
end

def calculate_ore(fuel_number)
  formulas = Hash.new
  quantities = Hash.new

  File.foreach(INPUT_PATH) do |line|
    reaction = line.strip.split(' => ')
    inputs = reaction[0].split(', ')
    output = reaction[1]

    output = output.split(' ')
    formulas[output[1]] = inputs
    quantities[output[1]] = output[0]
  end

initial_result = get_ingredients_list(formulas, quantities, fuel_number, "FUEL")
grocery_list = initial_result[0]
leftovers = initial_result[1]
until grocery_list.key?("ORE") && grocery_list.length == 1
  delete_after_loop = []
  grocery_list.each do |key, value|
    # update to the most recent value for a given hash key
    value = grocery_list[key]
    if key != "ORE" then
      grocery_list[key] = 0
      if leftovers.key?(key) && leftovers[key] > 0 then
        available = leftovers[key]
        if available >= value then
          leftovers[key] = available - value
          value = 0
        else
          leftovers[key] = 0
          value -= available
        end
      end
      if value > 0 then
        ing_result = get_ingredients_list(formulas, quantities, value, key)
        grocery_list = grocery_list.merge(ing_result[0]){|key, left, right| left + right}
        leftovers = leftovers.merge(ing_result[1]){|key, left, right| left + right}
      end
      delete_after_loop << key
    end
  end
  delete_after_loop
  delete_after_loop.each do |key|
    grocery_list.delete(key) if grocery_list[key] == 0
  end
end
return grocery_list
end

ore = 0
i = 3281820
while ore < 1000000000000
  prev = ore
  ore = calculate_ore(i)["ORE"]
  i += 1
end
p i-2
