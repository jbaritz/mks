# #ex 2

# recipes = [{
#   title: "apple salad", 
#   serves: 4,
#   ingredients: [
#     {name: "mixed greens", qty: 6, measure: "oz"},
#     {name: "honey mustard", qty: 1, measure: "tbs"},
#     {name: "almonds", qty: 2, measure: "tbs"},
#     {name: "apples", qty: 4, measure: ""},
#     {name: "salt and pepper", qty: "", measure: ""}
#   ]}, {
#   title: "bean burgers", 
#   serves: 4,
#   ingredients: [
#     {name: "black beans", qty: 2, measure: "lbs"},
#     {name: "buns", qty: 4, measure: ""},
#     {name: "lettuce", qty: "", measure: ""},
#     {name: "tomatoes, thinly sliced", qty: 8, measure: ""},
#     {name: "feta cheese", qty: 1, measure: "cup"},
#     {name: "mustard", qty: "", measure: ""}
#   ]}, {
#   title: "avocado soup",
#   serves: 2,
#   ingredients: [
#     {name: "avocado", qty: 1, measure: ""},
#     {name: "soup", qty: 1, measure: ""},
#     {name: "cookies", qty:"", measure: ""}
#   ]}
# ]



# class Recipe
#   def initialize(title, servings)
#     @title, @servings = title, servings
#     @ingredients = []
#   end

#   # def add_ingredient(ingr_name, ingr_qty, ingr_measurement)
#   #   @ingredients << {name: ingr_name, qty: ingr_qty, measure: ingr_measurement}
#   # end
# end

# class Ingredient
#   def initialize(name, units=nil, amount=nil)
#     @name, @units, @amount = name, units, amount
#   end
# end

# recipes = File.read('recipes.txt')
# splitrecipes = recipes.split("\n\n")
# splitrecipes.map! { |recipe| recipe.split("\n") } #splitrecipes becomes three arrays with arrays of lines inside them

# cookbook=[]
# splitrecipes.map { |recipe| #looping through lines in each recipe
#  serves = recipe[1].split #splits "serves 4" into "serves" and "4"
#   x = Recipe.new(recipe.first, serves[1])
#   ingredients = recipe[2..-1] #isolate lines of ingredients
#   ingredients each { |ingrline| #loops through lines of ingredients
#     if ingrline[0].is_a? Integer
#       if
#       end
#     end
#   }
#   ingredients.each do |i|
#     Ingredient.new()
# cookbooks << x
#   }
  
# end


#Nick's solution!
def build_ingredient_hash(string)
  units = ["oz", "lbs", "tbs", "cup"]
  amount = string.to_f
  words = string.split
  if amount.zero?
    return {name: string}
  elsif units.include?(words[1])
    {name: words[2..-1].join(" "), units: words[1], amount: amount}
  else
    {name: words[1..-1].join(" "), units: "", amount: amount}
  end
end

def super_cool_recipe_parser(filename)
  data = File.read(filename)
  recipes = data.split("\n\n")
  recipes.map! {|x| x.split("\n")} #array of arrays containing individual lines of recipes
  recipes.map {|recipe| #loop through lines by recipe
    title = recipe.first
    servings = recipe[1].split.last.to_i #returns serving number as integer 
    ingredients = recipe[2..-1]
    ingredients.map! {|ingr|
      build_ingredient_hash(ingr) #must have a build_ingredient_hash method defined which will build the ingr hashes for each ingr line    }
    }

    {
    title: title,
    servings: servings,
    ingredients: ingredients
    }
  }

end

cookbook = super_cool_recipe_parser('recipes.txt')
p cookbook
